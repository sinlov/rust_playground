# this file must use same folder at MakeBasicEnv.mk
# https://crates.io/crates/cargo-tarpaulin
# usage:
# include z-MakefileUtils/MakeCargoTarpaulin.mk

cleanOutTarpaulin:
	-@$(RM) -f cobertura.xml
	-@$(RM) -f tarpaulin-report.json
	-@$(RM) -f tarpaulin-report.html
	-@$(RM) -f lcov.info

cargoTarpaulinInstall:
	cargo install cargo-tarpaulin

cargoTarpaulinOutStd:
	cargo tarpaulin --all-features --out Stdout

cargoTarpaulinOutXml:
	cargo tarpaulin --all-features --out Xml

cargoTarpaulinOutJson:
	cargo tarpaulin --all-features --out Json

cargoTarpaulinOutHtml:
	cargo tarpaulin --all-features --out Html

cargoTarpaulinOutLcov:
	cargo tarpaulin --all-features --out Lcov

helpCargoTarpaulin:
	@echo "this tools use https://crates.io/crates/cargo-tarpaulin"
	@echo " must install as: cargo install cargo-tarpaulin"
	@echo "$$ make cargoTarpaulinInstall               ~> install"
	@echo "$$ make cleanOutTarpaulin                   ~> clean all out by tarpaulin"
	@echo "$$ make cargoTarpaulinOutStd                ~> out Stdout"
	@echo "$$ make cargoTarpaulinOutXml                ~> out Xml cobertura.xml"
	@echo "$$ make cargoTarpaulinOutJson               ~> out json tarpaulin-report.json"
	@echo "$$ make cargoTarpaulinOutHtml               ~> out Html tarpaulin-report.html"
	@echo "$$ make cargoTarpaulinOutLcov               ~> out Lcov lcov.info"
	@echo ""