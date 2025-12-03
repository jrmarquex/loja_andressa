const puppeteer = require('puppeteer');
const path = require('path');
const fs = require('fs');

// Configuração dos modelos para capturar
const models = [
    {
        file: 'Clothing Category _ Shopkeeper Main Demo.html',
        output: 'preview-modelo-1.jpg',
        name: 'Modelo 1'
    },
    {
        file: 'Fashion shop minimal – Just another WordPress site.html',
        output: 'preview-modelo-3.jpg',
        name: 'Modelo 3'
    },
    {
        file: 'Shop Creative Fashion – Creative High-Performance Multi-Purpose WordPress Theme.html',
        output: 'preview-modelo-4.jpg',
        name: 'Modelo 4'
    },
    {
        file: 'modelo-5-premium-minimalista.html',
        output: 'preview-modelo-5.jpg',
        name: 'Modelo 5'
    },
    {
        file: 'modelo-6-modern-grid.html',
        output: 'preview-modelo-6.jpg',
        name: 'Modelo 6'
    },
    {
        file: 'modelo-7-magazine-style.html',
        output: 'preview-modelo-7.jpg',
        name: 'Modelo 7'
    },
    {
        file: 'modelo-8-dashboard-style.html',
        output: 'preview-modelo-8.jpg',
        name: 'Modelo 8'
    }
];

async function captureScreenshots() {
    console.log('🚀 Iniciando captura de screenshots...\n');
    
    const browser = await puppeteer.launch({
        headless: true,
        args: ['--no-sandbox', '--disable-setuid-sandbox']
    });

    for (const model of models) {
        try {
            console.log(`📸 Capturando ${model.name}...`);
            
            const filePath = path.join(__dirname, model.file);
            
            // Verificar se o arquivo existe
            if (!fs.existsSync(filePath)) {
                console.log(`   ⚠️  Arquivo não encontrado: ${model.file}`);
                continue;
            }

            const page = await browser.newPage();
            
            // Configurar viewport
            await page.setViewport({
                width: 1200,
                height: 800,
                deviceScaleFactor: 2
            });

            // Carregar o arquivo HTML local
            const fileUrl = `file://${filePath}`;
            await page.goto(fileUrl, {
                waitUntil: 'networkidle0',
                timeout: 30000
            });

            // Aguardar um pouco para garantir que tudo carregou
            await new Promise(resolve => setTimeout(resolve, 2000));

            // Capturar screenshot da primeira parte do site (topo)
            const outputPath = path.join(__dirname, model.output);
            await page.screenshot({
                path: outputPath,
                quality: 90,
                type: 'jpeg',
                clip: {
                    x: 0,
                    y: 0,
                    width: 1200,
                    height: 800
                }
            });

            console.log(`   ✅ Screenshot salvo: ${model.output}\n`);
            
            await page.close();
        } catch (error) {
            console.log(`   ❌ Erro ao capturar ${model.name}: ${error.message}\n`);
        }
    }

    await browser.close();
    console.log('✨ Captura de screenshots concluída!');
}

// Executar
captureScreenshots().catch(console.error);

