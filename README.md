# PokeListV2

## Visão geral
Este projeto demonstra uma aplicação iOS usando **SwiftUI**, **MVVM+C** e **Swift 6.3.3**. Ele inclui um módulo de **networking** local (SPM) para chamadas de API assíncronas e segue boas práticas de arquitetura.

## Estrutura de pastas
```
ProjectRoot/
├─ Sources/
│  ├─ Models/            # Modelos de domínio (ex.: Pokemon)
│  ├─ Views/             # SwiftUI Views
│  ├─ ViewModels/        # ViewModels com lógica de negócios
│  └─ Coordinators/      # Coordinadores de navegação
├─ Resources/            # Assets, imagens, etc.
├─ Networking/          # Módulo SwiftPM local para chamadas de API
├─ PokeListV2/           # Código da aplicação (App, ContentView, etc.)
├─ PokeListV2Tests/      # Testes unitários
├─ PokeListV2UITests/    # Testes de UI (XCUITest)
└─ CODE_GUIDELINES.md   # Convenções de código
```

## Módulo de networking (SPM local)
O diretório **Networking** contém um pacote Swift com:
- `APIError` – enumeração de erros de rede.
- `APIClient` – classe que executa requisições usando `URLSession` e `async/await`.

### Como usar
```swift
import Networking

let client = APIClient()
Task {
    do {
        let pokemon: Pokemon = try await client.request(urlString: "https://pokeapi.co/api/v2/pokemon/1", responseType: Pokemon.self)
        print(pokemon)
    } catch {
        print("Erro: \(error)")
    }
}
```

### Adicionar ao Xcode (local)
1. No Xcode, **File > Swift Packages > Add Package Dependency…**
2. Selecione **Add Local…** e escolha a pasta `Networking` na raiz do repositório.
3. Selecione o produto **Networking** e adicione-o ao alvo `PokeListV2`.

## Testes
- **Testes unitários** – já incluídos em `PokeListV2Tests/PokemonModelTests.swift`.
- **Testes de UI** – implementados em `PokeListV2UITests/PokemonListUITests.swift`. Eles verificam a navegação da lista para a tela de detalhe.

## Convenções de código
Veja o arquivo **CODE_GUIDELINES.md** para padrões de nomenclatura, uso de `async/await`, organização de arquivos e fluxo de trabalho com Git.

## Como rodar o projeto
```bash
# Clone o repositório
git clone <repo-url>
cd PokeListV2

# Abrir no Xcode
open PokeListV2.xcodeproj

# (Opcional) Adicionar o pacote de networking conforme descrito acima.

# Build e execute
Cmd+R
```

---
