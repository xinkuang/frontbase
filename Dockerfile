FROM openresty/openresty:1.15.8.3-buster

# 下面是一些创建者的基本信息
MAINTAINER ssf@foxmail.com

# Modify timezone
ENV TZ=Asia/Shanghai


RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak && \
    sed -i 's http://.*.debian.org http://mirrors.aliyun.com g' /etc/apt/sources.list

# Fix base image
RUN  apt-get update && apt-get install -y \
        libidn2-0 \
        vim \
        tar \
        zip \
        gzip \
        unzip \
        bzip2 \
        curl \
        wget \
        netcat \
        net-tools \
        locales \
        openssh-client \
        ca-certificates  \
        logrotate \
        cron \   
    # 设置时区修改为上海
    && apt-get install -y tzdata \
    && ln -sf /usr/share/zoneinfo/Asia/ShangHai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata \
    && rm -rf /var/lib/apt/lists/* \
    && chown -R www-data:www-data /usr/local/openresty /var/run/openresty
# Nginx conf
ADD default.conf /etc/nginx/conf.d/default.conf
EXPOSE 8080
