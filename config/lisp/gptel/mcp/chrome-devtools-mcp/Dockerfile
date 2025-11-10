# Alpine:
FROM node:lts-alpine
WORKDIR /app
RUN apk update && \
    apk add --no-cache openssh && \
    rm -rf /var/cache/apk/*
RUN mkdir -p /var/run/sshd
RUN ssh-keygen -A
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin without-password/' /etc/ssh/sshd_config
RUN sed -i 's/AllowTcpForwarding no/AllowTcpForwarding yes/' /etc/ssh/sshd_config
RUN npm init -y
RUN npm install chrome-devtools-mcp@latest
CMD sh -c "/usr/sbin/sshd && node /app/node_modules/chrome-devtools-mcp/build/src/index.js --browserUrl http://127.0.0.1:9222"

# Debian:
# FROM node:lts
# WORKDIR /app
# RUN apt-get update && \
#     apt-get install -y openssh-server && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/*
# RUN mkdir /var/run/sshd
# RUN sed -i 's/PermitRootLogin yes/PermitRootLogin without-password/' /etc/ssh/sshd_config
# RUN npm init -y
# RUN npm install chrome-devtools-mcp@latest
# CMD bash -c "/usr/sbin/sshd && node /app/node_modules/chrome-devtools-mcp/build/src/index.js --browserUrl http://127.0.0.1:9222"
