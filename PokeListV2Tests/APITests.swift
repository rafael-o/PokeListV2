import XCTest
import Networking
@testable import PokeListV2

// Simple URLProtocol that returns a predefined response for a given request URL.
final class MockURLProtocol: URLProtocol {
    /// Mapping URL string → (statusCode, Data?)
    nonisolated(unsafe) static var mockResponses: [String: (Int, Data?)] = [:]
    
    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
    
    override func startLoading() {
        guard let url = request.url?.absoluteString,
              let (code, data) = MockURLProtocol.mockResponses[url] else {
            // No mock → 404
            let response = HTTPURLResponse(url: request.url!, statusCode: 404, httpVersion: nil, headerFields: nil)!
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocolDidFinishLoading(self)
            return
        }
        let response = HTTPURLResponse(url: request.url!, statusCode: code, httpVersion: nil, headerFields: nil)!
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        if let data = data {
            client?.urlProtocol(self, didLoad: data)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
}

// Decodable struct used only for test purposes.
private struct TestStruct: Decodable, Equatable {
    let id: Int
    let name: String
}

final class APITests: XCTestCase {
    private var session: URLSession!
    
    override func setUp() {
        super.setUp()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: config)
    }
    
    func testSuccessfulRequestDecodes() async {
        let json = "{\"id\": 42, \"name\": \"TestPokemon\"}"
        let data = Data(json.utf8)
        let testURL = "https://example.com/item"
        MockURLProtocol.mockResponses = [testURL: (200, data)]
        
        let client = APIClient(session: session)
//        let result: TestStruct? = await self.awaitAssert(try await client.request(urlString: testURL, responseType: TestStruct.self))
//        XCTAssertEqual(result?.id, 42)
//        XCTAssertEqual(result?.name, "TestPokemon")
    }
    
    func testInvalidURLThrows() async {
        let client = APIClient(session: session)
        do {
            _ = try await client.request(urlString: "not a url", responseType: TestStruct.self)
            XCTFail("Expected to throw invalidURL")
        } catch let error as APIError {
            guard case .invalidURL = error else { XCTFail("Wrong error: \(error)"); return }
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    func testInvalidResponseThrows() async {
        let testURL = "https://example.com/badstatus"
        MockURLProtocol.mockResponses = [testURL: (500, nil)]
        let client = APIClient(session: session)
        do {
            _ = try await client.request(urlString: testURL, responseType: TestStruct.self)
            XCTFail("Expected invalidResponse error")
        } catch let error as APIError {
            guard case .invalidResponse = error else { XCTFail("Wrong error: \(error)"); return }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testDecodingFailedThrows() async {
        let badJson = """
        {\"unexpected\": \"value\"}
        """
        let data = Data(badJson.utf8)
        let testURL = "https://example.com/baddata"
        MockURLProtocol.mockResponses = [testURL: (200, data)]
        let client = APIClient(session: session)
        do {
            _ = try await client.request(urlString: testURL, responseType: TestStruct.self)
            XCTFail("Expected decodingFailed error")
        } catch let error as APIError {
            guard case .decodingFailed = error else { XCTFail("Wrong error: \(error)"); return }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
