FROM alpine:latest

ARG SERVER_TYPE=nginx
ARG CUSTOM_MESSAGE="Hello from Docker!"
ARG ENVIRONMENT=development

ENV SERVER_TYPE=${SERVER_TYPE}
ENV CUSTOM_MESSAGE=${CUSTOM_MESSAGE}
ENV ENVIRONMENT=${ENVIRONMENT}

# Install servers
RUN if [ "$SERVER_TYPE" = "nginx" ]; then \
      apk add --no-cache nginx; \
    elif [ "$SERVER_TYPE" = "apache" ]; then \
      apk add --no-cache apache2; \
    else \
      echo "Unsupported SERVER_TYPE: $SERVER_TYPE"; exit 1; \
    fi

# Add website files
RUN if [ "$SERVER_TYPE" = "nginx" ]; then \
      mkdir -p /usr/share/nginx/html && \
      echo "<h1>$CUSTOM_MESSAGE</h1><p>Server: $SERVER_TYPE</p><p>Environment: $ENVIRONMENT</p>" > /usr/share/nginx/html/index.html; \
    elif [ "$SERVER_TYPE" = "apache" ]; then \
      mkdir -p /var/www/localhost/htdocs && \
      echo "<h1>$CUSTOM_MESSAGE</h1><p>Server: $SERVER_TYPE</p><p>Environment: $ENVIRONMENT</p>" > /var/www/localhost/htdocs/index.html; \
    fi

EXPOSE 80

CMD if [ "$SERVER_TYPE" = "nginx" ]; then \
      nginx -g 'daemon off;'; \
    else \
      httpd -D FOREGROUND; \
    fi
