"""
Script Python para capturar screenshots dos modelos usando Selenium
Requer: pip install selenium pillow
"""

from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from PIL import Image
import time
import os
from pathlib import Path

# Configuração dos modelos
models = [
    {
        'file': 'Clothing Category _ Shopkeeper Main Demo.html',
        'output': 'preview-modelo-1.jpg',
        'name': 'Modelo 1'
    },
    {
        'file': 'Fashion shop minimal – Just another WordPress site.html',
        'output': 'preview-modelo-3.jpg',
        'name': 'Modelo 3'
    },
    {
        'file': 'Shop Creative Fashion – Creative High-Performance Multi-Purpose WordPress Theme.html',
        'output': 'preview-modelo-4.jpg',
        'name': 'Modelo 4'
    },
    {
        'file': 'modelo-5-premium-minimalista.html',
        'output': 'preview-modelo-5.jpg',
        'name': 'Modelo 5'
    },
    {
        'file': 'modelo-6-modern-grid.html',
        'output': 'preview-modelo-6.jpg',
        'name': 'Modelo 6'
    },
    {
        'file': 'modelo-7-magazine-style.html',
        'output': 'preview-modelo-7.jpg',
        'name': 'Modelo 7'
    },
    {
        'file': 'modelo-8-dashboard-style.html',
        'output': 'preview-modelo-8.jpg',
        'name': 'Modelo 8'
    }
]

def capture_screenshots():
    print('🚀 Iniciando captura de screenshots...\n')
    
    # Configurar Chrome
    chrome_options = Options()
    chrome_options.add_argument('--headless')
    chrome_options.add_argument('--no-sandbox')
    chrome_options.add_argument('--disable-dev-shm-usage')
    chrome_options.add_argument('--window-size=1200,800')
    
    driver = webdriver.Chrome(options=chrome_options)
    
    base_path = Path(__file__).parent.absolute()
    
    for model in models:
        try:
            print(f"📸 Capturando {model['name']}...")
            
            file_path = base_path / model['file']
            
            if not file_path.exists():
                print(f"   ⚠️  Arquivo não encontrado: {model['file']}")
                continue
            
            # Carregar arquivo HTML local
            file_url = f"file:///{file_path.as_posix()}"
            driver.get(file_url)
            
            # Aguardar carregamento
            time.sleep(3)
            
            # Capturar screenshot
            output_path = base_path / model['output']
            driver.save_screenshot(str(output_path))
            
            # Converter para JPEG e otimizar
            img = Image.open(output_path)
            if img.mode != 'RGB':
                img = img.convert('RGB')
            
            # Recortar para mostrar apenas o topo (primeira parte)
            img_cropped = img.crop((0, 0, 1200, 800))
            img_cropped.save(output_path, 'JPEG', quality=90, optimize=True)
            
            print(f"   ✅ Screenshot salvo: {model['output']}\n")
            
        except Exception as e:
            print(f"   ❌ Erro ao capturar {model['name']}: {str(e)}\n")
    
    driver.quit()
    print('✨ Captura de screenshots concluída!')

if __name__ == '__main__':
    capture_screenshots()

