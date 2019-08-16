.PHONY: test check clean build dist all

# change test case group
INFO_TEST_FILTER_GROUP := grammar

INFO_CATCHE_BUILD ?= ./target
INFO_CATCHE_MID_PATH ?= ./src/path_to_grammar.rs

INFO_DOCKER_RUST_TAG := 1.36.0
INFO_DOCKER_RUST_NAME ?= rust
INFO_DOCKER_CONTAINER_NAME ?= rust-play-ground
INFO_PORT_DEV ?= 30080
INFO_PORT_TEST ?= 30090

helpBuild:
	@echo "make run ~> run at locat project ./"
	@echo "make runDev ~> run at locat project ./ env $(INFO_PORT_DEV)"
	@echo "make runTest ~> run at locat project ./ env $(INFO_PORT_TEST)"
	@echo "make build ~> run buold at locat project ./ env $(INFO_PORT_DEV)"
	@echo "make buildRelease ~> run buold at locat project ./ env $(INFO_PORT_RELEASE)"
	@echo ""
	@echo "make test ~> run test case"

help:
	@echo "-> this is project of rust base"
	@echo " just use rust framework and CLI rustc, cargo"
	@echo " you can use task below"
	@echo ""
	@echo "make cleanAll ~> clean all build ./"
	@echo "make grammar ~> run env TEST_FILTER=$(INFO_TEST_FILTER_GROUP) ./"
	@echo "make grammarDocker ~> run env TEST_FILTER=$(INFO_TEST_FILTER_GROUP) ./ use docker $(INFO_DOCKER_RUST_NAME):$(INFO_DOCKER_RUST_TAG)"
	@echo ""
	@echo "Warning! only support make run and cleanAll this used Makefile template generation"

cleanMidPath:
	if [ -f $(INFO_CATCHE_MID_PATH) ]; then rm -rf $(INFO_CATCHE_MID_PATH); else echo "~> cleanMidPath finish"; fi

cleanBuild: cleanMidPath
	if [ -d $(INFO_CATCHE_BUILD) ]; then rm -rf $(INFO_CATCHE_BUILD); else echo "~> cleanBuild finish"; fi

cleanAll: cleanBuild
	@echo "clean finish"

checkCargo:
	@echo "=> If check env [ cargo ] error please install at https://www.rust-lang.org/tools/install"
	@cargo version

grammar: checkCargo
	env TEST_FILTER=$(INFO_TEST_FILTER_GROUP) cargo run

grammarDocker:
	docker version
	docker run --rm --env TEST_FILTER=$(INFO_TEST_FILTER_GROUP) --name $(INFO_DOCKER_CONTAINER_NAME) --user "$$(id -u)":"$$(id -g)" -v "$$PWD":/usr/src/myapp -w /usr/src/myapp $(INFO_DOCKER_RUST_NAME):$(INFO_DOCKER_RUST_TAG) cargo run

run:	checkCargo
	cargo run

runDev: checkCargo
	env PORT=$(INFO_PORT_DEV) cargo run

runTest: checkCargo
	env PORT=$(INFO_PORT_TEST) cargo run

test: checkCargo
	cargo test

build: checkCargo
	cargo build

buildRelease: checkCargo
	cargo build --release

