FROM ubuntu:16.04

RUN apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -y locales openssh-server git &&\
    mkdir /var/run/sshd &&\
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd &&\
    echo "LC_ALL=en_US.UTF-8" >> /etc/environment &&\
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen &&\
    echo "LANG=en_US.UTF-8" > /etc/locale.conf &&\
    locale-gen en_US.UTF-8

COPY entrypoint.sh /opt/bin/entrypoint.sh

ENV SSH_USER=www-data
EXPOSE 22
ENTRYPOINT ["/opt/bin/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]
