# Instruções para Agentes de IA - "A ROSA" Crowdfunding Campaign Website

## Visão Geral do Projeto

Este é um **website estático** para a campanha de crowdfunding do curta-metragem de animação "A ROSA" (sem uso de servidores, bancos de dados ou JavaScript dinâmico significativo). O projeto é organizado em um site principal + múltiplas páginas de recompensas com um sistema de navegação coeso baseado em temas florais.

## Arquitetura e Estrutura

### Diretório Raiz

- **`index.html`**: Página principal (home) - apresenta a campanha, orçamento com gráficos Chart.js, cronograma visual e informações do autor
- **`styles.css`**: CSS global que estiliza a navegação (barra com fundo vermelho `#C70039`) e containers de gráficos
- **`README.md`**: Documentação básica do projeto e guia de visualização

### Subsistema de Recompensas

Cada nível de recompensa tem seu próprio diretório com `index.html` independente:

- **`recompensa-semente/`**: Nível de R$ (wallpaper + crédito redes sociais)
- **`recompensa-o-broto/`**: Nível intermediário baixo
- **`recompensa-o-espinho/`**: Nível intermediário alto
- **`recompensa-o-buque-de-rosas/`**: Nível premium
- **`recompensa-o-mestre-jardineiro/`**: Nível máximo
- **`pagina-de-apoio-campanha-crowdfounding/`**: Central de visualização/seleção de recompensas

### Metas Estendidas

- **`metas-estendidas/index.html`**: Página dedicada a stretch goals (em R$ 110K, R$ 130K, etc.) com ícones emoji, layouts de impacto e conteúdo exclusivo detalhado

### Suporte

- **`audio/`**: Arquivos de podcast (conteúdo complementar sobre bastidores e inspirações)
- **`doc/`**: Documentação interna (plano estratégico, arquivos de referência)
- **`favicon/`**: Logotipos em múltiplos tamanhos (99x99px PNG)

## Stack Tecnológico

- **CSS Framework**: Tailwind CDN (`https://cdn.tailwindcss.com`) - classes utilitárias apenas
- **Gráficos**: Chart.js CDN para visualização de orçamento (donut e bar charts em `index.html`)
- **Fontes**: Google Fonts - family `Inter` (weights: 400, 600, 700, 800, 900)
- **Sem frameworks**: Nenhum Vue, React, ou JavaScript complexo
- **Compatibilidade**: Navegadores modernos; renderização estática completa

## Padrões de Design e Convenções

### Palette de Cores (Temática Floral)

- **Primária (Rosa)**: `#C70039` - navegação, botões principais
- **Secundária (Ciano/Teal)**: `#4ECDC4` e `#45B7D1` - destaques, acentos
- **Terciária (Coral/Vermelho)**: `#FF6B6B` - metas estendidas, elementos importantes
- **Fundos**: `#bg-gray-100`, `#bg-gray-50`, `#bg-white`

### Estrutura HTML Comum

Todas as páginas seguem o padrão:

```html
<!DOCTYPE html>
<html lang="pt-BR">
  <head>
    <!-- Meta tags, Tailwind CDN, fonts, favicon, styles.css -->
  </head>
  <body class="bg-gray-100 text-gray-800">
    <header>
      <nav><!-- com links relativos corretos --></nav>
    </header>
    <div class="container mx-auto p-4 md:p-8">
      <!-- Conteúdo principal -->
    </div>
  </body>
</html>
```

### Navegação Responsiva

- Barra `nav` com fundo `#C70039`, links brancos, hover com `rgba(255, 255, 255, 0.15)`
- Links são **relativos** (`../`, `./`), não absolutos - crítico para multi-página
- Cada página de recompensa inclui link "Voltar à Campanha" com ícone SVG

### Componentes Reutilizáveis

- **Cards**: `bg-white rounded-2xl shadow-lg p-8 md:p-12` (main sections)
- **Gradientes**: Fundos suaves `from-COLOR/10 to-COLOR/5` com bordes `border-COLOR/20`
- **Ícones Emoji**: Semente 🌱, Broto 🌱, Espinho, Buquê 🌹, Mestre Jardineiro 👨‍🌾, etc.
- **Buttons**: `bg-[#COLOR] text-white font-semibold py-2 px-4 rounded-full hover:bg-darker-shade`

## Padrões de Conteúdo

### Tema da Campanha

A campanha usa uma **metáfora botânica** para os níveis de recompensa:

- Semente → Broto → Espinho → Buquê de Rosas → Mestre Jardineiro (progressão crescente)

