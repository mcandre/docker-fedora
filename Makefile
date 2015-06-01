IMAGE=mcandre/docker-fedora:2
ROOTFS=rootfs.tar.gz
define GENERATE
yum install -y wget tar rpm-build rpmrebuild yum-plugin-downloadonly && \
mkdir -p /chroot/var/lib/rpm && \
rpm --root /chroot --initdb && \
wget http://archives.fedoraproject.org/pub/archive/fedora/linux/core/2/x86_64/os/Fedora/RPMS/fedora-release-2-5.x86_64.rpm && \
rpm --root /chroot -ivh --nodeps fedora-release*rpm && \
mkdir /chroot/proc && \
mkdir /chroot/sys && \
mkdir /chroot/dev && \
mount -t proc /proc /chroot/proc && \
mount -t sysfs /sys /chroot/sys && \
mount -t tmpfs /dev /chroot/dev && \
mkdir /chroot/tmp && \
cp -r /mnt/yum.repos.d /chroot/etc && \
yum -y --nogpgcheck --installroot=/chroot --downloadonly groupinstall "base"; true && \
rpmrebuild --change-spec-pre="cat /mnt/dev-preinstall.sh" -p /chroot/var/cache/yum/base/packages/dev-3.3.13-1.x86_64.rpm && \
cp /root/rpmbuild/RPMS/x86_64/dev-3.3.13-1.x86_64.rpm /chroot/var/cache/yum/base/packages && \
yum -y --nogpgcheck --installroot=/chroot localinstall '/chroot/var/cache/yum/base/packages/*.rpm' && \
cp /mnt/repair-rpm.sh /chroot/repair-rpm.sh && \
chroot /chroot /repair-rpm.sh && \
chroot /chroot rpm --import /usr/share/rhn/RPM-GPG-KEY-fedora && \
cp /mnt/yum.conf /chroot/etc/yum.conf && \
rm -rf /chroot/var/cache/yum/base/packages/*.rpm && \
umount /chroot/proc && \
umount /chroot/sys && \
umount /chroot/dev && \
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
