FROM python:3.7.9-slim

RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get install --no-install-recommends sensible-utils make vim openssh-client -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

COPY . /app

WORKDIR /app

RUN ln /usr/local/bin/python3 /usr/bin/python \
    && make runtime \
    && ansible-galaxy collection install ansible.utils

VOLUME [ "/app/inventory", "/etc/ssl/kubernetes" ]
ENTRYPOINT [ "/app/entrypoint.sh" ]
CMD [ "bash" ]