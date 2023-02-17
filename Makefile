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

ENV_RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
ENV_RUSTUP_UPDATE_ROOT=https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup
ENV_RUSTUP_TOOLCHAINS=${ENV_HOME_PATH}/.rustup/toolchains/
ENV_CARGO_REGISTRY=${ENV_HOME_PATH}/.cargo/registry
ENV_CARGO_PROXY_CONFIG=${ENV_ROOT}/z-MakefileUtils/proxy-tuna.toml
ENV_CARGO_TARGET_PATH=${ENV_ROOT}/target
ENV_INFO_CATCHE_MID_PATH= ${ENV_ROOT}/src/path_to_grammar.rs

include z-MakefileUtils/MakeBasicEnv.mk
include z-MakefileUtils/MakeDistTools.mk
include z-MakefileUtils/MakeDocker.mk
include z-MakefileUtils/MakeCargo.mk

ENV_MODULE_FOLDER ?= ${ENV_ROOT}
ENV_MODULE_MANIFEST = ${ENV_ROOT}/package.json
ENV_MODULE_CARGO_CONFIG = ${ENV_ROOT}/Cargo.toml

env: envBasic
	@echo "== project env info start =="
	@echo ""
	@echo "ENV_RUSTUP_TOOLCHAINS                    ${ENV_RUSTUP_TOOLCHAINS}"
	@echo "ENV_CARGO_REGISTRY                       ${ENV_CARGO_REGISTRY}"
	@echo "ENV_CARGO_PROXY_CONFIG                   ${ENV_CARGO_PROXY_CONFIG}"
	@echo "ENV_CARGO_TARGET_PATH                    ${ENV_CARGO_TARGET_PATH}"
	@echo ""
	@echo "ENV_DIST_VERSION :                       ${ENV_DIST_VERSION}"
	@echo "ENV_DIST_MARK :                          ${ENV_DIST_MARK}"
	@echo ""
	@echo "== project env info end =="

ENV_GIT_COMMIT_ID=$(shell git rev-parse HEAD)
ENV_GIT_COMMIT_ID_SHORT=$(shell git rev-parse --short HEAD)
ENV_GIT_BRANCH_LAST_INFO=$(shell git rev-parse --abbrev-ref HEAD)

envGit:
	@echo "build env"
	@echo "ENV_GIT_BRANCH_LAST_INFO :                ${ENV_GIT_BRANCH_LAST_INFO}"
	@echo "ENV_GIT_COMMIT_ID :                       ${ENV_GIT_COMMIT_ID}"
	@echo "ENV_GIT_COMMIT_ID_SHORT :                 ${ENV_GIT_COMMIT_ID_SHORT}"
	@echo ""

dep: depFetch

up:	depUp

init: dep
	@rustup show
	@cargo --version
	@echo "=> just init finish this project for rust"

style: dep

check: dep

runGrammar: dep
	env TEST_FILTER=grammar cargo run

runTools: dep
	env TEST_FILTER=tools cargo run

run: dep
	cargo run

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
	@echo "change check at ${ENV_MODULE_CARGO_CONFIG}:3"
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