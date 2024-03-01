# this file must use same folder at MakeBasicEnv.mk
# usage:
# include z-MakefileUtils/MakeCargoFlamegraph.mk
INFO_RUST_FLAMEGRAPH_SVG_PATH=flamegraph.svg

cleanFlamegraphOut:
	-@$(RM) -f perf.data.old
	-@$(RM) -f perf.data
	$(info has clean: perf.data)
	-@$(RM) -f ${INFO_RUST_FLAMEGRAPH_SVG_PATH}
	$(info has clean: ${INFO_RUST_FLAMEGRAPH_SVG_PATH})

flamegraphDev:
	cargo flamegraph --dev --root

helpCargoFlamegraph:
	@echo "this tools use https://github.com/flamegraph-rs/flamegraph"
	@echo " must install as: cargo install flamegraph"
	@echo "$$ make cleanFlamegraphOut                  ~> clean flamegraph out"
	@echo "$$ make flamegraphDev                       ~> run dev mode and save at ${INFO_RUST_FLAMEGRAPH_SVG_PATH}"
	@echo ""