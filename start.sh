#!/bin/bash

# Script de inicio rápido para TopWise
# Este script configura y ejecuta la aplicación

set -e

echo "🚀 TopWise - Task Manager"
echo "=========================="
echo ""

# Detectar el sistema operativo
if [[ "$OSTYPE" == "linux-gnu"* ]] || [[ "$OSTYPE" == "darwin"* ]]; then
    # Linux o macOS
    
    # Check if Docker is installed
    if command -v docker &> /dev/null && command -v docker-compose &> /dev/null; then
        echo "📦 Docker encontrado. Usando Docker Compose..."
        echo ""
        docker-compose up
    else
        echo "🐍 Docker no encontrado. Iniciando en modo local..."
        echo ""
        
        # Instalar dependencias si no existen
        if [ ! -d "task_manager/venv" ]; then
            echo "📥 Creando entorno virtual..."
            cd task_manager
            python3 -m venv venv
            source venv/bin/activate
            pip install -r requirements.txt
            cd ..
        fi
        
        echo "▶️  Iniciando aplicación..."
        cd task_manager
        source venv/bin/activate
        python app.py
    fi
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
    # Windows
    echo "🪟 Sistema Windows detectado..."
    echo ""
    
    if command -v docker &> /dev/null && command -v docker-compose &> /dev/null; then
        echo "📦 Docker encontrado. Usando Docker Compose..."
        echo ""
        docker-compose up
    else
        echo "🐍 Iniciando en modo local..."
        echo ""
        
        if not exist "task_manager\venv" (
            echo "📥 Creando entorno virtual..."
            cd task_manager
            python -m venv venv
            call venv\Scripts\activate.bat
            pip install -r requirements.txt
            cd ..
        )
        
        echo "▶️  Iniciando aplicación..."
        cd task_manager
        call venv\Scripts\activate.bat
        python app.py
    fi
else
    echo "❌ Sistema operativo no soportado"
    exit 1
fi
