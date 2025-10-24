# Usa una imagen base de Python 3.9
FROM python:3.9-slim

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia el archivo de dependencias
COPY requirements.txt .

# Instala las dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Copia todos los archivos del proyecto al contenedor
COPY . .

# Expone el puerto 5000 (donde Flask escucha por defecto)
EXPOSE 5000

# Comando para iniciar el servidor SMTP en segundo plano y luego la aplicación
CMD ["sh", "-c", "python -m smtpd -n -c DebuggingServer localhost:1024 & python app.py"]
