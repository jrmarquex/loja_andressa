# Como Capturar Screenshots dos Modelos

Este guia explica como capturar screenshots dos modelos de loja para usar no catálogo.

## Opção 1: Usando Node.js (Puppeteer) - Recomendado

### Pré-requisitos:
- Node.js instalado
- npm instalado

### Passos:

1. Instalar dependências:
```bash
npm install
```

2. Executar o script:
```bash
npm run screenshot
```

ou

```bash
node capture-screenshots.js
```

## Opção 2: Usando Python (Selenium)

### Pré-requisitos:
- Python 3 instalado
- Chrome/Chromium instalado
- ChromeDriver instalado

### Passos:

1. Instalar dependências:
```bash
pip install selenium pillow
```

2. Executar o script:
```bash
python capture-screenshots-python.py
```

## Opção 3: Manual (Navegador)

1. Abra cada arquivo HTML no navegador
2. Use uma extensão de screenshot (como "Full Page Screen Capture" para Chrome)
3. Capture apenas a parte superior do site (primeira tela visível)
4. Salve as imagens com os nomes:
   - `preview-modelo-1.jpg`
   - `preview-modelo-3.jpg`
   - `preview-modelo-4.jpg`
   - `preview-modelo-5.jpg`
   - `preview-modelo-6.jpg`
   - `preview-modelo-7.jpg`
   - `preview-modelo-8.jpg`

5. Coloque as imagens na mesma pasta do `index.html`

## Dicas:

- As imagens devem ter aproximadamente 1200x800 pixels
- Formato JPEG com qualidade 90
- Capture apenas a primeira parte visível do site (header + hero section)
- Certifique-se de que as imagens estão na mesma pasta do index.html

