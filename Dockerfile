FROM alpine:latest

ARG SERVER_TYPE
ARG CUSTOM_MESSAGE
ARG ENVIRONMENT

# Install Apache
RUN apk add --no-cache apache2

# Create a custom index.html using the build arguments
RUN mkdir -p /var/www/localhost/htdocs && \
    echo "<html><body>" > /var/www/localhost/htdocs/index.html && \
    echo "<h1>$CUSTOM_MESSAGE</h1>" >> /var/www/localhost/htdocs/index.html && \
    echo "<p>Server: $SERVER_TYPE</p>" >> /var/www/localhost/htdocs/index.html && \
    echo "<p>Environment: $ENVIRONMENT</p>" >> /var/www/localhost/htdocs/index.html && \
    echo "</body></html>" >> /var/www/localhost/htdocs/index.html

# Expose port 80
EXPOSE 80

# Start Apache in foreground
CMD ["httpd", "-D", "FOREGROUND"]
