FROM mysql:5.7
MAINTAINER Juan Navas <yo@juannavas.xyz>

RUN apt-get update && apt-get install -y systemd && apt install -y git unzip curl nano
RUN apt-get install -y apache2 && /etc/init.d/apache2 start

RUN apt install -y apt-transport-https lsb-release ca-certificates wget && \
    wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list && \
    apt update && apt install -y php7.2 && \
    apt install -y php7.2 php7.2-cli php7.2-common php7.2-json php7.2-opcache php7.2-xml php7.2-mysql php7.2-zip php7.2-fpm php7.2-mbstring

RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer


RUN cd /var/www/html && wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.zip && \
    unzip phpMyAdmin-4.9.0.1-all-languages.zip && \
    mv phpMyAdmin-4.9.0.1-all-languages phpmyadmin && rm phpMyAdmin-4.9.0.1-all-languages.zip

EXPOSE 80 3306 8000

#docker build -t juannavasjn/lamp .
#docker run -d -t --name lamp-jn -p 8080:80 -p 8081:8000 -e MYSQL_ROOT_PASSWORD=secret juannavasjn/lamp
#docker exec -ti lamp-jn /bin/bash
#/etc/init.d/apache2 start
