# Código e Convenções

## Estrutura de Pastas
- **App/** – arquivos de configuração do app, classe de fluxos.
- **Core/** – componentes globais do app, separados por funcionalidades (Navigation, etc.).
- **Features/** – código de produção, organizado por telas (Home, Detail, Favorites, etc.).
- **Models/** – Modelos usados por mais de uma classe ou view.
- **Tests/** – testes unitários.
- **UITests/** – testes de interface de usuário.
- **Networking/** – módulo SwiftPM local para chamadas de API.

## Convenções de Nomenclatura
- **Tipos e structs**: `PascalCase` (ex.: `Pokemon`, `APIClient`).
- **Propriedades e variáveis**: `camelCase`.
- **Funções assíncronas**: terminam com `Async` quando necessário (ex.: `fetchPokemonsAsync`).
- **Arquivos**: nome em `kebab-case` correspondente ao tipo (ex.: `pokemon-list-view.swift`).

## Boas‑práticas de Código
- Use `async/await` para operações de rede.
- Cada `View` deve receber seu `ViewModel` via `@StateObject` ou `@ObservedObject`.
- Mantenha a lógica de negócio fora das `Views`, dentro dos `ViewModels` ou serviços.
- Trate erros de forma explícita usando `Result` ou `throws`.
- Documente funções públicas com comentários Swift‑Doc.

## Controle de Versão
- Commits atômicos e descritivos.
- Branches por feature (`feature/<nome>`).
- Pull‑requests revisados antes de merge.

---
