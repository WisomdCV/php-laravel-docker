FROM richarvey/nginx-php-fpm:3.1.6

COPY . .

# Image config
ENV SKIP_COMPOSER 1
ENV WEBROOT /var/www/html/public
ENV PHP_ERRORS_STDERR 1
ENV RUN_SCRIPTS 1
ENV REAL_IP_HEADER 1

# Laravel config
ENV APP_ENV production
ENV APP_DEBUG false
ENV LOG_CHANNEL stderr

# Allow composer to run as root
ENV COMPOSER_ALLOW_SUPERUSER 1

# Install Node.js and npm (using apk for Alpine-based images)
RUN apk add --no-cache nodejs npm

# Run Laravel and npm commands
CMD php artisan breeze:install blade && \
    npm install && \
    npm run dev && \
    php artisan migrate && \
    /start.sh
