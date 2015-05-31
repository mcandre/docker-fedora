IMAGE=mcandre/docker-fedora:6
ROOTFS=rootfs.tar.gz
define GENERATE
yum install -y wget tar && \
mkdir -p /chroot/var/lib/rpm && \
rpm --root /chroot --initdb && \
wget ftp://ftp.pbone.net/mirror/archive.fedoraproject.org/fedora/linux/core/6/x86_64/os/Fedora/RPMS/fedora-release-notes-6-3.noarch.rpm && \
wget ftp://ftp.pbone.net/mirror/archive.fedoraproject.org/fedora/linux/core/6/x86_64/os/Fedora/RPMS/fedora-release-6-4.noarch.rpm && \
rpm --root /chroot -ivh --nodeps fedora-release*rpm && \
mkdir /chroot/proc && \
mkdir /chroot/sys && \
mkdir /chroot/dev && \
mount -t proc /proc /chroot/proc && \
mount -t sysfs /sys /chroot/sys && \
mkdir /chroot/tmp && \
yum -y --nogpgcheck --installroot=/chroot groupinstall "base" && \
cp /mnt/repair-rpm.sh /chroot/repair-rpm.sh && \
chroot /chroot /repair-rpm.sh && \
umount /chroot/proc && \
umount /chroot/sys && \
cd /chroot && \
tar czvf /mnt/rootfs.tar.gz .
endef

all: run

$(ROOTFS):
	docker run --rm --privileged --cap-add=SYS_ADMIN -v $$(pwd):/mnt -t mcandre/docker-fedora:10 sh -c '$(GENERATE)'

build: Dockerfile $(ROOTFS)
	docker build -t $(IMAGE) .

run: clean-containers build
	docker run --rm $(IMAGE) sh -c "find /etc -type f -name '*release*' | xargs cat"
	docker run --rm $(IMAGE) sh -c 'yum install -y ruby && ruby -v'

clean-containers:
	-docker ps -a | grep -v IMAGE | awk '{ print $$1 }' | xargs docker rm -f

clean-images:
	-docker images | grep -v IMAGE | grep $(IMAGE) | awk '{ print $$3 }' | xargs docker rmi -f

clean-layers:
	-docker images | grep -v IMAGE | grep none | awk '{ print $$3 }' | xargs docker rmi -f

clean-rootfs:
	-rm $(ROOTFS)

clean: clean-containers clean-images clean-layers clean-rootfs

publish:
	docker push $(IMAGE)
