IMAGE=mcandre/docker-fedora:22
ROOTFS=rootfs.tar.gz
define GENERATE
dnf install -y wget tar && \
mkdir -p /chroot/var/lib/rpm && \
rpm --root /chroot --initdb && \
wget ftp://rpmfind.net/linux/fedora/linux/releases/22/Everything/x86_64/os/Packages/f/fedora-repos-22-1.noarch.rpm && \
wget ftp://rpmfind.net/linux/fedora/linux/releases/22/Everything/x86_64/os/Packages/f/fedora-release-22-1.noarch.rpm && \
rpm --root /chroot -ivh --nodeps fedora-repos*rpm fedora-release*rpm && \
yum -y --nogpgcheck --installroot=/chroot groupinstall "minimal install" && \
cd /chroot && \
tar czvf /mnt/rootfs.tar.gz .
endef

all: run

$(ROOTFS):
	docker run --rm --cap-add=SYS_ADMIN -v $$(pwd):/mnt -t fedora sh -c '$(GENERATE)'

build: Dockerfile $(ROOTFS)
	docker build -t $(IMAGE) .

run: clean-containers build
	docker run --rm $(IMAGE) sh -c 'cat /etc/*release*'

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
