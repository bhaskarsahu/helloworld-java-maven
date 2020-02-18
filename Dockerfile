FROM alpine:latest
RUN apk update
RUN apk add openssh
RUN adduser -g "student user" -D student && mkdir /home/student/.ssh && echo "student:student" | chpasswd
ADD authorized_keys /home/student/.ssh
RUN chown -R student:student /home/student && chmod 700 /home/student && chmod 600 /home/student/.ssh/authorized_keys
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -q -N ""
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
