# 🚀 INICIO RÁPIDO - TopWise

## ¡Tu aplicación está lista para usarse!

Aquí hay 3 formas de ejecutar TopWise:

---

## 📦 OPCIÓN 1: Con Docker Compose (Recomendado)

**Lo más fácil y rápido:**

```bash
# Desde la raíz del proyecto
docker-compose up
```

Luego abre en tu navegador:
```
http://localhost:5000
```

---

## 🐍 OPCIÓN 2: Ejecución Local

**Si tienes Python instalado:**

```bash
# Instalar dependencias
cd task_manager
pip install -r requirements.txt

# Ejecutar la aplicación
python app.py
```

Luego abre:
```
http://localhost:5000
```

---

## 📜 OPCIÓN 3: Script Automático

**Usa el script que detecta automáticamente tu sistema:**

```bash
# En macOS o Linux
chmod +x start.sh
./start.sh

# En Windows
start.bat
```

---

## 🎯 Características que Ya Tienes:

✅ **Frontend Hermoso**
- Diseño moderno con Glassmorphism
- Interfaz intuitiva y responsiva
- Animaciones suaves

✅ **Backend Robusto**
- API REST completa
- Base de datos SQLite
- Validación de datos

✅ **Funcionalidades**
- Crear, editar, completar y eliminar tareas
- Establecer prioridades (Baja, Normal, Alta)
- Contador de progreso en tiempo real
- Notificaciones instantáneas

✅ **DevOps Profesional**
- Docker & Docker Compose
- Makefile para comandos comunes
- Azure Pipelines CI/CD
- .gitignore configurado

---

## 🛠️ Comandos Útiles

```bash
# Ver todos los comandos disponibles
make help

# Instalar dependencias (si no usas Docker)
make install

# Ejecutar en desarrollo
make dev

# Ejecutar con Docker
make docker-up

# Ver logs de Docker
make docker-logs

# Detener Docker
make docker-down

# Ejecutar tests
make test

# Limpiar archivos temporales
make clean

# Resetear base de datos
make reset-db
```

---

## 📝 Ejemplos de Uso de la API

### Crear una tarea:
```bash
curl -X POST http://localhost:5000/api/tasks \
  -H "Content-Type: application/json" \
  -d '{"description": "Mi primer tarea", "priority": "high"}'
```

### Ver todas las tareas:
```bash
curl http://localhost:5000/api/tasks
```

### Marcar como completada:
```bash
curl -X PUT http://localhost:5000/api/tasks/1 \
  -H "Content-Type: application/json" \
  -d '{"completed": true}'
```

### Eliminar una tarea:
```bash
curl -X DELETE http://localhost:5000/api/tasks/1
```

---

## 🎨 Personalización

El proyecto está completamente personalizable:

- **Colores**: Modifica los gradientes en `templates/index.html` (busca `#667eea`)
- **Estilos**: CSS inline en el HTML o crea archivos en `static/css/`
- **Funciones**: Agrega nuevas características en `app.py`
- **Base de datos**: Modifica `models.py` para nuevos campos

---

## 📱 Responsive Design

La aplicación se adapta perfectamente a:
- 📱 Móviles (320px+)
- 📱 Tablets (768px+)
- 💻 Desktops (1024px+)

Abre en tu navegador móvil para verlo en acción.

---

## ✨ Siguientes Pasos

1️⃣ **Ejecuta la aplicación** (elige una de las 3 opciones arriba)

2️⃣ **Crea tu primera tarea** en la interfaz

3️⃣ **Personaliza colores y estilos** si lo deseas

4️⃣ **Despliega a producción** (usando Docker)

5️⃣ **Agrega nuevas funciones** según tus necesidades

---

## 🆘 ¿Problemas?

**Puerto 5000 ya en uso:**
```bash
# Cambia el puerto en docker-compose.yml o en app.py
# Línea: app.run(host='0.0.0.0', port=5001, debug=False)
```

**Error de dependencias:**
```bash
pip install --upgrade pip
pip install -r task_manager/requirements.txt
```

**Resetear la base de datos:**
```bash
make reset-db
```

---

## 🎉 ¡Listo!

Tu aplicación TopWise está completamente funcional y lista para producción.

**Ahora es tu turno de hacerla aún mejor.** Agrega más features, personaliza el diseño y ¡disfruta! 

---

Happy Task Managing! 🚀✨
