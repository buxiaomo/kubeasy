FROM centos:7.7.1908

RUN yum install -y openssh-server openssh-clients \
    && mkdir -p /var/run/sshd \
    && sed -ri 's/^#PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -ri 's/^UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
    && ssh-keygen -A \
    && echo "root:password" | chpasswd \
    && systemctl enable sshd

RUN yum install git make conntrack \
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
    nfs-utils \
    bind-utils \
    libselinux-python \
    firewalld \
    kmod vim -y

EXPOSE 22

CMD [ "/sbin/init" ]