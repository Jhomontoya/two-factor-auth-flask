# Usa una imagen oficial de PHP con Apache
FROM php:8.2-apache

# Mantenedor (opcional)
LABEL maintainer="jhonj@192.168.1.72"

# Instalar Git y habilitar mod_rewrite
RUN apt-get update && \
    apt-get install -y git && \
    a2enmod rewrite && \
    rm -rf /var/lib/apt/lists/*

# Copiar la configuración de Apache y los archivos web
COPY ./www /var/www/html

# Cambiar el propietario de los archivos
RUN chown -R www-data:www-data /var/www/html

# Exponer el puerto 80
EXPOSE 80

# Iniciar Apache
CMD ["apache2-foreground"]
