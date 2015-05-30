IMAGE=mcandre/docker-fedora:8
ROOTFS=rootfs.tar.gz
define GENERATE
yum install -y wget tar && \
mkdir -p /chroot/var/lib/rpm && \
rpm --root /chroot --initdb && \
wget http://archive.fedoraproject.org/pub/archive/fedora/linux/releases/8/Everything/x86_64/os/Packages/fedora-release-notes-8.0.0-3.noarch.rpm && \
wget http://archive.fedoraproject.org/pub/archive/fedora/linux/releases/8/Everything/x86_64/os/Packages/fedora-release-8-3.noarch.rpm && \
rpm --root /chroot -ivh --nodeps fedora-release*rpm && \
yum -y --nogpgcheck --installroot=/chroot groupinstall "base" && \
cd /chroot && \
tar czvf /mnt/rootfs.tar.gz .
endef

all: run

$(ROOTFS):
	docker run --rm --cap-add=SYS_ADMIN -v $$(pwd):/mnt -t mcandre/docker-fedora:17 sh -c '$(GENERATE)'

build: Dockerfile $(ROOTFS)
	docker build -t $(IMAGE) .

run: clean-containers build
	docker run --rm $(IMAGE) sh -c "find /etc -type f -name '*release*' | xargs cat"

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
