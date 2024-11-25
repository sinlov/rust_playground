# this file must use as base Makefile
# use as:
# include z-MakefileUtils/MakeGitTagHelper.mk
# need var
# ENV_DIST_VERSION dist version
# ENV_ROOT project root path


ENV_MODULE_MANIFEST = ${ENV_ROOT}/package.json

.PHONY: tagUtils
tagUtils:
	node -v
	npm -v
	npm install -g commitizen cz-conventional-changelog conventional-changelog-cli

.PHONY: tagVersionHelp
tagVersionHelp:
	@echo "-> please check to change version, now is ${ENV_DIST_VERSION}"
	@echo "change check at ${ENV_ROOT}/Makefile:3"
	@echo "change check at ${ENV_MODULE_MANIFEST}:3"
	@echo ""
	@echo "please check all file above!"
	@echo ""

.PHONY: tagBefore
tagBefore: tagVersionHelp
	conventional-changelog -i CHANGELOG.md -s  --skip-unstable
	@echo ""
	@echo "place check all file, then add git tag to push!"

.PHONY: helpGitTag
helpGitTag:
	@echo "  first need init utils"
	@echo "$$ make tagUtils            ~> npm install git cz"
	@echo "  1. add change log, then write git commit , replace [ git commit -m ] to [ git cz ]"
	@echo "  2. generate CHANGELOG.md doc: https://github.com/commitizen/cz-cli#conventional-commit-messages-as-a-global-utility"
	@echo ""
	@echo "  then you can generate CHANGELOG.md as"
	@echo "$$ make tagVersionHelp      ~> print version when make tageBefore will print again"
	@echo "$$ make tagBefore           ~> generate CHANGELOG.md and copy to module folder"
	@echo ""