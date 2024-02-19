# Use the official Ubuntu 22 image from Docker Hub
FROM ubuntu:22.04

# Update package repository and install Apache, PHP, MySQL
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    apache2 \
    php7.4 \
    && rm -rf /var/lib/apt/lists/*

# Sao chép các tệp và thư mục từ thư mục hiện tại trên máy host (Windows) vào thư mục /app trong container
COPY . /app

# Thiết lập thư mục làm việc mặc định trong container
WORKDIR /home/sites/cpr

# Expose ports for Apache (80) and MySQL (3306) services
EXPOSE 80
EXPOSE 3306

# Start Apache and MySQL services
CMD ["/bin/bash", "-c", "/usr/sbin/apache2ctl -D FOREGROUND"]
