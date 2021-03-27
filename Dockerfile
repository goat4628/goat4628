FROM ubuntu:20.04

RUN apt update && apt install -y openssh-server
RUN apt -y install vim git gcc

RUN mkdir /var/run/sshd
RUN mkdir /root/project
RUN echo 'root:mrkmhrk1q84' | chpasswd

RUN sed -i 's/#*PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

COPY a.txt /root/project

ENV NOTVISIBLE="in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
