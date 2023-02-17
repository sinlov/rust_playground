# this file must use same folder at MakeDistTools.mk

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
