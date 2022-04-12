FROM rockylinux
LABEL maintainer mali <mali@bayhan.net>
ENV container docker

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in ; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done);

RUN rm -rf /lib/systemd/system/multi-user.target.wants/ \
&& rm -rf /etc/systemd/system/.wants/ \
&& rm -rf /lib/systemd/system/local-fs.target.wants/ \
&& rm -f /lib/systemd/system/sockets.target.wants/udev \
&& rm -f /lib/systemd/system/sockets.target.wants/initctl \
&& rm -rf /lib/systemd/system/basic.target.wants/ \
&& rm -f /lib/systemd/system/anaconda.target.wants/*

RUN dnf install -y epel-release 
RUN dnf install -y htop procps
RUN dnf update -y
RUN dnf clean all \
  	&& rm -rf /var/cache/yum

VOLUME [ “/sys/fs/cgroup” ]
CMD ["/usr/sbin/init"]
