FROM python:3.8.2-buster

RUN apt-get update \
    && apt-get install -y openssh-server \
    && mkdir -p /var/run/sshd \
    && sed -ri 's/^#PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -ri 's/^UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
    && ssh-keygen -A \
    && echo "root:password" | chpasswd \
    && apt-get clean all \
    && systemctl enable ssh

CMD [ "/sbin/init" ]