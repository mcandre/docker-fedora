IMAGE=mcandre/docker-fedora:1
ROOTFS=rootfs.tar.gz
define GENERATE
yum -y install wget tar && \
mkdir -p /chroot/var/lib/rpm && \
rpm --root /chroot --initdb && \
wget http://archive.fedoraproject.org/pub/archive/fedora/linux/core/1/i386/os/Fedora/RPMS/fedora-release-1-3.i386.rpm && \
rpm --root /chroot -ivh --nodeps fedora-release*rpm && \
mkdir /chroot/proc && \
mkdir /chroot/sys && \
mkdir /chroot/dev && \
mount -t proc /proc /chroot/proc && \
mount -t sysfs /sys /chroot/sys && \
mount -t tmpfs /dev /chroot/dev && \
mkdir /chroot/tmp && \
cp /mnt/yum.conf /chroot/etc && \
cp -r /mnt/yum.repos.d /chroot/etc && \
yum -y --installroot=/chroot install yum bash && \
cp /mnt/repair-rpm.sh /chroot/repair-rpm.sh && \
chroot /chroot /repair-rpm.sh && \
cp /mnt/yum.conf /chroot/etc/yum.conf && \
umount /chroot/proc && \
umount /chroot/sys && \
umount /chroot/dev && \
cd /chroot && \
tar czvf /mnt/rootfs.tar.gz .
endef

all: run

$(ROOTFS):
	docker run --rm --privileged --cap-add=SYS_ADMIN -v $$(pwd):/mnt -t mcandre/docker-fedora:2 sh -c '$(GENERATE)'

build: Dockerfile $(ROOTFS)
	docker build -t $(IMAGE) .

run: clean-containers build
	docker run --rm $(IMAGE) sh -c "find /etc -type f -name '*release*' | xargs cat"
	docker run --rm $(IMAGE) sh -c 'yum -y install wget && wget -h'

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
