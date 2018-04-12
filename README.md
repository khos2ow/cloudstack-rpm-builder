# CloudStack RPM Package builder using Docker

Docker images for building Apache CloudStack RPM packages.

This will give portable, immutable and reproducable mechanism to build packages for releases. A very good candidate to be used by the Jenkins slaves of the project.

## Table of Contents

- [Supported tags and respective `Dockerfile` links](https://github.com/khos2ow/cloudstack-rpm-builder#supported-tags-and-respective-dockerfile-links)
- [Packges installed in conatiner](https://github.com/khos2ow/cloudstack-rpm-builder#packges-installed-in-conatiner)
- [Build RPM packages](https://github.com/khos2ow/cloudstack-rpm-builder#build-rpm-packages)
  - [Clone Apache CloudStack source code](https://github.com/khos2ow/cloudstack-rpm-builder#clone-apache-cloudstack-source-code)
  - [Pull Docker images](https://github.com/khos2ow/cloudstack-rpm-builder#pull-docker-images)
  - [Build packages](https://github.com/khos2ow/cloudstack-rpm-builder#build-packages)
- [Building tips](#building-tips)
  - [Maven cache](https://github.com/khos2ow/cloudstack-rpm-builder#maven-cache)
  - [Adjust host owner permission](https://github.com/khos2ow/cloudstack-rpm-builder#adjust-host-owner-permission)
- [Builder help](https://github.com/khos2ow/cloudstack-rpm-builder#builder-help)
- [License](#license)

## Supported tags and respective `Dockerfile` links

- [`latest`, `centos7` (centos7/Dockerfile)](https://github.com/khos2ow/cloudstack-rpm-builder/blob/master/centos7/Dockerfile)
- [`centos6` (centos6/Dockerfile)](https://github.com/khos2ow/cloudstack-rpm-builder/blob/master/centos6/Dockerfile)

## Packges installed in conatiner

List of available packages inside the container:

- rpm-build
- yum-utils
- createrepo
- mkisofs
- git
- java 1.8
- maven 3.5
- tomcat
- python
- locate
- which

## Build RPM packages

Building RPM packages with the Docker container is rather easy, a few steps are required:

### Clone Apache CloudStack source code

The first step required is to clone the CloudStack source code somewhere on the filesystem, in `/tmp` for example:

    cd /tmp
    git clone https://github.com/apache/cloudstack.git cloudstack

Now that you have done so we can continue.

### Pull Docker images

Let's assume we want to build packages for CentOS 7 on CentOS 7. We pull that image first:

    docker pull khos2ow/cloudstack-rpm-builder:centos7

You can replace `centos7` tag by `centos6` or `latest` if you want.

### Build packages

Now that we have the Docker images we can build packages by mapping `/tmp` into `/mnt/build` in the container. (Note that the container always expects the `cloudstack` code exists in `/mnt/build` path.)

    docker run \
        -v /tmp:/mnt/build \
        khos2ow/cloudstack-rpm-builder:centos7 --distribution centos7 [ARGS...]

Or if your local cloudstack folder has other name, you need to map it to `/mnt/build/cloudstack`.

    docker run \
        -v /tmp/cloudstack-custom-name:/mnt/build/cloudstack \
        khos2ow/cloudstack-rpm-builder:centos7 --distribution centos7 [ARGS...]

After the build has finished the *.rpm* packages are available in */tmp/cloudstack/dist/rpmbuild/RPMS* on the host system.

## Building tips

Check the following tips when using the builder:

### Maven cache

You can provide Maven cache folder (`~/.m2`) as a volume to the container to make it run faster.

    docker run \
        -v /tmp:/mnt/build \
        -v ~/.m2:/root/.m2 \
        khos2ow/cloudstack-rpm-builder:centos7 --distribution centos7 [ARGS...]

### Adjust host owner permission

Builder container in some cases (e.g. using `--use-timestamp` flag) may change the file and directory owner shared from host to container (through volume) and it will create `dist` directory which holds the final artifacts. You can provide `USER_ID` (mandatory) and/or `USER_GID` (optional) from host to adjust the owner from whitin the container.

This is specially useful if you want to use this image in Jenkins job and want to clean up the workspace afterward. By adjusting the owner, you won't need to give your Jenkins' user `sudo` privilege to clean up.

    docker run \
        -v /tmp:/mnt/build \
        -e "USER_ID=$(id -u)" \
        -e "USER_GID=$(id -g)" \
        khos2ow/cloudstack-rpm-builder:centos7 --distribution centos7 [ARGS...]

## Builder help

To see all the available options you can pass to `docker run ...` command:

    docker run \
        -v /tmp:/mnt/build \
        khos2ow/cloudstack-rpm-builder:centos7 --help

## License

Licensed under [Apache License version 2.0](http://www.apache.org/licenses/LICENSE-2.0). Please see the [LICENSE](https://github.com/khos2ow/cloudstack-rpm-builder/blob/master/LICENSE) file included in the root directory of the source tree for extended license details.