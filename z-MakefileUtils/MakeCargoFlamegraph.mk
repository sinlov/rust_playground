# this file must use same folder at MakeBasicEnv.mk
# usage:
# include z-MakefileUtils/MakeCargoFlamegraph.mk
INFO_RUST_FLAMEGRAPH_SVG_PATH=flamegraph.svg

.PHONY: clean.flame.graph.out
clean.flame.graph.out:
	-@$(RM) -f perf.data.old
	-@$(RM) -f perf.data
	$(info has clean: perf.data)
	-@$(RM) -f ${INFO_RUST_FLAMEGRAPH_SVG_PATH}
	$(info has clean: ${INFO_RUST_FLAMEGRAPH_SVG_PATH})

.PHONY: flamegraph.dev
flamegraph.dev:
	cargo flamegraph --dev --root

.PHONY: help.cargo.flamegraph
help.cargo.flamegraph:
	@echo "this tools use https://github.com/flamegraph-rs/flamegraph"
	@echo " must install as: cargo install flamegraph"
	@echo "$$ make clean.flame.graph.out                  ~> clean flamegraph out"
	@echo "$$ make flamegraph.dev                       ~> run dev mode and save at ${INFO_RUST_FLAMEGRAPH_SVG_PATH}"
	@echo ""