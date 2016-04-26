[![Docker Pulls](https://img.shields.io/docker/pulls/yongjhih/gradle.svg)](https://hub.docker.com/r/yongjhih/gradle/)
[![Docker Stars](https://img.shields.io/docker/stars/yongjhih/gradle.svg)](https://hub.docker.com/r/yongjhih/gradle/)
[![Docker Size](https://img.shields.io/imagelayers/image-size/yongjhih/gradle/latest.svg)](https://imagelayers.io/?images=yongjhih/gradle:latest)
[![Docker Layers](https://img.shields.io/imagelayers/layers/yongjhih/gradle/latest.svg)](https://imagelayers.io/?images=yongjhih/gradle:latest)

# docker for gradle

## Usage

Generate gradle wrapper:

```sh
docker run -it -v $(pwd):/src yongjhih/gradle gradle wrapper --gradle-version 2.13
```
