#!/bin/bash

if [ ! -d $(pwd)/vendor ]; then
    docker-php-ext-install pdo_mysql gd
    apt-get update &&  \
    apt-get install -y libzip-dev libssl-dev git unzip libwebp-dev libjpeg62-turbo-dev libpng-dev libxpm-dev \
    libfreetype6-dev && \
    docker-php-ext-configure gd --with-gd --with-webp-dir --with-jpeg-dir \
    --with-png-dir --with-zlib-dir --with-xpm-dir --with-freetype-dir \
    --enable-gd-native-ttf && \
    docker-php-ext-install gd && \
    curl -s https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer
fi
if [ "$INSTALL_VENDOR" = "y" ]; then
    chmod 777 -R * && \
    useradd "$USER" -d /home/"$USER" -m && \
    su "$USER" && \
    echo "User: $USER"
    if [ $USER != 'root' ]; then
        sed 's/DB_HOST=127.0.0.1/DB_HOST=xcode_database/;s/DB_PASSWORD=/DB_PASSWORD=root/' .env.example > .env && \
        chmod 777 .env && \
        chmod 777 -R storage/logs && \
        composer install && \
        chmod 777 -R vendor/composer
        if [ "$(cat .env | grep -w 'APP_KEY=' | cut -d = -f 1)" = APP_KEY ]; then
            composer update && \
            php artisan key:generate
            #useradd "$USER" -d /home/"$USER" -m && \
            #su "$USER" && \
            #chmod 755 -R *
        fi  #if .env
    else #else != root
        echo "##### User <$USER> isn't created #####" && \
        exit 1
    fi #fi != root
fi #if vendor
docker-php-entrypoint php-fpm


#docker exec php1 useradd dennys -d /home/dennys
#docker exec -it php1 /bin/bash
#su dennys

#docker stop $(docker ps -a -q)
#docker rm $(docker ps -a -q)



# remove all
# docker container prune -f && docker rmi $(docker images -q) -f && sudo rm -rf vendor/ .env
