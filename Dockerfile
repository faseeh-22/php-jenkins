# Use the official PHP image with Apache, based on Alpine
FROM php:8.1-apache

# Copy the current directory contents into the container at /var/www/html
COPY . /var/www/html

# Enable Apache mod_rewrite and AllowOverride
RUN if [ -f /etc/apache2/apache2.conf ]; then \
        sed -i 's/#LoadModule rewrite_module/LoadModule rewrite_module/g' /etc/apache2/apache2.conf && \
        sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf; \
    else \
        echo "Apache configuration file not found. Unable to configure Apache."; \
    fi \
    && mkdir -p /run/apache2

# Set the working directory to /var/www/html
WORKDIR /var/www/html

# Ensure the necessary permissions
RUN chown -R www-data:www-data /var/www/html

# Expose port 80
EXPOSE 80

# Run Apache in the foreground
CMD ["httpd", "-D", "FOREGROUND"]
