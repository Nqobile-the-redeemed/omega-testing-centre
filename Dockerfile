# Use official PHP image (Debian/Ubuntu base included)
FROM php:8.4-fpm

# Install dependencies using apt
RUN apt-get update && apt-get install -y \
    libpq-dev libzip-dev unzip curl git \
    && docker-php-ext-install pdo pdo_mysql pdo_pgsql zip \
    && rm -rf /var/lib/apt/lists/*

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY . .

RUN composer install --no-dev --optimize-autoloader

EXPOSE 8082

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8082"]
