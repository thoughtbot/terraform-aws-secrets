MODULEFILES := $(wildcard *.tf)

.PHONY: default
default: checkfmt validate

.PHONY: checkfmt
checkfmt: .fmt

.PHONY: fmt
fmt: $(MODULEFILES)
	terraform fmt
	@touch .fmt

.PHONY: validate
validate: .validate

.fmt: $(MODULEFILES)
	terraform fmt -check
	@touch .fmt

.PHONY: init
init: .terraform

.terraform: providers.tf.json
	terraform init -backend=false

.validate: .terraform $(MODULEFILES)
	AWS_DEFAULT_REGION=us-east-1 terraform validate
	@touch .validate

.PHONY: clean
clean:
	rm -rf .fmt .terraform .validate
