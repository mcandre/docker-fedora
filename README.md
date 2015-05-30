# docker-fedora - Docker base images for Fedora

# ABOUT

docker-fedora is a collection of [chroot](http://man.cx/chroot) + [rpm](http://man.cx/rpm)-generated Fedora base images.

# DOCKER HUB

https://registry.hub.docker.com/u/mcandre/docker-ubuntu/

# EXAMPLE

```
$ make
docker run --rm mcandre/docker-fedora:18 sh -c 'cat /etc/*release*'
Fedora release 18 (Spherical Cow)
NAME=Fedora
VERSION="18 (Spherical Cow)"
ID=fedora
VERSION_ID=18
PRETTY_NAME="Fedora 18 (Spherical Cow)"
ANSI_COLOR="0;34"
CPE_NAME="cpe:/o:fedoraproject:fedora:18"
Fedora release 18 (Spherical Cow)
Fedora release 18 (Spherical Cow)
cpe:/o:fedoraproject:fedora:18
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
