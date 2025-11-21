# Usa una imagen base de Python
FROM python:3.9-slim

# Directorio de trabajo
WORKDIR /app

# Copia los archivos de dependencias
COPY requirements.txt .

# Instala las dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Copia el código de la aplicación
COPY . .

# Expone el puerto en el que corre la aplicación (5000 por defecto en Flask)
EXPOSE 5000

# Comando para ejecutar la aplicación
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]