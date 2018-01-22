FROM ubuntu:16.04

RUN apt-get update && \
	apt-get install -y apache2 apt-utils && \
	apt-get install -y php php-mysql php-mcrypt php-zip php-curl php-gd php-mbstring php-xml && \
	apt-get install -y libapache2-mod-php composer

RUN apt-get install -y curl  && \
	apt-get install -y vim

RUN /usr/sbin/a2enmod rewrite

EXPOSE 80

ADD apache.conf /etc/apache2/sites-enabled/000-default.conf

RUN service apache2 restart

COPY ./proyecto /var/www/html  

RUN cd /var/www/html && composer install && chmod 777 -R  /var/www/html/storage && chmod 777 -R /var/www/html/bootstrap/cache

CMD /usr/sbin/apache2ctl -D FOREGROUND
