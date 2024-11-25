.PHONY: test check clean build dist all
# can change this by env:ENV_CI_DIST_VERSION use and change by env:ENV_CI_DIST_MARK by CI
ENV_DIST_VERSION=0.1.2
ENV_DIST_MARK=

ROOT_NAME =rust_playground

# MakeDocker.mk settings start
ROOT_OWNER =drone-demo
ROOT_PARENT_SWITCH_TAG=1.67.1-buster
# for image local build
INFO_TEST_BUILD_DOCKER_PARENT_IMAGE=rust
# for image running
INFO_BUILD_DOCKER_FROM_IMAGE=alpine:3.17
INFO_BUILD_DOCKER_FILE=Dockerfile
INFO_TEST_BUILD_DOCKER_FILE=Dockerfile.s6
# MakeDocker.mk settings end

ENV_RUSTUP_DIST_SERVER=https://rsproxy.cn
ENV_RUSTUP_UPDATE_ROOT=https://rsproxy.cn/rustup
ENV_RUSTUP_TOOLCHAINS=${ENV_HOME_PATH}/.rustup/toolchains/
ENV_CARGO_REGISTRY=${ENV_HOME_PATH}/.cargo/registry
ENV_CARGO_PROXY_CONFIG=${ENV_ROOT}/z-MakefileUtils/proxy-rsproxy.toml
ENV_CARGO_TARGET_PATH=${ENV_ROOT}/target
ENV_INFO_CACHE_MID_PATH= ${ENV_ROOT}/src/path_to_grammar.rs

include z-MakefileUtils/MakeBasicEnv.mk
include z-MakefileUtils/MakeGitTagHelper.mk
include z-MakefileUtils/MakeCargo.mk
include z-MakefileUtils/MakeCargoTarpaulin.mk
include z-MakefileUtils/MakeCargoFlamegraph.mk
#include z-MakefileUtils/MakeDocker.mk
include z-MakefileUtils/MakeDistTools.mk

ENV_MODULE_FOLDER ?= ${ENV_ROOT}
ENV_MODULE_MANIFEST = ${ENV_ROOT}/package.json
ENV_MODULE_CARGO_CONFIG = ${ENV_ROOT}/Cargo.toml

.PHONY: env
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

.PHONY: env.git
env.git:
	@echo "build env"
	@echo "ENV_GIT_BRANCH_LAST_INFO :                ${ENV_GIT_BRANCH_LAST_INFO}"
	@echo "ENV_GIT_COMMIT_ID :                       ${ENV_GIT_COMMIT_ID}"
	@echo "ENV_GIT_COMMIT_ID_SHORT :                 ${ENV_GIT_COMMIT_ID_SHORT}"
	@echo ""

.PHONY: dep
dep: dep.check

.PHONY: up
up:	dep.up

.PHONY: init
init: env
	@rustup show
	@cargo --version
	@echo "=> just init finish this project for rust"

.PHONY: lints
lints: dep.lint

.PHONY: test
test: dep
	@cargo test

.PHONY: test.nocapture
test.nocapture:
	@cargo test --all --all-features --no-fail-fast -- --nocapture

.PHONY: test.clean
test.clean: dep

.PHONY: test.coverage
test.coverage: dep

.PHONY: style
style: dep.lint

.PHONY: ci
ci: dep lints test.nocapture

.PHONY: ci.coverage
ci.coverage: ci cargo.tarpaulin.out.std

.PHONY: run.grammar
run.grammar: export TEST_FILTER=grammar
run.grammar: dep
	cargo run

.PHONY: run.tools
run.tools: export TEST_FILTER=tools
run.tools: dep
	cargo run

.PHONY: run.thread.exp
run.thread.exp: export TEST_FILTER=thread_exp
run.thread.exp: dep
	cargo run

.PHONY: run
run: dep
	cargo run

.PHONY: run.all
run.all: run.grammar run.tools run.thread.exp

.PHONY: build
build: dep
	cargo build

.PHONY: build.release
build.release: dep
	cargo build --release

.PHONY: clean
clean.test: clean.cargo.llvm.cov.data clean.out.tarpaulin

.PHONY: clean.mid.path
clean.mid.path:
	@$(RM) -r ${ENV_INFO_CACHE_MID_PATH}
	$(info has clean path: ${ENV_INFO_CACHE_MID_PATH})

.PHONY: clean.build.target
clean.build.target:
	@$(RM) -r ${ENV_CARGO_TARGET_PATH}
	$(info has clean: ${ENV_CARGO_TARGET_PATH})

.PHONY: clean.all
clean.all: clean.test clean.mid.path clean.build.target clean.flame.graph.out cleanDistAll
	@echo "clean finish"

.PHONY: all
all: dep ci ci.coverage clean

.PHONY: helpProjectRoot
helpProjectRoot:
	@echo "Help: Project root Makefile"
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
	@echo "$$ make init                       ~> init this project see basic env"
	@echo "$$ make dep                        ~> install dependencies"
	@echo "~> make ci                         ~> run CI tools tasks"
	@echo "~> make ci.coverage                ~> run CI coverage"
	@echo ""
	@echo "~> make all                        ~> run commonly used
	@echo ""
	@echo "$$ make run                        ~> run in dev mode"
	@echo "$$ make run.grammar                ~> run only grammar"
	@echo "$$ make run.tools                  ~> run only tools"
	@echo "$$ make run.thread.exp             ~> run only thread_exp"
	@echo "$$ make run.all                    ~> run all"

.PHONY: help
help: helpProjectRoot
	@echo "== show more help"
	@echo ""
	@echo "-- more info see Makefile include --"