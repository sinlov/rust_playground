# this file must use same folder at MakeDistTools.mk

depCheck:
	@cargo check --all --bins --examples --tests

depCheckRelease:
	@cargo check --all --bins --examples --tests --release

depFetch:
	@cargo fetch

depFetchVerbose:
	@cargo fetch --verbose

depVendor:
	@cargo vendor --quiet

depUp:
	@cargo update

depLock:
	@cargo check

depTree:
	@cargo tree

depToolsInstall:
	rustup check
	rustup component add rustfmt
	rustup component add clippy

depLintFmt:
	cargo fmt --all -- --check

depLintFmtEmitAllFiles:
	cargo fmt --all -- --emit files
	$(info can change to: cargo fmt -- --emit files|stdout)

depLintChecksPackageMistakes:
	cargo clippy -- -D warnings

depLintCheckNonDefaultCrateFeatures:
	@cargo clippy --all-targets --all-features -- -D warnings

depLints: depLintFmt depLintChecksPackageMistakes
	@echo "finish lint check"

depStyle:
	@cargo fmt

depTestOutput:
	@cargo test -- --show-output

depInstallTestCoverageTools:
	@echo "offical document https://doc.rust-lang.org/rustc/instrument-coverage.html"
	@echp ""
	@echo "need llvm-profdata https://www.llvm.org/docs/CommandGuide/llvm-profdata.html"
	@echo "need llvm-cov https://www.llvm.org/docs/CommandGuide/llvm-cov.html"

depTestList:
	$(info => show all test list by cargo)
	@cargo test -q -- --list

depTestBuild:
	@cargo test -q --no-run

depTestAll: depTestBuild
	$(info -> can use as: cargo test --test <foo>)
	@cargo test --tests -- --show-output

depTestIgnored:
	$(info -> run with test method as: #[ignore])
	@cargo test -- --ignored --show-output

depTestLib:
	@cargo test --lib -- --show-output

depTestBenches:
	$(info -> can use as: cargo test --benche <foo>)
	@cargo test --benches -- --show-output

depTestBins:
	$(info -> can use as: cargo test --bin <foo>)
	@cargo test --bins -- --show-output

depTestExamples:
	$(info -> can use as: cargo test --example <foo>)
	@cargo test --examples -- --show-output

depTestDoc:
	@cargo test --doc -- --show-output

depBenchAll:
	@cargo bench -q

depBenchBenches:
	@cargo bench -q --benches

depBenchLib:
	@cargo bench -q --lib

depBenchBins:
	@cargo bench -q --bins

cleanCargoLLVMCovData:
	-@$(RM) *.profraw
	-@$(RM) *.profdata

depTestCoverage: export RUSTFLAGS=-C instrument-coverage
depTestCoverage:
	cargo test --tests
	$(info then see test coverage doc as: https://doc.rust-lang.org/rustc/instrument-coverage.html)