# PokeListV2

## Visão geral
Este projeto demonstra uma aplicação iOS usando **SwiftUI**, **MVVM+C**, **Swift 6.3.3** e **Swift Data**. Ele é uma nova versão do projeto original https://github.com/rafael-o/PokeList, porém usando apenas componentes e recursos nativos, e atualizando a estrutura e a criação do layout. Inclui ainda um módulo de **networking** local (SPM) para chamadas de API assíncronas e segue boas práticas de arquitetura.

## Estrutura de pastas
```
PokeListV2/
├─ PokeListV2/           # Código da aplicação (App, Features, Models, etc.)
│  ├─ App/               # Arquivos de configuração do app, classe de fluxos
│  ├─ Assets.xcassets/   # Recursos e imagens
│  ├─ Core/              # Componentes globais
│  ├─ Features/          # Funcionalidades separadas por views
│  └─ Models/            # Modelos reutilizáveis
├─ Networking/           # Pacote SwiftPM local para chamadas de API
├─ PokeListV2Tests/      # Testes unitários
├─ PokeListV2UITests/    # Testes de UI (XCUITest)
├─ PokeListV2.xcodeproj/ # Projeto Xcode
├─ CODE_GUIDELINES.md
├─ LICENSE
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
- **Testes unitários** – já incluídos em `PokeListV2Tests/`.
- **Testes de UI** – implementados em `PokeListV2UITests/`.

> Nota: nem todos os testes estão funcionais atualmente e serão revisados futuramente.

## Convenções de código
Veja o arquivo **CODE_GUIDELINES.md** para padrões de nomenclatura, uso de `async/await`, organização de arquivos e fluxo de trabalho com Git.

## Como rodar o projeto
```bash
# Clone o repositório
git clone <repo-url>
cd PokeListV2

# Abrir no Xcode
open PokeListV2.xcodeproj

# Adicionar o pacote de networking conforme descrito acima, caso este não esteja presente nas dependências.

# Build e execute
Cmd+R
```

---
