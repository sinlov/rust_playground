.PHONY: test check clean build dist all
# can change this by env:ENV_CI_DIST_VERSION use and change by env:ENV_CI_DIST_MARK by CI
ENV_DIST_VERSION=0.1.2
ENV_DIST_MARK=

ROOT_NAME=rust_playground

# MakeDocker.mk settings start
ROOT_OWNER=drone-demo
ROOT_PARENT_SWITCH_TAG=1.67.1-buster
# for image local build
INFO_TEST_BUILD_DOCKER_PARENT_IMAGE=rust
# for image running
INFO_BUILD_DOCKER_FROM_IMAGE=alpine:3.17
INFO_BUILD_DOCKER_FILE=Dockerfile
INFO_TEST_BUILD_DOCKER_FILE=Dockerfile.s6
# MakeDocker.mk settings end

# os env show PLATFORM
ifeq ($(OS),Windows_NT)
  PLATFORM=Windows
  # do windows powershell
  ENV_ROOT ?= $(shell pwd)
  ENV_HOME_PATH ?= ${HOME}
  # ENV_NOW_TIME_FORMAT = $(shell echo %Date:~0,4%%Date:~5,2%%Date:~8,2%)
  ENV_NOW_TIME_FORMAT = $(shell echo %Date:~0,4%-%Date:~5,2%-%Date:~8,2%-%time:~0,2%-%time:~3,2%-%time:~6,2%)
else
  OS_UNAME ?= $(shell echo `uname`) # Linux Darwin
  OS_BIT ?= $(shell echo `uname -m`) # x86_64 arm64
  ENV_ROOT ?= $(shell pwd)
  ENV_HOME_PATH ?= ${HOME}
  # ENV_NOW_TIME_FORMAT = $(shell date -u '+%Y-%m-%d-%H-%M-%S')
  ENV_NOW_TIME_FORMAT = $(shell date '+%Y-%m-%d-%H-%M-%S')
  ifeq ($(shell uname),Darwin)
    PLATFORM="MacOS"
    ifeq ($(shell echo ${OS_BIT}),arm64)
      PLATFORM="MacOS-Apple-Silicon"
    else
      PLATFORM="MacOS-Intel"
    endif
    # do MacOS

  else
    PLATFORM="Unix-Like"
    # do unix
  endif
endif

# change by env
ifneq ($(strip $(ENV_CI_DIST_VERSION)),)
    ENV_DIST_VERSION=${ENV_CI_DIST_VERSION}
endif

# this can change to other mark https://docs.drone.io/pipeline/environment/substitution/
ifneq ($(strip $(DRONE_TAG)),)
$(info -> change ENV_DIST_MARK by DRONE_TAG)
    ENV_DIST_MARK=-tag.${DRONE_TAG}
else
    ifneq ($(strip $(DRONE_COMMIT)),)
$(info -> change ENV_DIST_MARK by DRONE_COMMIT)
        ENV_DIST_MARK=-${DRONE_COMMIT}
    endif
endif
ifneq ($(strip $(GITHUB_SHA)),)
$(info -> change ENV_DIST_MARK by GITHUB_SHA)
    ENV_DIST_MARK=-${GITHUB_SHA}# https://docs.github.com/cn/enterprise-server@2.22/actions/learn-github-actions/environment-variables
endif
ifeq ($(strip $(ENV_DIST_MARK)),)
$(info -> change ENV_DIST_MARK by git)
    ENV_DIST_MARK=-$(strip $(shell git --no-pager rev-parse --short HEAD))
endif
ifneq ($(strip $(ENV_CI_DIST_MARK)),)
$(info -> change ENV_DIST_MARK by ENV_CI_DIST_MARK)
    ENV_DIST_MARK=-${ENV_CI_DIST_MARK}
endif

ENV_RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
ENV_RUSTUP_UPDATE_ROOT=https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup
ENV_RUSTUP_TOOLCHAINS=${ENV_HOME_PATH}/.rustup/toolchains/
ENV_CARGO_REGISTRY=${ENV_HOME_PATH}/.cargo/registry
ENV_CARGO_PROXY_CONFIG=${ENV_ROOT}/z-MakefileUtils/proxy-tuna.toml
ENV_CARGO_TARGET_PATH=${ENV_ROOT}/target
ENV_INFO_CATCHE_MID_PATH= ${ENV_ROOT}/src/path_to_grammar.rs

include z-MakefileUtils/MakeDocker.mk
include z-MakefileUtils/MakeCargo.mk
include z-MakefileUtils/MakeDistTools.mk

