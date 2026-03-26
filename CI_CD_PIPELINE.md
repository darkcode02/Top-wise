# 🚀 Pipeline CI/CD - Azure DevOps

Documentación completa del pipeline de Azure DevOps que automáticamente construye y publica la imagen Docker en Docker Hub.

## 📋 Configuración General

```
Variables principales:
- Python Version: 3.11
- Imagen Docker: topwise-task-manager
- Docker Hub User: darkcode02
- Registry Service Connection: docker-SC
```

## 🔄 Flujo del Pipeline

```
┌─────────────────────────────────────────────────────────┐
│         CONTROL DE CALIDAD (Quality)                   │
│  - Build, Test, Validación, Análisis de Código         │
│  - Black, Flake8, Pylint, pytest                       │
└─────────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────┐
│         BUILD Y PUBLISH DOCKER (Docker)                │
│  - Construir imagen Docker                            │
│  - Push a Docker Hub (main/develop)                   │
│  - Tags automáticos                                   │
└─────────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────┐
│         NOTIFICACIONES (Notification)                  │
│  - Resumen del Pipeline                               │
│  - Estado de ejecución                                │
└─────────────────────────────────────────────────────────┘
```

## 🎯 Etapas del Pipeline

### 1️⃣ **Quality Control** (Calidad)

Validación de código y tests:

**Pasos:**
- ✅ Instalar Python 3.11
- ✅ Instalar dependencias (`requirements.txt`)
- ✅ Validar formato con **Black**
- ✅ Análisis estático con **Flake8**
- ✅ Análisis profundo con **Pylint**
- ✅ Ejecutar tests unitarios con **pytest**
- ✅ Generar reporte de cobertura
- ✅ Publicar resultados en Azure DevOps

### 2️⃣ **Docker Build** (Construcción)

Construcción de la imagen Docker:

**Pasos:**
- ✅ Compilar Dockerfile
- ✅ Incluir metadatos (BUILD_DATE, VERSION, VCS_REF)
- ✅ Verificar imagen creada

### 3️⃣ **Docker Push** (Publicación)

Publicar en Docker Hub según la rama:

**RAMA `main` 🔴 (Producción)**
```
Docker Hub: darkcode02/topwise-task-manager:latest
           darkcode02/topwise-task-manager:{BuildId}
           darkcode02/topwise-task-manager:v1.0.0
```

**RAMA `develop` 🟡 (Desarrollo)**
```
Docker Hub: darkcode02/topwise-task-manager:develop
           darkcode02/topwise-task-manager:develop-{BuildId}
```

### 4️⃣ **Notifications** (Notificaciones)

Resumen final del pipeline con estado de ejecución.

---

## 📊 Mejoras Implementadas

### ✨ Optimizaciones

| Aspecto | Antes | Después |
|---------|-------|---------|
| **Control de Calidad** | Solo tests | Black + Flake8 + Pylint + pytest |
| **Tags Docker** | `latest`, `BuildId` | `latest`, `BuildId`, `v1.0.0` (main) |
| | | `develop`, `develop-BuildId` (develop) |
| **Manejo de ramas** | Separado | Integrado en un job |
| **Metadatos** | No incluidos | BUILD_DATE, VERSION, VCS_REF |
| **Validación** | Básica | Completa con múltiples herramientas |
| **Reportes** | Tests solo | Tests + Cobertura + Notificaciones |
| **Imagen Docker Hub** | `task-manager` | `topwise-task-manager` (más descriptivo) |

---

## 🔐 Requisitos Previos

### En Azure DevOps

1. **Service Connection Docker**
   - Nombre: `docker-SC`
   - Tipo: Docker Registry
   - URL: `https://index.docker.io/v1/`
   - Usuario: Tu usuario de Docker Hub
   - Contraseña: Tu token/contraseña de Docker Hub

2. **Repositorio Git**
   - Ramas: `main` y `develop`
   - Archivo: `pipelines/azure-pipelines.yaml`

### En Docker Hub

- Usuario: `darkcode02`
- Repositorio: `topwise-task-manager`
- Acceso: Público o Privado (según necesidad)

---

## 📦 Estructura de la Imagen Docker

```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY task_manager/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY task_manager/ .
EXPOSE 5000
ENV FLASK_APP=app.py
ENV PYTHONUNBUFFERED=1
CMD ["python", "app.py"]
```

**Dependencias actualizadas:**
- Flask>=3.1.0
- Flask-SQLAlchemy==3.1.1
- werkzeug>=3.0.0

---

## 🚀 Flujo de Trabajo Recomendado

