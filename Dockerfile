FROM debian:latest

RUN apt-get update && apt-get install -y \
    wget \
    tar
RUN apt-get update && apt-get install -y aria2
WORKDIR /app

RUN wget https://github.com/cloudreve/Cloudreve/releases/download/3.8.3/cloudreve_3.8.3_linux_amd64.tar.gz \
    && tar -zxvf cloudreve_3.8.3_linux_amd64.tar.gz \
    && rm cloudreve_3.8.3_linux_amd64.tar.gz

RUN chmod 777 /app
COPY conf.ini /app/conf.ini
COPY aria2.conf /app/aria2.conf

RUN chmod +x ./cloudreve

RUN mkdir -p /aria2/data

RUN chmod 777 /aria2/data

EXPOSE 8080

# CMD ["./cloudreve","-c","/app/conf.ini"]
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh
CMD ["/app/start.sh"]
