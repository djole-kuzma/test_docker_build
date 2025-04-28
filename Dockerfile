FROM alpine:latest

# Declare build arguments
ARG SERVER_TYPE
ARG CUSTOM_MESSAGE
ARG ENVIRONMENT

# Use build arguments
RUN echo "Server type is $SERVER_TYPE" > /server-info.txt && \
    echo "Custom message is $CUSTOM_MESSAGE" >> /server-info.txt && \
    echo "Environment is $ENVIRONMENT" >> /server-info.txt

# Just for test
CMD ["cat", "/server-info.txt"]
