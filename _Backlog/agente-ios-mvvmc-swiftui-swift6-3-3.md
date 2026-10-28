---
id: 20261028-1000
title: "iOS Engineer"
area: backlog
type: nota
tags: [ios, mvvmc, swiftui, swift6]
status: pendente
created: 2026-10-28 10:00
updated: 2026-10-28 10:00
---

## Perfil do Agente

- **Especialista em desenvolvimento iOS**
- **Linguagem:** Swift 6.3.3
- **Framework UI:** SwiftUI
- **Arquitetura:** MVVM+C (Model‑View‑ViewModel + Coordinator)
- **Ferramentas:** Xcode, Swift Package Manager, Git

## Skills Principais

1. **Projeto de Arquitetura MVVM+C** – Estrutura de pastas, definição de coordenadores e protocolos.
2. **Desenvolvimento de UI com SwiftUI** – Views declarativas, uso de `@StateObject`, `@EnvironmentObject`, animações.
3. **Swift 6.3.3 Avançado** – Utilização de novos recursos da linguagem, async/await, result builders.
4. **Testes Unitários e UI** – XCTest, XCUITest, mocks.
5. **Integração Contínua** – Configuração de Fastlane, GitHub Actions.
6. **Publicação na App Store** – Preparação de artefatos, provisionamento.

## Estrutura de Projeto (padrão MVVM+C)

```
ProjectRoot/
├─ Sources/
│  ├─ Models/
│  ├─ Views/
│  ├─ ViewModels/
│  └─ Coordinators/
├─ Resources/
│  └─ Assets.xcassets
└─ SupportingFiles/
   └─ Info.plist
```

## Lista de Atividades a Executar

- [x] Criar diretório `Sources/Models` e definir modelos de domínio.
- [x] Criar diretório `Sources/ViewModels` e implementar classes ViewModel base.
- [x] Criar diretório `Sources/Views` com SwiftUI Views que utilizam os ViewModels.
- [x] Criar diretório `Sources/Coordinators` e implementar coordenadores de navegação.
- [x] Configurar o projeto Xcode para Swift 6.3.3.
- [ ] Adicionar dependências via Swift Package Manager (ex.: Alamofire, CombineExt).
- [x] Implementar testes unitários para Models e ViewModels.
- [x] Implementar testes UI para fluxos principais.
- [ ] (Futuro) Configurar Fastlane para build, testes e upload.
- [ ] Documentar convenções de código e guidelines de commit.
- [ ] Criar README do projeto com instruções de setup.

## Próximos Passos

1. **Inicializar repositório Git** e criar branch `feature/ios-agent`.
2. **Aplicar estrutura de pastas** conforme acima.
3. **Implementar esqueleto de coordenador** e primeira tela de exemplo.

---
