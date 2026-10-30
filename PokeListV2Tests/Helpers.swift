import XCTest
import Networking

// Convenience await helper for XCTestCase to simplify async assertions.
extension XCTestCase {
    /// Awaits an async expression and fails the test if it throws.
    func awaitAssert<T>(_ expression: @autoclosure () async throws -> T, file: StaticString = #file, line: UInt = #line) async -> T? {
        do {
            return try await expression()
        } catch {
            XCTFail("Unexpected error: \(error)", file: file, line: line)
            return nil
        }
    }
}
