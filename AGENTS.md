# AGENTS.md — Sistema de Memória para Agentes de IA

> Vault Obsidian configurado como memória de projeto. Agentes leem/escrevem aqui seguindo as regras abaixo.

## Tabela de Roteamento — palavra-chave → caminho direto

Quando o usuário falar a palavra-chave, vá **DIRETO** no caminho, sem busca.

| Palavra‑keyword     | Caminho              |
|-------------------|----------------------|
| backlog           | `_Backlog/`          |
| requisitos        | `_Requisitos/`       |
| regras            | `_Regras/`           |
| recursos          | `_Recursos/`         |
| ui                | `_UI/`               |
| funcionalidades   | `_Funcionalidades/`  |
| atividades        | `_Atividades/`       |
| erros             | `_Erros/`            |
| templates         | `_Templates/`        |

> Regra: palavra‑keyword dita = navegação direta. Sem grep, sem glob, sem busca. Só expandir depois se necessário.

## Regras de Leitura

1. **Nunca ler o vault inteiro.** Proibido varrer todas as notas de uma vez.
2. **Sempre buscar antes** com termos específicos (grep/search) para localizar candidatos.
3. **Ler o frontmatter antes do corpo** e filtrar por ele (`area`, `type`, `tags`, `status`).
4. **Ler no máximo os 3–5 resultados mais relevantes** após filtrar. Se precisar de mais, justifique e busque de novo com termos mais específicos.

## Regras de Escrita

1. **Notas atômicas:** 1 conceito = 1 arquivo. Não misturar assuntos.
2. **Nome de arquivo:** `kebab-case` sem acento, sem espaço, sem maiúscula (ex.: `fluxo-de-login.md`).
3. **Sem destino explícito:** toda nota sem destino definido nasce em `_Backlog/` com `status: pendente`.
4. **Conexões:** usar `wikilinks [[assim]]` para conectar notas relacionadas.
5. **Atualização:** ao modificar uma nota, atualizar o campo `updated` no frontmatter para a data/hora atual (`YYYY-MM-DD HH:MM`).

## Frontmatter Padrão (toda nota)

```yaml
---
id: YYYYMMDD-HHMM
title: "Título da nota"
area: backlog | requisitos | regras | recursos | ui | funcionalidades | atividades | erros | templates
type: nota | funcao | erro
tags: []
status: pendente | ativo | concluido
created: YYYY-MM-DD HH:MM
updated: YYYY-MM-DD HH:MM
---
```

> `id` usa o instante de criação no formato `YYYYMMDD-HHMM` (ex.: `20260318-1430`). `created` e `updated` usam `YYYY-MM-DD HH:MM`.

## Comportamento esperado do agente

- Respeitar a Tabela de Roteamento sem exceção.
- Nunca inventar pastas novas.
- Manter notas atômicas e nomes em kebab‑case.
- Sempre atualizar `updated` em edições.
