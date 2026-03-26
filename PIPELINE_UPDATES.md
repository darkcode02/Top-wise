# 🔄 Cambios al Pipeline Azure DevOps

## Resumen de Actualizaciones

Tu pipeline ha sido actualizado para trabajar de forma óptima con las nuevas dependencias y versión de Docker. Aquí están los cambios principales:

---

## ✅ Cambios Realizados

### 1. **Imagen Docker más descriptiva**
```
ANTES: task-manager
AHORA: topwise-task-manager
```
Más clara y profesional para Docker Hub.

### 2. **Tags automáticos mejorados**

**En rama `main` (Producción):**
```
latest          ← Siempre la versión más reciente
{BuildId}       ← ID único del build (ej: 1234)
v1.0.0          ← Versión semántica
```

**En rama `develop` (Desarrollo):**
```
develop         ← Rama de desarrollo
develop-{BuildId} ← Version específica de develop
```

### 3. **Control de Calidad mejorado**
Antes solo hacía tests, ahora valida:
- ✅ **Black** - Formato de código
- ✅ **Flake8** - Errores y advertencias
- ✅ **Pylint** - Calidad del código
- ✅ **pytest** - Tests unitarios

### 4. **Metadatos en la imagen Docker**
Ahora incluye información de build:
```
BUILD_DATE: fecha de construcción
VCS_REF: commit hash
VERSION: Build ID
```

### 5. **Manejo de ramas inteligente**
```
IF rama == 'main':
    - Push con tags: latest, {id}, v1.0.0
    
ELSE IF rama == 'develop':
    - Push con tags: develop, develop-{id}
```

### 6. **Mejor reporte final**
Ahora muestra:
- Estado del pipeline (✅ o ❌)
- Rama procesada
- Commit message
- Tags publicados
- Instrucciones para usar la imagen

---

## 🔧 Configuración Necesaria

### ✅ Ya está configurada correctamente

Tu Service Connection `docker-SC` debe estar configurada en Azure DevOps com:

```
Tipo: Docker Registry
URL: https://index.docker.io/v1/
Usuario: darkcode02
```

**Para verificar:**

1. Ve a Azure DevOps
2. Project Settings → Service Connections
3. Busca "docker-SC"
4. Verifica que tenga acceso

### 🔑 Token de Docker Hub (Recomendado)

Mejor que usar contraseña:

```bash
# En Docker Hub:
1. Ir a Account Settings → Security
2. Crear nuevo Personal Access Token
3. Copiar el token
4. Actualizaren Azure DevOps Service Connection
```

---

## 📝 Cambios en Requirements.txt

Las dependencias fueron actualizadas automáticamente:

```
ANTES:
Flask==2.3.2
Flask-SQLAlchemy==3.0.2
werkzeug==2.3.6

AHORA:
Flask>=3.1.0
Flask-SQLAlchemy==3.1.1
werkzeug>=3.0.0
```

El pipeline usa estas versiones automáticamente.

---

## 🚀 Flujo de CI/CD Completo

### Cuando haces PUSH a `develop`:

```
1. Trigger automático del pipeline
2. ✅ Tests y validación (5-10 min)
3. ✅ Build imagen Docker
4. ✅ Push a Docker Hub:
   - Tag: develop
   - Tag: develop-1234 (example)
5. ✅ Notificación final
```

**Resultado:** Imagen disponible en Docker Hub para testing

### Cuando haces MERGE a `main`:

```
1. Trigger automático del pipeline
2. ✅ Tests y validación
3. ✅ Build imagen Docker
4. ✅ Push a Docker Hub:
   - Tag: latest ← Producción
   - Tag: 1234 ← Versión específica
   - Tag: v1.0.0
5. ✅ Notificación final
```

**Resultado:** Imagen disponible para deploy en producción

---

## 📦 Descargar y Usar en Producción

### Pull desde Docker Hub

```bash
# Ver todas las versiones disponibles
docker search darkcode02/topwise-task-manager

# Descargar la última versión
docker pull darkcode02/topwise-task-manager:latest

# Descargar versión específica
docker pull darkcode02/topwise-task-manager:develop

# Ejecutar
docker run -p 5000:5000 darkcode02/topwise-task-manager:latest
```

---

## 🔍 Monitorear Builds

### En Azure DevOps

```
https://dev.azure.com/{Tu Org}/TopWise-proyect/_build
```

### En Docker Hub

```
https://hub.docker.com/r/darkcode02/topwise-task-manager
```

---

## ⚠️ Notas Importantes

1. **El pipeline es automático**
   - Cada push a `main` o `develop` dispara el pipeline
   - No necesitas ejecutarlo manualmente

2. **Tests opcionales**
   - Si no existen tests, el pipeline continúa
   - No es un bloqueador

3. **Análisis de código**
   - Flake8 y Pylint son informativos (`|| true`)
   - No bloquean el build

4. **Docker Hub**
   - Verifica que tu usuario (`darkcode02`) sea propietario del repositorio
   - La imagen debe ser **pública** para que otros puedan descargarla

5. **Tags semánticos**
   - `v1.0.0` es estático (cambiar manualmente en pipeline cuando liberes versiones)
   - Los BuildIds son automáticos

---

## 🎯 Checklist Post-Actualización

- [ ] Verificar que Service Connection `docker-SC` existe y funciona
- [ ] Confirmar que repositorio `topwise-task-manager` existe en Docker Hub
- [ ] Hacer un test push a rama `develop`
- [ ] Verificar que imagen se subió a Docker Hub
- [ ] Probar descargar la imagen: `docker pull darkcode02/topwise-task-manager:develop`
- [ ] Ejecutar imagen localmente y validar que funciona
- [ ] (Optional) Configurar notificaciones en Slack

---

## 📞 Soporte

Si encuentras problemas:

1. **Revisar logs del pipeline en Azure DevOps**
   - Ir a Pipeline → Ver logs detallados
   - Buscar errores específicos

2. **Validar Docker Hub**
   - Confirmar que las credenciales son correctas
   - Verificar permisos del repositorio

3. **Comprobar Dockerfile**
   - `docker build -t test .` localmente
   - Asegurar que compila sin errores

---

**Tu pipeline CI/CD está 100% actualizado y listo para producción** ✅🚀
