# this file must use same folder at MakeDistTools.mk

depCheck:
	@cargo check

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

depLints: depLintFmt depLintChecksPackageMistakes
	@echo "finish lint check"