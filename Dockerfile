FROM ubuntu:latest 
RUN apt-get update && apt-get upgrade -y 
RUN apt-get install -y nginx 
RUN apt-get clean 
RUN rm -r /var/www/* 
RUN mkdir /var/www/my_project 
RUN mkdir /var/www/my_project/img 
COPY index.html /var/www/my_project/index.html 
COPY img.jpg /var/www/my_project/img/ 
RUN chmod -R 755 /var/www/my_project 
RUN useradd Evgenii 
RUN groupadd My_group 
RUN usermod -a -G My_group Evgenii
RUN chown -R Evgenii:My_group /var/www/my_project 
RUN sed -i 's/\/var\/www\/html/\/var\/www\/my_project/g' /etc/nginx/sites-enabled/default 
RUN sed -i 's/www-data/Evgenii/g' /etc/nginx/nginx.conf 
EXPOSE 8080 
CMD ["nginx", "-g", "daemon off;"]
