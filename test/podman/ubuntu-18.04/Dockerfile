FROM ubuntu:18.04

RUN apt-get update \
    && apt-get install -y openssh-server \
    && mkdir -p /var/run/sshd \
    && sed -ri 's/^#PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -ri 's/^UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
    && ssh-keygen -A \
    && echo "root:password" | chpasswd \
    && apt-get clean all \
    && systemctl enable ssh

RUN apt-get update \
    && apt-get install git make conntrack \
        net-tools \
        sysstat \
        unzip \
        tcpdump \
        telnet \
        lsof \
        strace \
        wget \
        psmisc \
        ipset \
        socat \
        bash-completion \
        nfs-common \
        dnsutils -y

EXPOSE 22

CMD [ "/sbin/init" ]