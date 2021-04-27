# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

# Project variables
PROJECT_NAME  := cloudstack-rpm-builder
PROJECT_OWNER := khos2ow
DESCRIPTION   := Docker images for building Apache CloudStack RPM packages
PROJECT_URL   := https://github.com/$(PROJECT_OWNER)/$(PROJECT_NAME)
LICENSE       := Apache-2.0

# Build docker tag based on provided info
#
# $1: tag_name
# $2: directory_name
# $3: dockerfile_name
define build_tag
	docker build --pull --tag $(PROJECT_OWNER)/$(PROJECT_NAME):$(1) --file $(2)/$(3) $(2)
endef

.PHONY: all
all: centos6 centos7 centos7-jdk8 centos7-jdk11 centos8 latest

.PHONY: centos6
centos6: ## Build centos6 image
	@ $(MAKE) --no-print-directory log-$@
	$(call build_tag,centos6,centos6,Dockerfile)

.PHONY: centos7
centos7: ## Build centos7 image
	@ $(MAKE) --no-print-directory log-$@
	$(call build_tag,centos7,centos7,Dockerfile.jdk8)

.PHONY: centos7-jdk8
centos7-jdk8: ## Build centos7-jdk8 image
	@ $(MAKE) --no-print-directory log-$@
	$(call build_tag,centos7-jdk8,centos7,Dockerfile.jdk8)

.PHONY: centos7-jdk11
centos7-jdk11: ## Build centos7-jdk11 image
	@ $(MAKE) --no-print-directory log-$@
	$(call build_tag,centos7-jdk11,centos7,Dockerfile.jdk11)

.PHONY: centos8
centos8: ## Build centos8 image
	@ $(MAKE) --no-print-directory log-$@
	$(call build_tag,centos8,centos8,Dockerfile)

.PHONY: latest
latest: ## Build latest image
	@ $(MAKE) --no-print-directory log-$@
	$(call build_tag,latest,centos8,Dockerfile)

.PHONY: push
push: DOCKER_TAG ?=
push: ## Push image
	@ $(MAKE) --no-print-directory log-$@
	docker push $(PROJECT_OWNER)/$(PROJECT_NAME):$(DOCKER_TAG)

########################################################################
## Self-Documenting Makefile Help                                     ##
## https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html ##
########################################################################
.PHONY: help
help:
	@ grep -h -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

log-%:
	@ grep -h -E '^$*:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m==> %s\033[0m\n", $$2}'
