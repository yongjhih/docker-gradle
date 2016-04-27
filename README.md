[![Docker Pulls](https://img.shields.io/docker/pulls/yongjhih/gradle.svg)](https://hub.docker.com/r/yongjhih/gradle/)
[![Docker Stars](https://img.shields.io/docker/stars/yongjhih/gradle.svg)](https://hub.docker.com/r/yongjhih/gradle/)
[![Docker Size](https://img.shields.io/imagelayers/image-size/yongjhih/gradle/latest.svg)](https://imagelayers.io/?images=yongjhih/gradle:latest)
[![Docker Layers](https://img.shields.io/imagelayers/layers/yongjhih/gradle/latest.svg)](https://imagelayers.io/?images=yongjhih/gradle:latest)
[![Travis CI](https://img.shields.io/travis/yongjhih/docker-gradle.svg)](https://travis-ci.org/yongjhih/docker-gradle)

# docker for gradle

## Usage

Generate gradle wrapper:

```sh
docker run -it -v $(pwd):/src yongjhih/gradle gradle wrapper --gradle-version 2.13
```

## Deploy

```sh
./generate-stackbrew-library.sh > /tmp/gradle
cd ..
git clone git@github.com:yongjhih/official-images.git
cd official-images
mv /tmp/gradle library/
cd bashbrew
./bashbrew.sh build --no-build gradle
git commit -am 'Update gradle'
git push origin HEAD:gradle
```
