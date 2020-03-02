#environment := integration-testing
#export appenv := $(shell echo "$(environment)" | tr '[:upper:]' '[:lower:]')
#export TF_VAR_appenv := $(appenv)
#undefine TF_VAR_master_account_id
#undefine TF_VAR_master_role_name
#export backend_key := grace_integration_testing_inventory_lambda.tfstate
#
#.PHONY: check apply plan validate init destroy
#check:
#ifeq ($(strip $(backend_bucket)),)
#	@echo "backend_bucket must be provided"
#	@exit 1
#endif
#ifeq ($(strip $(TF_VAR_appenv)),)
#	@echo "TF_VAR_appenv must be provided"
#	@exit 1
#else
#	@echo "appenv: $(TF_VAR_appenv)"
#endif
#ifeq ($(strip $(backend_key)),)
#	@echo "backend_key must be provided"
#	@exit 1
#endif

#destroy: init
#	terraform destroy -auto-approve
#
#apply: plan
#	terraform apply -auto-approve
#
#plan: validate
#	terraform plan
#
#validate: init
#	terraform validate
#	terrascan --location . --tests all


default: integration-test

integration-test: lint
	go test -v integration_test.go

lint: dependencies
	golangci-lint run ./...

dependencies: golangci go.sum init

golangci:
	go get -u github.com/golangci/golangci-lint/cmd/golangci-lint

go.sum: go.mod
	go mod tidy

go.mod:
	go mod init

init:
	[[ -d ../release ]] || mkdir ../release
	[[ -e ../release/grace-inventory-lambda.zip ]] || touch ../release/grace-inventory-lambda.zip
