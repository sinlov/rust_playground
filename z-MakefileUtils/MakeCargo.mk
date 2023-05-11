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

depLintFmt:
	@cargo fmt --all -- --check

depLintChecksPackageMistakes:
	@cargo clippy -- -D warnings

depLints: depCheckRelease depLintFmt depLintChecksPackageMistakes
	@echo "finish lint check"