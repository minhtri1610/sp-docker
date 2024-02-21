# Use the official Ubuntu 22 image from Docker Hub
FROM ubuntu:22.04

# Update package repository and install Apache, PHP, MySQL
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    apache2 \
    php7.4 \
    && rm -rf /var/lib/apt/lists/*

RUN apt update && \
    apt install -y mysql-server && \
    apt install -y git && \
    apt install -y php-mysql php-dom php-zip php-curl &&\
    apt install -y vim

# RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
#     php composer-setup.php \
#     php -r "unlink('composer-setup.php');"\
#     mv composer.phar /usr/local/bin/composer

# RUN git clone https://github.com/mettle/sendportal.git

# Sao chép các tệp và thư mục từ thư mục hiện tại trên máy host (Windows) vào thư mục /app trong container
COPY . /var/www/html/sendportal

COPY .env /var/www/html/sendportal

# Thiết lập thư mục làm việc mặc định trong container
WORKDIR /var/www/html

# Expose ports for Apache (80) and MySQL (3306) services
EXPOSE 80 8080
EXPOSE 3306
EXPOSE 443 22

# Start Apache and MySQL services
CMD ["/bin/bash", "-c", "/usr/sbin/apache2ctl -D FOREGROUND && service mysql start"]