Todos os textos refletem essa narrativa poética (ex: "Sua semente fez a arte florescer").

### Páginas de Recompensa

Cada página de recompensa inclui:

- **Header** com emoji temático grande (🌱, etc.)
- **Título descritivo** do nível
- **Seções de benefícios** em cards brancos com bordas coloridas
- **Descrições de itens exclusivos** (wallpapers, créditos, conteúdo digital, etc.)
- **Footer com mensagem temática**

### Metas Estendidas

Cada meta estendida tem:

- **Ícone emoji** grande (🌍, 🎬, etc.)
- **Valor da meta** em R$ e nome descritivo
- **Grid com descrição + "Impacto" visual** (side-by-side)
- **Listas de benefícios** com bullet points temáticos

## Fluxos de Desenvolvimento Comuns

### Adicionar Nova Página de Recompensa

1. Copiar estrutura de `recompensa-semente/index.html`
2. Atualizar título, emoji, descrição, benefícios
3. **Adicionar links na navegação** de todas as páginas existentes (use `../recompensa-novo/index.html`)
4. Manter paleta de cores consistente (usar `#FF6B6B`, `#C70039`, ou `#4ECDC4` para destaques)
5. Testar links relativos em navegação

### Atualizar Gráficos de Orçamento

- Arquivo: [index.html](index.html#L80-L120) - gráficos Chart.js (donut + bar)
- **Modificar inline**: dados dos gráficos estão em tags `<canvas>` com IDs `budgetDonutChart` e `budgetBarChart`
- Buscar o script JavaScript que popula os dados (provavelmente antes da tag `</body>`)

### Modificar Cores Globais

- Atualize `styles.css` para barra de navegação
- Use classes Tailwind inline para outros elementos (não há arquivo CSS separado para isso)
- Paleta pode ser alterada via classe inline: `text-[#CUSTOM_COLOR]`, `bg-[#CUSTOM_COLOR]`

### Adicionar Conteúdo de Metas Estendidas

- Arquivo: [metas-estendidas/index.html](metas-estendidas/index.html)
- Padrão: Cada meta é uma `<section>` com grid de 2 colunas (responsive)
- Incluir emoji grande, valor em R$, título, descrição e lista de benefícios

## Checklist para Mudanças

Ao fazer qualquer modificação:

- [ ] **Links relativos funcionam**: teste navegação entre páginas (especialmente `../`)
- [ ] **Consistência de cores**: use apenas cores definidas na paleta (verifique `#C70039`, `#4ECDC4`, `#FF6B6B`)
- [ ] **Responsive design**: seções usam `md:` breakpoints e `grid grid-cols-1 md:grid-cols-2`
- [ ] **Favicon links atualizados**: se adicionar página novo diretório, ajustar href do favicon
- [ ] **HTML semântico**: use `<header>`, `<main>`, `<section>`, `<footer>` apropriadamente
- [ ] **Meta viewport**: todas as páginas têm `<meta name="viewport" content="width=device-width, initial-scale=1.0">`

## Arquivos Críticos e Seu Propósito

| Arquivo                                                    | Propósito                                    | Modificar se...                                             |
| ---------------------------------------------------------- | -------------------------------------------- | ----------------------------------------------------------- |
| [index.html](index.html)                                   | Home principal, orçamento, cronograma        | Atualizar meta de arrecadação, adicionar seções de campanha |
| [styles.css](styles.css)                                   | Estilo global (nav, fonts, chart containers) | Alterar cores da navegação ou espaçamento global            |
| [README.md](README.md)                                     | Documentação do projeto                      | Orientações mudarem ou novo fluxo de setup                  |
| [metas-estendidas/index.html](metas-estendidas/index.html) | Metas de extensão de campanha                | Adicionar/remover metas estendidas                          |
| `recompensa-*/index.html`                                  | Páginas de recompensa individuais            | Criar novo nível, atualizar benefícios, remover nível       |

## Dicas para Produtividade

1. **Sempre preservar estrutura de navegação**: Se adicionar página, atualize `<nav>` em TODAS as existentes
2. **Teste links antes de commitar**: Especialmente caminhos `../` para páginas em subdiretórios
3. **Use variáveis de cor**: Mantenha a paleta consistente (não invente cores novas)
4. **Valide HTML**: Estrutura é simples, mas erros sintáticos quebram renderização
5. **Chart.js é estático**: Dados de gráficos são hardcoded; para dados dinâmicos, seria necessário JavaScript
