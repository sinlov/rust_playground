# this file must use same folder at MakeDistTools.mk

.PHONY: dep.check
dep.check:
	@cargo check --all --bins --examples --tests

.PHONY: dep.check.release
dep.check.release:
	@cargo check --all --bins --examples --tests --release

.PHONY: dep.fetch
dep.fetch:
	@cargo fetch

.PHONY: dep.fetch.verbose
dep.fetch.verbose:
	@cargo fetch --verbose

.PHONY: dep.vendor
dep.vendor:
	@cargo vendor --quiet

.PHONY: dep.up
dep.up:
	@cargo update

.PHONY: dep.lock
dep.lock:
	@cargo check

.PHONY: dep.tree
dep.tree:
	@cargo tree

.PHONY: dep.tools.install
dep.tools.install:
	rustup check
	rustup component add rustfmt
	rustup component add clippy

.PHONY: dep.lint.fmt
dep.lint.fmt:
	cargo fmt --all -- --check

.PHONY: dep.lint.fmt.emit.all.files
dep.lint.fmt.emit.all.files:
	cargo fmt --all -- --emit files
	$(info can change to: cargo fmt -- --emit files|stdout)

.PHONY: dep.lint.checks.package.mistakes
dep.lint.check.package.mistakes:
	cargo clippy -- -D warnings

.PHONY: dep.lint.check.non.default.crate.features
dep.lint.check.non.default.crate.features:
	@cargo clippy --all-targets --all-features -- -D warnings

.PHONY: dep.lint
dep.lint: dep.lint.fmt dep.lint.checks.package.mistakes
	@echo "finish lint check"

.PHONY: dep.style
dep.style:
	@cargo fmt

.PHONY: dep.test
dep.test.output:
	@cargo test -- --show-output

.PHONY: dep.install.test.coverage.tools
dep.install.test.coverage.tools:
	@echo "official document https://doc.rust-lang.org/rustc/instrument-coverage.html"
	@echo ""
	@echo "need llvm-profdata https://www.llvm.org/docs/CommandGuide/llvm-profdata.html"
	@echo "need llvm-cov https://www.llvm.org/docs/CommandGuide/llvm-cov.html"

.PHONY: dep.test.list
dep.test.list:
	$(info => show all test list by cargo)
	@cargo test -q -- --list

.PHONY: dep.test.build
dep.test.build:
	@cargo test -q --no-run

.PHONY: dep.test.all
dep.test.all: dep.test.build
	$(info -> can use as: cargo test --test <foo>)
	@cargo test --tests -- --show-output

.PHONY: dep.test.ignored
dep.test.ignored:
	$(info -> run with test method as: #[ignore])
	@cargo test -- --ignored --show-output

.PHONY: dep.test.lib
dep.test.lib:
	@cargo test --lib -- --show-output

.PHONY: dep.test.benches
dep.test.benches:
	$(info -> can use as: cargo test --benche <foo>)
	@cargo test --benches -- --show-output

.PHONY: dep.test.bins
dep.test.bins:
	$(info -> can use as: cargo test --bin <foo>)
	@cargo test --bins -- --show-output

.PHONY: dep.test.examples
dep.test.examples:
	$(info -> can use as: cargo test --example <foo>)
	@cargo test --examples -- --show-output

.PHONY: dep.test.doc
dep.test.doc:
	@cargo test --doc -- --show-output

.PHONY: dep.bench.all
dep.bench.all:
	@cargo bench -q

.PHONY: dep.bench.benches
dep.bench.benches:
	@cargo bench -q --benches

.PHONY: dep.bench.lib
dep.bench.lib:
	@cargo bench -q --lib

.PHONY: dep.bench.bins
dep.bench.bins:
	@cargo bench -q --bins

.PHONY: clean.cargo.llvm.cov.data
clean.cargo.llvm.cov.data:
	-@$(RM) *.profraw
	-@$(RM) *.profdata

.PHONY: dep.test.coverage
dep.test.coverage: export RUSTFLAGS=-C instrument-coverage
dep.test.coverage:
	cargo test --tests
	$(info then see test coverage doc as: https://doc.rust-lang.org/rustc/instrument-coverage.html)