TFLINTRC    := ../.tflint.hcl
TFDOCSRC    ?= ../.terraform-docs.yml
MODULEFILES := $(wildcard *.tf)

.PHONY: default
default: checkfmt validate docs lint

.PHONY: checkfmt
checkfmt: .fmt

.PHONY: fmt
fmt: $(MODULEFILES)
	terraform fmt
	@touch .fmt

.PHONY: validate
validate: .validate

.PHONY: docs
docs: README.md

.PHONY: lint
lint: .lint

.lint: $(MODULEFILES) .lintinit
	tflint --config=$(TFLINTRC)
	@touch .lint

.lintinit: $(TFLINTRC)
	tflint --init --config=$(TFLINTRC)
	@touch .lintinit

README.md: $(MODULEFILES)
	terraform-docs --config "$(TFDOCSRC)" markdown table . --output-file README.md

.fmt: $(MODULEFILES)
	terraform fmt -check
	@touch .fmt

.PHONY: init
init: .init

.init: versions.tf
	terraform init -backend=false
	@touch .init

.validate: .init $(MODULEFILES) $(wildcard *.tf.example)
	echo | cat - $(wildcard *.tf.example) > test.tf
	if AWS_DEFAULT_REGION=us-east-1 terraform validate; then \
		rm test.tf; \
		touch .validate; \
	else \
		rm test.tf; \
		false; \
	fi

.PHONY: clean
clean:
	rm -rf .fmt .init .lint .lintinit .terraform .terraform.lock.hcl .validate
