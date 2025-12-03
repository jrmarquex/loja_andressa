# Script PowerShell para capturar screenshots usando Selenium WebDriver
# Requer: Install-Module Selenium

Write-Host "🚀 Iniciando captura de screenshots..." -ForegroundColor Cyan
Write-Host ""

# Verificar se Selenium está instalado
try {
    Import-Module Selenium -ErrorAction Stop
} catch {
    Write-Host "⚠️  Módulo Selenium não encontrado." -ForegroundColor Yellow
    Write-Host "Instale com: Install-Module Selenium" -ForegroundColor Yellow
    exit
}

# Configuração dos modelos
$models = @(
    @{file='Clothing Category _ Shopkeeper Main Demo.html'; output='preview-modelo-1.jpg'; name='Modelo 1'},
    @{file='Fashion shop minimal – Just another WordPress site.html'; output='preview-modelo-3.jpg'; name='Modelo 3'},
    @{file='Shop Creative Fashion – Creative High-Performance Multi-Purpose WordPress Theme.html'; output='preview-modelo-4.jpg'; name='Modelo 4'},
    @{file='modelo-5-premium-minimalista.html'; output='preview-modelo-5.jpg'; name='Modelo 5'},
    @{file='modelo-6-modern-grid.html'; output='preview-modelo-6.jpg'; name='Modelo 6'},
    @{file='modelo-7-magazine-style.html'; output='preview-modelo-7.jpg'; name='Modelo 7'},
    @{file='modelo-8-dashboard-style.html'; output='preview-modelo-8.jpg'; name='Modelo 8'}
)

$basePath = Get-Location

# Configurar Chrome
$chromeOptions = New-Object OpenQA.Selenium.Chrome.ChromeOptions
$chromeOptions.AddArgument('--headless')
$chromeOptions.AddArgument('--window-size=1200,800')
$chromeOptions.AddArgument('--disable-gpu')

try {
    $driver = New-Object OpenQA.Selenium.Chrome.ChromeDriver($chromeOptions)
    
    foreach ($model in $models) {
        try {
            Write-Host "📸 Capturando $($model.name)..." -ForegroundColor Yellow
            
            $filePath = Join-Path $basePath $model.file
            
            if (-not (Test-Path $filePath)) {
                Write-Host "   ⚠️  Arquivo não encontrado: $($model.file)" -ForegroundColor Red
                continue
            }
            
            # Carregar arquivo HTML local
            $fileUrl = "file:///$($filePath.Replace('\', '/'))"
            $driver.Navigate().GoToUrl($fileUrl)
            
            # Aguardar carregamento
            Start-Sleep -Seconds 3
            
            # Capturar screenshot
            $outputPath = Join-Path $basePath $model.output
            $screenshot = $driver.GetScreenshot()
            $screenshot.SaveAsFile($outputPath, [OpenQA.Selenium.ScreenshotImageFormat]::Jpeg)
            
            Write-Host "   ✅ Screenshot salvo: $($model.output)" -ForegroundColor Green
            Write-Host ""
            
        } catch {
            Write-Host "   ❌ Erro ao capturar $($model.name): $($_.Exception.Message)" -ForegroundColor Red
            Write-Host ""
        }
    }
    
    $driver.Quit()
    Write-Host "✨ Captura de screenshots concluída!" -ForegroundColor Green
    
} catch {
    Write-Host "❌ Erro ao inicializar Chrome: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host ""
    Write-Host "💡 Alternativa: Use o script Node.js ou Python, ou capture manualmente." -ForegroundColor Yellow
}

