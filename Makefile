.PHONY: help install run dev docker-build docker-up docker-down test clean

help:
	@echo "TopWise - Task Manager"
	@echo ""
	@echo "Comandos disponibles:"
	@echo "  make install       - Instalar dependencias"
	@echo "  make run          - Ejecutar la aplicación en producción"
	@echo "  make dev          - Ejecutar en modo desarrollo"
	@echo "  make docker-build - Construir imagen Docker"
	@echo "  make docker-up    - Ejecutar con Docker Compose"
	@echo "  make docker-down  - Detener containers Docker"
	@echo "  make test         - Ejecutar tests"
	@echo "  make clean        - Limpiar archivos generados"

install:
	cd task_manager && pip install -r requirements.txt

run:
	cd task_manager && python app.py

dev:
	cd task_manager && FLASK_ENV=development FLASK_DEBUG=True python app.py

docker-build:
	docker build -t topwise:latest .

docker-up:
	docker-compose up -d && echo "✓ TopWise está corriendo en http://localhost:5000"

docker-down:
	docker-compose down

docker-logs:
	docker-compose logs -f

test:
	cd task_manager && python -m pytest tests/ -v

clean:
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete
	find . -type f -name ".pytest_cache" -delete
	find . -type f -name "*.sqlite3" -delete
	find . -type f -name "*.db" -delete
	@echo "✓ Limpieza completada"

fresh: clean install
	@echo "✓ Entorno fresco listo"

reset-db:
	rm -f task_manager/instance/*.db task_manager/*.db
	@echo "✓ Base de datos eliminada"

.PHONY: help install run dev docker-build docker-up docker-down docker-logs test clean fresh reset-db
