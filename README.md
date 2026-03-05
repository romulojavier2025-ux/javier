# API Node.js – Optimización de Consultas

Este proyecto implementa una API REST en Node.js utilizando Express con diferentes técnicas de optimización para mejorar el rendimiento del sistema.

## Tecnologías utilizadas

- Node.js
- Express
- DataLoader
- GitHub

## Funcionalidades implementadas

El proyecto incluye las siguientes estrategias de optimización:

### 1. Caché de consultas
Se implementa un sistema de caché en memoria para evitar consultas repetitivas.

Endpoint:
http://localhost:3000/productos

### 2. Endpoint de configuración
Endpoint adicional que devuelve información de configuración de la aplicación.

Endpoint:
http://localhost:3000/configuracion

### 3. Prevención del problema N+1 (DataLoader)
Se utiliza DataLoader para agrupar consultas y evitar múltiples consultas innecesarias.

Endpoint:
http://localhost:3000/categoria/1

### 4. Cola de trabajos (Job Queue)
Se implementa una cola de trabajos para procesar tareas en segundo plano.

Endpoint:
http://localhost:3000/pedido/1

### 5. Lazy Loading
Se implementa Lazy Loading para cargar información adicional solo cuando el cliente lo solicita.

Consulta normal:
http://localhost:3000/productos

Consulta con Lazy Loading:
http://localhost:3000/productos?include=categoria

## Instalación del proyecto

1. Clonar el repositorio
