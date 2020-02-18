FROM alpine:latest
RUN apk update
RUN apk add openssh
RUN adduser -g "student user" -D student && mkdir /home/student/.ssh && echo "student:student" | chpasswd
ADD authorized_keys /home/student/.ssh
RUN chown -R student:student /home/student && chmod 700 /home/student && chmod 600 /home/student/.ssh/authorized_keys
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -q -N ""
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]


Building
=====================
docker build -t ssh:alpine .

Running
========================
docker run -d -ti --name ssh -p 2002:22 ssh:alpine     (here ssh is just a user name, and we are fetching from alpine)
