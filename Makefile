IMAGE=mcandre/docker-fedora:3
ROOTFS=rootfs.tar.gz
define GENERATE
yum install -y wget tar && \
mkdir -p /chroot/var/lib/rpm && \
rpm --root /chroot --initdb && \
wget http://archives.fedoraproject.org/pub/archive/fedora/linux/core/3/x86_64/os/Fedora/RPMS/fedora-release-3-9.x86_64.rpm && \
rpm --root /chroot -ivh --nodeps fedora-release*rpm && \
mkdir /chroot/proc && \
mkdir /chroot/sys && \
mkdir /chroot/dev && \
mount -t proc /proc /chroot/proc && \
mount -t sysfs /sys /chroot/sys && \
mkdir /chroot/tmp && \
cp -r /mnt/yum.repos.d /chroot/etc && \
yum --installroot=/chroot clean all && \
yum -y --nogpgcheck --installroot=/chroot groupinstall "base" && \
cp /mnt/repair-rpm.sh /chroot/repair-rpm.sh && \
chroot /chroot /repair-rpm.sh && \
chroot /chroot rpm --import /usr/share/rhn/RPM-GPG-KEY-fedora && \
umount /chroot/proc && \
umount /chroot/sys && \
find /chroot/var/log -type f -delete && \
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
	docker run --rm $(IMAGE) sh -c 'yum -y install ruby && ruby -v'

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
