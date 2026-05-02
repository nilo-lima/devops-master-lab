# Usa a imagem oficial do Nginx como base
FROM nginx:alpine

# Copia o arquivo index.html para o diretório padrão do Nginx
COPY index.html /usr/share/nginx/html/index.html

# Expõe a porta 80
EXPOSE 80

# Comando para iniciar o Nginx quando o container for executado
CMD ["nginx", "-g", "daemon off;"]
