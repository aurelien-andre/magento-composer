FROM debian:bullseye-slim

ENV \
COMPOSER_ALLOW_SUPERUSER='0' \
COMPOSER_ALLOW_XDEBUG='0' \
COMPOSER_CACHE_DIR='/var/cache/composer' \
MAGENTO_USERNAME='' \
MAGENTO_PASSWORD=''

RUN apt-get update \
&&  apt-get install -y --no-install-recommends \
software-properties-common \
apt-transport-https \
lsb-release \
ca-certificates \
gnupg \
gnupg1 \
gnupg2 \
wget \
git \
tini \
curl \
unzip

RUN apt-get update \
&&  wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add - \
&&  echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list

RUN apt-get update \
&&  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
php7.4 \
php7.4-cli \
php7.4-common \
php7.4-bcmath \
php7.4-opcache \
php7.4-apcu \
php7.4-xdebug \
php7.4-curl \
php7.4-mbstring \
php7.4-mysql \
php7.4-soap \
php7.4-xml \
php7.4-xsl \
php7.4-gd \
php7.4-intl \
php7.4-iconv \
php7.4-ftp \
php7.4-zip

RUN set -eux; \
mkdir -p /var/cache; \
mkdir -p /var/cache/composer; \
chmod 777 -R /var/cache

RUN set -eux; \
rm -rf /etc/apt/sources.list.d/*

COPY docker/* /usr/bin

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

RUN set -eux; \
chmod +x -R /usr/bin; \
chmod +x -R /usr/sbin

WORKDIR /app

ENTRYPOINT ["docker-entrypoint"]

CMD ["composer"]