env:
	@echo ------- start show env ---------
	@echo ""
	@echo "PLATFORM                                 ${PLATFORM}"
	@echo "OS_BIT                                   ${OS_BIT}"
	@echo ""
	@echo "ENV_NOW_TIME_FORMAT                      ${ENV_NOW_TIME_FORMAT}"
	@echo "ENV_HOME_PATH                            ${ENV_HOME_PATH}"
	@echo "ENV_ROOT                                 ${ENV_ROOT}"
	@echo "ENV_RUSTUP_TOOLCHAINS                    ${ENV_RUSTUP_TOOLCHAINS}"
	@echo "ENV_CARGO_REGISTRY                       ${ENV_CARGO_REGISTRY}"
	@echo "ENV_CARGO_PROXY_CONFIG                   ${ENV_CARGO_PROXY_CONFIG}"
	@echo "ENV_CARGO_TARGET_PATH                    ${ENV_CARGO_TARGET_PATH}"
	@echo ""
	@echo "build env"
	@echo "ENV_GIT_BRANCH_LAST_INFO :               ${ENV_GIT_BRANCH_LAST_INFO}"
	@echo "ENV_GIT_COMMIT_ID :                      ${ENV_GIT_COMMIT_ID}"
	@echo "ENV_GIT_COMMIT_ID_SHORT :                ${ENV_GIT_COMMIT_ID_SHORT}"
	@echo ""
	@echo "ENV_DIST_VERSION :                       ${ENV_DIST_VERSION}"
	@echo "ENV_DIST_MARK :                          ${ENV_DIST_MARK}"
	@echo ""
	@echo ------- end  show env ---------

dep: depFetch

up:	depUp

init: dep
	@rustup show
	@cargo --version
	@echo "=> just init finish this project for rust"

style: dep

check: dep

grammar: dep
	env TEST_FILTER=$(INFO_TEST_FILTER_GROUP) cargo run

run: dep
	cargo run

runDev: dep
	env PORT=$(INFO_PORT_DEV) cargo run

runTest: dep
	env PORT=$(INFO_PORT_TEST) cargo run

test: dep
	cargo test

build: dep
	cargo build

buildRelease: dep
	cargo build --release

cleanMidPath:
	-@RM -r ${ENV_INFO_CATCHE_MID_PATH}
	$(info has clean path: ${ENV_INFO_CATCHE_MID_PATH})

cleanBuildTarget:
	-@RM -r ${ENV_CARGO_TARGET_PATH}
	$(info has clean: ${ENV_CARGO_TARGET_PATH})

cleanAll: cleanMidPath cleanBuildTarget
	@echo "clean finish"

utils:
	node -v
	npm -v
	npm install -g commitizen cz-conventional-changelog conventional-changelog-cli

tagVersionHelp:
	@echo "-> please check to change version, now is ${ENV_DIST_VERSION}"
	@echo "change check at ${ENV_ROOT}/Makefile:3"
	@echo "change check at ${ENV_MODULE_MANIFEST}:3"
	@echo ""
	@echo "please check all file above!"
	@echo ""

tagBefore: tagVersionHelp
	conventional-changelog -i CHANGELOG.md -s  --skip-unstable
	@echo ""
	@echo "place check all file, then add git tag to push!"

help:
	@echo "unity makefile template"
	@echo " module folder   path: ${ENV_MODULE_FOLDER}"
	@echo " module version    is: ${ENV_DIST_VERSION}"
	@echo " module manifest path: ${ENV_MODULE_MANIFEST}"
	@echo ""
	@echo "  first need init utils"
	@echo "$$ make utils               ~> npm install git cz"
	@echo "  1. add change log, then write git commit , replace [ git commit -m ] to [ git cz ]"
	@echo "  2. generate CHANGELOG.md doc: https://github.com/commitizen/cz-cli#conventional-commit-messages-as-a-global-utility"
	@echo ""
	@echo "  then you can generate CHANGELOG.md as"
	@echo "$$ make tagVersionHelp      ~> print version when make tageBefore will print again"
	@echo "$$ make tagBefore           ~> generate CHANGELOG.md and copy to module folder"
	@echo ""
	@echo "This project use python 3.9.+"
	@echo "------    ------"
	@echo "- first run you can use make init to check environment"
	@echo "------    ------"
	@echo ""
	@echo "$$ make init                     ~> init this project"
	@echo ""
	@echo "$$ make run                      ~> run in dev mode"
	@echo "$$ make runProd                  ~> run in prod mode"