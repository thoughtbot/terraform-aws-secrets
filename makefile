.SECONDEXPANSION:

export TF_CLI_CONFIG_FILE := $(CURDIR)/.terraformrc

MODULES         := $(foreach main,$(wildcard */main.tf),$(subst /main.tf,,$(main)))
MODULEMAKEFILES := $(foreach module,$(MODULES),$(module)/makefile)
MAKEMODULES     := $(foreach module,$(MODULES),$(module)/default)
CLEANMODULES    := $(foreach module,$(MODULES),$(module)/clean)

.PHONY: default
default: modules

.PHONY: fmt
fmt:
	terraform fmt -recursive

.PHONY: modules
modules: makefiles makemodules

.PHONY: makefiles
makefiles: $(MODULEMAKEFILES)

$(MODULEMAKEFILES): %/makefile: makefiles/terraform.mk
	cp "$<" "$@"

.PHONY: makemodules
makemodules: $(MAKEMODULES)

$(MAKEMODULES): %/default: .terraformrc
	$(MAKE) -C "$*"

$(CLEANMODULES): %/clean:
	$(MAKE) -C "$*" clean

.PHONY: clean
clean: $(CLEANMODULES)
	rm -rf .terraform-plugins .terraformrc tmp

.terraformrc:
	mkdir -p .terraform-plugins
	echo 'plugin_cache_dir = "$(CURDIR)/.terraform-plugins"' > .terraformrc
