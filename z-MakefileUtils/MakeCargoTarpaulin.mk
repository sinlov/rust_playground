# this file must use same folder at MakeBasicEnv.mk
# https://crates.io/crates/cargo-tarpaulin
# usage:
# include z-MakefileUtils/MakeCargoTarpaulin.mk

.PHONY: clean.out.tarpaulin
clean.out.tarpaulin:
	-@$(RM) -f cobertura.xml
	-@$(RM) -f tarpaulin-report.json
	-@$(RM) -f tarpaulin-report.html
	-@$(RM) -f lcov.info

.PHONY: cargo.tarpaulin.install
cargo.tarpaulin.install:
	cargo install cargo-tarpaulin

.PHONY: cargo.tarpaulin.out.std
cargo.tarpaulin.out.std:
	cargo tarpaulin --all-features --out Stdout

.PHONY: cargo.tarpaulin.out.xml
cargo.tarpaulin.out.xml:
	cargo tarpaulin --all-features --out Xml

.PHONY: cargo.tarpaulin.out.json
cargo.tarpaulin.out.json:
	cargo tarpaulin --all-features --out Json

.PHONY: cargo.tarpaulin.out.html
cargo.tarpaulin.out.html:
	cargo tarpaulin --all-features --out Html

.PHONY: cargo.tarpaulin.out.lcov
cargo.tarpaulin.out.lcov:
	cargo tarpaulin --all-features --out Lcov

.PHONY: help.cargo.tarpaulin
help.cargo.tarpaulin:
	@echo "this tools use https://github.com/xd009642/tarpaulin"
	@echo " must install as: cargo install cargo-tarpaulin"
	@echo "$$ make cargo.tarpaulin.install                ~> install tarpaulin"
	@echo "$$ make clean.out.tarpaulin                    ~> clean all out by tarpaulin"
	@echo "$$ make cargo.tarpaulin.out.std                ~> out Stdout"
	@echo "$$ make cargo.tarpaulin.out.xml                ~> out Xml cobertura.xml"
	@echo "$$ make cargo.tarpaulin.out.json               ~> out json tarpaulin-report.json"
	@echo "$$ make cargo.tarpaulin.out.html               ~> out Html tarpaulin-report.html"
	@echo "$$ make cargo.tarpaulin.out.lcov               ~> out Lcov lcov.info"
	@echo ""