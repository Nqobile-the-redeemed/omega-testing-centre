# Use official PHP image (Debian/Ubuntu base included)
FROM php:8.4-fpm-alpine

# Install dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev libzip-dev unzip curl git \
    && docker-php-ext-install pdo pdo_mysql pdo_pgsql zip

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy project files
COPY . .

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Expose application port
EXPOSE 8082

# Run Laravel API (no nginx, no node)
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8082"]
