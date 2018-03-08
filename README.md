# CloudStack RPM Package builder using Docker
Docker images for building Apache CloudStack RPM packages.

This will give portable, immutable and reproducable mechanism to build packages for releases. A very good candidate to be used by the Jenkins slaves of the project.

# Table of Contents

- [Supported tags and respective Dockerfile links](https://github.com/khos2ow/cloudstack-rpm-builder#supported-tags-and-respective-dockerfile-links)
- [Packges installed in Conatiner](https://github.com/khos2ow/cloudstack-rpm-builder#packges-installed-in-conatiner)
- [Building packages](https://github.com/khos2ow/cloudstack-rpm-builder#building-packages)
  - [Clone Apache CloudStack source code](https://github.com/khos2ow/cloudstack-rpm-builder#clone-apache-cloudstack-source-code)
  - [Pull Docker Images](https://github.com/khos2ow/cloudstack-rpm-builder#pull-docker-images)
  - [Build Packages](https://github.com/khos2ow/cloudstack-rpm-builder#build-packages)
  - [Maven Cache](https://github.com/khos2ow/cloudstack-rpm-builder#maven-cache)
- [Build Help](https://github.com/khos2ow/cloudstack-rpm-builder#build-help)

# Supported tags and respective Dockerfile links
- [`latest`, `centos7` (centos7/Dockerfile)](https://github.com/khos2ow/cloudstack-rpm-builder/blob/master/centos7/Dockerfile)
- [`centos6` (centos6/Dockerfile)](https://github.com/khos2ow/cloudstack-rpm-builder/blob/master/centos6/Dockerfile)

# Packges installed in Conatiner
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

# Building packages
Building RPM packages with the Docker container is rather easy, a few steps are required:

## Clone Apache CloudStack source code
The first step required is to clone the CloudStack source code somewhere on the filesystem, in `/tmp` for example:

    cd /tmp
    git clone https://github.com/apache/cloudstack.git cloudstack

Now that you have done so we can continue.

## Pull Docker Images
Let's assume we want to build packages for CentOS 7 on CentOS 7. We pull that image first:

    docker pull khos2ow/cloudstack-rpm-builder:centos7

You can replace `centos7` tag by `centos6` or `latest` if you want.

## Build Packages
Now that we have the Docker images we can build packages by mapping `/tmp` into `/mnt/build` in the container. (Note that the container always expects the `cloudstack` code exists in `/mnt/build` path.)

    docker run \
        -v /tmp:/mnt/build \
        khos2ow/cloudstack-rpm-builder:centos7 --distribution centos7 [ARGS...]

Or if your local cloudstack folder has other name, you need to map it to `/mnt/build/cloudstack`.

    docker run \
        -v /tmp/cloudstack-custom-name:/mnt/build/cloudstack \
        khos2ow/cloudstack-rpm-builder:centos7 --distribution centos7 [ARGS...]

After the build has finished the *.rpm* packages are available in */tmp/cloudstack/dist/rpmbuild/RPMS* on the host system.

## Maven Cache
You can provide Maven cache folder (`~/.m2`) as a volume to the container to make it run faster.

    docker run \
        -v /tmp:/mnt/build \
        -v ~/.m2:/root/.m2 \
        khos2ow/cloudstack-rpm-builder:centos7 --distribution centos7 [ARGS...]

# Build Help
To see all the available options you can pass to `docker run ...` command:

    docker run \
        -v /tmp:/mnt/build \
        khos2ow/cloudstack-rpm-builder:centos7 --help

