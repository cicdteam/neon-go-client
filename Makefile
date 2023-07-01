OPENAPI_SPEC_URL ?= https://dfv3qgd2ykmrx.cloudfront.net/api_spec/release/v2.json

GOMODCACHE=$(shell go env GOMODCACHE)
export GOMODCACHE

# Setting SHELL to bash allows bash commands to be executed by recipes.
# Options are set to exit when a recipe line exits non-zero or a piped command fails.
SHELL = /usr/bin/env bash -o pipefail
.SHELLFLAGS = -ec

.PHONY: all
all: generate

# Mitigate error
#   duplicate typename 'GeneralError' detected, can't auto-rename,
#   please use x-go-name to specify your own name for one of them
.PHONY: generate
generate: ## Generate Go client
	curl -sfSL $(OPENAPI_SPEC_URL) | jq '.components.responses.GeneralError += {"x-go-name": "GeneralErrorResp"}' > api.json
	go generate ./...
