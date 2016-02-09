# docker-fedora - Docker base images for Fedora

# ABOUT

docker-fedora is a collection of [chroot](http://man.cx/chroot) + [rpm](http://man.cx/rpm)-generated Fedora base images.

# DOCKER HUB

https://registry.hub.docker.com/u/mcandre/docker-fedora/

# EXAMPLE

```
$ make
docker run --rm mcandre/docker-fedora:latest sh -c 'cat /etc/*release*'
Fedora release 23 (Rawhide)
NAME=Fedora
VERSION="23 (Rawhide)"
ID=fedora
VERSION_ID=23
PRETTY_NAME="Fedora 23 (Rawhide)"
ANSI_COLOR="0;34"
CPE_NAME="cpe:/o:fedoraproject:fedora:23"
HOME_URL="https://fedoraproject.org/"
BUG_REPORT_URL="https://bugzilla.redhat.com/"
REDHAT_BUGZILLA_PRODUCT="Fedora"
REDHAT_BUGZILLA_PRODUCT_VERSION=Rawhide
REDHAT_SUPPORT_PRODUCT="Fedora"
REDHAT_SUPPORT_PRODUCT_VERSION=Rawhide
PRIVACY_POLICY_URL=https://fedoraproject.org/wiki/Legal:PrivacyPolicy
Fedora release 23 (Rawhide)
Fedora release 23 (Rawhide)
cpe:/o:fedoraproject:fedora:23
```

# REQUIREMENTS

* [Docker](https://www.docker.com/)

## Optional

* [make](http://www.gnu.org/software/make/)
* [Node.js](https://nodejs.org/en/) (for dockerlint)

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
* [Docker Toolbox](https://www.docker.com/toolbox)

### Mac OS X

* [Xcode](http://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12)
* [Homebrew](http://brew.sh/)
* [brew-cask](http://caskroom.io/)

```
$ brew cask install dockertoolbox
```

### Windows

* [Chocolatey](https://chocolatey.org/)

```
> chocolatey install virtualbox make
```

* [DockerToolbox-1.8.2c.exe](https://github.com/docker/toolbox/releases/download/v1.8.2c/DockerToolbox-1.8.2c.exe)