### Para Desarrollo (develop)

```bash
# 1. Crear rama de feature
git checkout -b feature/mi-feature

# 2. Hacer cambios y commits
git commit -m "feat: agregar nueva funcionalidad"

# 3. Push a develop
git push origin feature/mi-feature
git checkout develop
git merge feature/mi-feature
git push origin develop

# ✨ El pipeline ejecuta automáticamente:
# - Tests y validación
# - Build Docker image
# - Push a Docker Hub con tag: develop-{BuildId}
```

### Para Producción (main)

```bash
# 1. Mergear desde develop a main (Pull Request)
git checkout main
git merge develop
git push origin main

# ✨ El pipeline ejecuta automáticamente:
# - Tests y validación
# - Build Docker image
# - Push a Docker Hub con tags: latest, {BuildId}, v1.0.0
```

---

## 🐳 Usar la Imagen Publicada

### Pull desde Docker Hub

```bash
# Última versión de producción
docker pull darkcode02/topwise-task-manager:latest

# Versión específica
docker pull darkcode02/topwise-task-manager:1234

# Versión de desarrollo
docker pull darkcode02/topwise-task-manager:develop
```

### Ejecutar la Imagen

```bash
# Opción 1: Ejecutar directamente
docker run -p 5000:5000 darkcode02/topwise-task-manager:latest

# Opción 2: Usar docker-compose con imagen remota
docker-compose pull
docker-compose up

# Opción 3: Usar imagen local con override
docker-compose -f docker-compose.yml -f docker-compose.override.yml up
```

### Actualizar en Producción

```bash
# Descargar última versión
docker pull darkcode02/topwise-task-manager:latest

# Detener contenedor antiguo
docker stop task-manager-app

# Ejecutar nuevo contenedor
docker run -d -p 5000:5000 --name task-manager-app \
  darkcode02/topwise-task-manager:latest
```

---

## 📊 Variables de Entorno

El pipeline pasa estas variables al Dockerfile:

```bash
--build-arg BUILD_DATE=$(Build.StartTime)
--build-arg VCS_REF=$(Build.SourceVersion)
--build-arg VERSION=$(Build.BuildId)
```

Puedes usar estas en tu Dockerfile:

```dockerfile
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.version=$VERSION
```

---

## 🔍 Monitorear el Pipeline

### En Azure DevOps

1. Ve a **Pipelines** → **Builds**
2. Haz clic en el último build
3. Ver logs en tiempo real
4. Revisar resultados de tests
5. Descargar artefactos

### En Docker Hub

1. Ve a tu perfil
2. Selecciona repositorio `topwise-task-manager`
3. Ver tags publicados
4. Ver pull history
5. Ver estadísticas

---

## 🐛 Troubleshooting

### ❌ "Error: Connection refused to Docker Hub"

**Solución:**
- Verificar Service Connection `docker-SC`
- Validar credenciales
- Comprobar que Docker Hub está accesible

### ❌ "Tests failing"

**Solución:**
- Revisar logs en Azure DevOps
- Ejecutar tests localmente
- El pipeline continúa incluso si hay warnings

### ❌ "Image push failed"

**Solución:**
- Verificar que el repositorio existe en Docker Hub
- Validar permisos del usuario
- Comprobar disponibilidad de Docker Hub

---

## ✅ Checklist para Deployments

Antes de hacer push a `main`:

- [ ] Todos los tests pasan localmente
- [ ] Código formateado con Black
- [ ] Sin errores críticos en Flake8
- [ ] Features completas y testeadas
- [ ] README.md actualizado
- [ ] Commits con mensajes descriptivos
- [ ] Pull request creado para revisión

---

## 📈 Próximas Mejoras Sugeridas

1. **Pruebas de Imagen**
   - Ejecutar `docker run` y validar que inicia sin errores
   - Health checks
   - Smoke tests

2. **Seguridad**
   - Análisis de vulnerabilidades con Trivy
   - Escaneo de dependencias con Safety
   - Firma de imágenes

3. **Optimización**
   - Multi-stage Docker builds
   - Caché de capas
   - Scan de imágenes base

4. **Notificaciones**
   - Slack notifications
   - Email si hay fallos
   - Webhooks personalizados

---

## 📚 Referencias

- [Azure Pipelines Docs](https://docs.microsoft.com/azure/devops/pipelines)
- [Docker Hub](https://hub.docker.com)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)
- [Python Testing](https://docs.pytest.org/)

---

**Pipeline configurado y listo para producción** ✅

Saludos, tu sistema CI/CD está completamente optimizado. 🚀
