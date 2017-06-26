# Haukur's shell tools image

This is a docker image that uses CentOS 7 as the base image. It contains tools that I frequently use on a daily basis.

## Getting started

Created volume ``docker volume create haukurvolume``, build the Dockerfile ``docker build . -t haukur`` and run it ``docker run -it -v haukurvolume:/persistance haukur``

## What's included?

I use Bash as my shell.


Programming languages and build/automation tools:
* .NET Core
* Java
  * Maven
  * Sbt
* Scala
  * Sbt
* Go
* NodeJS
  * NPM
* Python
  * pip
* GCC

Tools included:
* Git (copies id_rsa private key if it exists)
* NMAP
* Wget
* Lynx
* vim
* netcat
* http-server
* Terraform
* AWS CLI
* Puppet