#!/usr/bin/env bash
echo -e "\e[32m****** 1、开始打包前端docker镜像 ******";

echo -e "\e[32m****** 2、目录变量 ******";
# 工作目录
WORK_DIR=$(pwd);
# build脚本目录
BUILD_SH_DIR=$WORK_DIR/build-sh;
# 打包默认输出资源目录，若修改，此处需同步修改
BUILD_OUT_DIR=$WORK_DIR/build;
# DOCKER_CONFIG_DIR docker配置文件目录
DOCKER_CONFIG_DIR=$WORK_DIR/docker;
echo WORK_DIR: $WORK_DIR;
echo BUILD_SH_DIR: $BUILD_SH_DIR
echo BUILD_OUT_DIR: $BUILD_OUT_DIR
echo DOCKER_CONFIG_DIR: $DOCKER_CONFIG_DIR

PROJECT_NAME=my-react-app
GIT_SHORT_HASH=$(git rev-parse --short HEAD)
echo $GIT_SHORT_HASH

# 回到工作目录
cd $WORK_DIR;
echo -e "\e[32m****** 3、安装前端依赖 npm install --verbose ******";
npm install --verbose;

echo -e "\e[32m****** 4、打包前端项目 npm run build ******";
npm run build;

echo -e "\e[32m****** 5、开始打包docker镜像 docker build ******";

echo $(pwd);

docker build --build-arg HOST_WORK_DIR=$WORK_DIR -f $DOCKER_CONFIG_DIR/dockerfile-dev  -t $PROJECT_NAME.$GIT_SHORT_HASH .
