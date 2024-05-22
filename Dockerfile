# Utilizar la imagen oficial de Node.js como imagen base
FROM node:latest

# Establecer el directorio de trabajo en el contenedor para el backend
WORKDIR /usr/src/app/backend

# Copiar el 'package.json' y 'package-lock.json' del backend
COPY Backend/package*.json ./

# Instalar las dependencias del backend
RUN npm install

# Copiar el resto del código fuente del backend
COPY Backend/ .

# Cambiar al directorio del frontend
WORKDIR /usr/src/app/frontend

# Instalar Angular CLI globalmente
RUN npm install -g @angular/cli

# Copiar el 'package.json' y 'package-lock.json' del frontend
COPY Frontend/package*.json ./

# Instalar las dependencias del frontend
RUN npm install

# Copiar los archivos restantes del proyecto Frontend

COPY Frontend/ .

# Construir la aplicacion Angular para producción
RUN ng build --configuration production

# Cambiar de nuevo al directorio del backend para la ejecución
WORKDIR /usr/src/app/backend

# Exponer el puerto 3000 para el servidor Node.js y el puerto 80 para el servidor web
EXPOSE 3000 80

# Comando para ejecutar el servidor Node.js y servir la aplicación Angular
CMD ["sh", "-c", "node index.js & npx http-server /usr/src/app/frontend/dist/chat-app -p 80"]
