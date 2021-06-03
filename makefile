.SECONDEXPANSION:

.PHONY: default
default: fmt validate

export TF_CLI_CONFIG_FILE := $(CURDIR)/.terraformrc

MODULES         := $(wildcard aws/* common/*)
MODULEMAKEFILES := $(foreach module,$(MODULES),$(module)/makefile)
VALIDATEMODULES := $(foreach module,$(MODULES),$(module)/validate)
CLEANMODULES    := $(foreach module,$(MODULES),$(module)/clean)

.PHONY: fmt
fmt:
	terraform fmt -recursive

.PHONY: validate
validate: $(VALIDATEMODULES)

$(VALIDATEMODULES): %/validate: .terraformrc
	$(MAKE) -C "$*" .validate

$(CLEANMODULES): %/clean:
	$(MAKE) -C "$*" clean

.PHONY: makefiles
makefiles: $(MODULEMAKEFILES)

$(MODULEMAKEFILES): %/makefile: makefiles/terraform.mk
	cp "$<" "$@"

.PHONY: clean
clean: kind-down $(CLEANMODULES)
	$(MAKE) -C local/operations-platform clean
	rm -rf tmp

.terraformrc:
	mkdir -p .terraform-plugins
	echo 'plugin_cache_dir = "$(CURDIR)/.terraform-plugins"' > .terraformrc
