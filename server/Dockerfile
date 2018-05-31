FROM ubuntu
RUN apt-get update && apt-get install --yes openssh-server sudo python
RUN mkdir -p /run/sshd && chmod 0755 /run/sshd
RUN adduser --home /home/admin --gecos "" --disabled-password admin && usermod -a -G sudo admin &&\
  mkdir -p /home/admin/.ssh && echo "admin ALL=(ALL) NOPASSWD: ALL" | EDITOR='tee -a' visudo
EXPOSE 22 80 443
ENTRYPOINT ["/usr/sbin/sshd", "-D"]

