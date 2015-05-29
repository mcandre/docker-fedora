# docker-fedora - Docker base images for Fedora

# ABOUT

docker-fedora is a collection of [yumbootstrap](https://github.com/dozzie/yumbootstrap)-generated Fedora base images.

# DOCKER HUB

https://registry.hub.docker.com/u/mcandre/docker-ubuntu/

# EXAMPLE

```
$ make
docker run --rm mcandre/docker-fedora:latest sh -c 'cat /etc/*release*'
Fedora release 20 (Heisenbug)
NAME=Fedora
VERSION="20 (Heisenbug)"
ID=fedora
VERSION_ID=20
PRETTY_NAME="Fedora 20 (Heisenbug)"
ANSI_COLOR="0;34"
CPE_NAME="cpe:/o:fedoraproject:fedora:20"
HOME_URL="https://fedoraproject.org/"
BUG_REPORT_URL="https://bugzilla.redhat.com/"
REDHAT_BUGZILLA_PRODUCT="Fedora"
REDHAT_BUGZILLA_PRODUCT_VERSION=20
REDHAT_SUPPORT_PRODUCT="Fedora"
REDHAT_SUPPORT_PRODUCT_VERSION=20
Fedora release 20 (Heisenbug)
Fedora release 20 (Heisenbug)
cpe:/o:fedoraproject:fedora:20
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
