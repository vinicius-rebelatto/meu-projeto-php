#Dockerfile

# Usa a imagem oficial do PHP com suporte a FPM
FROM php:8.2-fpm
 
# Define o diretório de trabalho no contêiner
WORKDIR /var/www/html
 
# Instala o Nginx e outras dependências necessárias
RUN apt-get update && apt-get install -y nginx curl unzip && rm -rf /var/lib/apt/lists/*
 
# Copia os arquivos da aplicação para dentro do contêiner
COPY . /var/www/html
 
# Define permissões adequadas para os arquivos
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html
 
# Copia a configuração do Nginx
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
 
# Expõe a porta 80 para acesso à aplicação
EXPOSE 80
 
# Comando para iniciar o Nginx e o PHP-FPM
CMD ["sh", "-c", "service nginx start && php-fpm"]