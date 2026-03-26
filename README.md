# 🚀 TopWise - Gestor de Tareas Inteligente

Una aplicación web moderna y poderosa para gestionar tus tareas con un diseño increíble y funcionalidades avanzadas.

## ✨ Características

- ✅ **Interfaz Moderna** - Diseño glassmorphism con gradientes modernos
- 📝 **Gestión Completa de Tareas** - Crear, editar, completar y eliminar tareas
- 🎯 **Prioridades** - Asigna niveles de prioridad (Baja, Normal, Alta)
- 📊 **Contador de Tareas** - Visualiza tu progreso en tiempo real
- ⚡ **Instantáneo** - Actualizaciones en tiempo real sin recargar
- 📱 **Responsive** - Funciona perfecto en desktop, tablet y móvil
- 🎨 **Hermoso Diseño** - UI/UX moderno con animaciones suaves
- 💾 **Base de Datos** - Persistencia con SQLite

## 🏗️ Estructura del Proyecto

```
Top-wise/
├── docker-compose.yml      # Configuración de Docker Compose
├── Dockerfile              # Imagen Docker
├── README.md              # Este archivo
├── pipelines/             # Azure Pipelines CI/CD
└── task_manager/
    ├── app.py             # Aplicación Flask principal
    ├── models.py          # Modelos de la base de datos
    ├── requirements.txt   # Dependencias Python
    ├── templates/
    │   └── index.html     # Interfaz web (Frontend)
    ├── static/
    │   ├── css/           # Estilos CSS
    │   └── js/            # JavaScript
    └── tests/
        ├── __init__.py
        └── test_app.py
```

## 🚀 Inicio Rápido

### Con Docker Compose

```bash
docker-compose up
```

Luego accede a: **http://localhost:5000**

### Sin Docker (Local)

1. **Instala las dependencias:**
   ```bash
   cd task_manager
   pip install -r requirements.txt
   ```

2. **Ejecuta la aplicación:**
   ```bash
   python app.py
   ```

3. **Abre en tu navegador:**
   ```
   http://localhost:5000
   ```

## 📚 API Endpoints

### Tareas

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| `GET` | `/api/tasks` | Obtener todas las tareas |
| `POST` | `/api/tasks` | Crear una nueva tarea |
| `PUT` | `/api/tasks/<id>` | Actualizar una tarea |
| `DELETE` | `/api/tasks/<id>` | Eliminar una tarea |

### Ejemplos de Uso

**Crear una tarea:**
```bash
curl -X POST http://localhost:5000/api/tasks \
  -H "Content-Type: application/json" \
  -d '{"description": "Mi nueva tarea", "priority": "high"}'
```

**Obtener todas las tareas:**
```bash
curl http://localhost:5000/api/tasks
```

**Marcar tarea como completada:**
```bash
curl -X PUT http://localhost:5000/api/tasks/1 \
  -H "Content-Type: application/json" \
  -d '{"completed": true}'
```

**Eliminar una tarea:**
```bash
curl -X DELETE http://localhost:5000/api/tasks/1
```

## 🎯 Funcionalidades del Frontend

### Dashboard Principal
- Vista limpia y organizada de todas tus tareas
- Contador de tareas totales y completadas
- Actualizaciones en tiempo real

### Crear Tareas
- Input intuitivo para escribir tareas
- Selector de prioridad (Baja, Normal, Alta)
- Validación automática

### Gestionar Tareas
- ✅ Marcar como completada/incompleta
- ✏️ Editar descripción
- 🗑️ Eliminar tarea
- Indicadores visuales de prioridad

### Notificaciones
- Toasts en tiempo real
- Feedback visual inmediato
- Animaciones suaves

## 🛠️ Tecnologías Utilizadas

**Backend:**
- Flask 2.3.2
- Flask-SQLAlchemy 3.0.2
- Python 3.11

**Frontend:**
- HTML5
- Tailwind CSS
- JavaScript Vanilla
- Font Awesome Icons

**DevOps:**
- Docker
- Docker Compose
- Azure Pipelines (CI/CD)

## 📦 Dependencias

Ver [requirements.txt](task_manager/requirements.txt):
```
Flask==2.3.2
Flask-SQLAlchemy==3.0.2
werkzeug==2.3.6
```

## 🧪 Testing

Ejecuta los tests con:
```bash
cd task_manager
python -m pytest tests/
```

## 🐳 Docker

### Construir imagen
```bash
docker build -t topwise .
```

### Ejecutar contenedor
```bash
docker run -p 5000:5000 topwise
```

### Con Docker Compose
```bash
docker-compose up -d
docker-compose logs -f
```

## 📸 Características Visuales

- **Glassmorphism Design** - Efecto de cristal moderno
- **Gradient Background** - Fondos con gradientes hermosos
- **Smooth Animations** - Transiciones suaves en 0.3s
- **Color Coding** - Prioridades diferenciadas por color
- **Icons** - Font Awesome para mejor UX
- **Responsive Layout** - Se adapta a cualquier pantalla

## 🚀 Mejoras Futuras

- [ ] Autenticación de usuarios
- [ ] Categorías/Etiquetas
- [ ] Fechas de vencimiento
- [ ] Subtareas
- [ ] Colaboración en tiempo real
- [ ] Notificaciones por email
- [ ] Exportar/Importar tareas
- [ ] Dark mode
- [ ] Filtros avanzados

## 💡 Tips & Tricks

1. **Usa Enter para agregar tareas** - Presiona Enter en el input para crear rápidamente
2. **Ordena por prioridad** - Las tareas altas aparecen con borde rojo
3. **Edita sin dejar la app** - Click en editar para cambiar la descripción
4. **Tracking visual** - Ve tu progreso en el contador de tareas

## 📝 Licencia

Este proyecto está disponible bajo la Licencia MIT.

## 👨‍💻 Desarrollo

Creado con ❤️ usando Flask, HTML, CSS y JavaScript.

---

**¿Necesitas ayuda?** Revisa los logs en Docker o consulta la documentación de Flask.

Happy Task Managing! 🎉
