# docker-fedora - Docker base images for Fedora

# ABOUT

docker-fedora is a collection of [chroot](http://man.cx/chroot) + [rpm](http://man.cx/rpm)-generated Fedora base images.

# DOCKER HUB

https://registry.hub.docker.com/u/mcandre/docker-ubuntu/

# EXAMPLE

```
$ make
warning: fedora-release-5-5.noarch.rpm: Header V3 DSA signature: NOKEY, key ID 4f2a6fd2
Preparing...                ########################################### [100%]
   1:fedora-release         ########################################### [100%]
warning: %post(fedora-release-5-5.noarch) scriptlet failed, exit status 255
Could not retrieve mirrorlist http://fedora.redhat.com/download/mirrors/fedora-core-5 error was
[Errno 4] IOError: <urlopen error (-2, 'Name or service not known')>
Error: Cannot retrieve repository metadata (repomd.xml) for repository: core. Please verify its path and try again
make: *** [rootfs.tar.gz] Error 1
```

# REQUIREMENTS

* [Docker](https://www.docker.com/)

## Optional

* [make](http://www.gnu.org/software/make/)

## Debian/Ubuntu

```
$ sudo apt-get install docker.io build-essential
```

## RedHat/Fedora/CentOS

```
$ sudo yum install docker-io
```

## non-Linux

* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant](https://www.vagrantup.com/)
* [boot2docker](http://boot2docker.io/)

### Mac OS X

* [Xcode](http://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12)
* [Homebrew](http://brew.sh/)
* [brew-cask](http://caskroom.io/)

```
$ brew cask install virtualbox vagrant
$ brew install boot2docker
```

### Windows

* [Chocolatey](https://chocolatey.org/)

```
> chocolatey install docker make
```
