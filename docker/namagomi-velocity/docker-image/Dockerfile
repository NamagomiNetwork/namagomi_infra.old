FROM openjdk:20-jdk

WORKDIR /server

COPY ./start.sh /server/start.sh
RUN apt update && apt install iputils-ping net-tools -y
RUN apt-get install -y tzdata && \
    ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN chmod +x /server/start.sh
CMD bash /server/start.sh