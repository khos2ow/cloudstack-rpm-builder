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

DOCKER_IMAGE := khos2ow/cloudstack-rpm-builder
DOCKER_TAG   := 

.PHONY: all
all: centos6 centos7 latest

.PHONY: centos6
centos6: DOCKER_TAG := centos6
centos6:
	docker build --pull --tag $(DOCKER_IMAGE):$(DOCKER_TAG) --file centos6/Dockerfile centos6/

.PHONY: centos7
centos7: DOCKER_TAG := centos7
centos7:
	docker build --pull --tag $(DOCKER_IMAGE):$(DOCKER_TAG) --file centos7/Dockerfile centos7/

.PHONY: latest
latest: DOCKER_TAG := latest
latest:
	docker build --pull --tag $(DOCKER_IMAGE):$(DOCKER_TAG) --file centos7/Dockerfile centos7/

.PHONY: push
push:
	docker push $(DOCKER_IMAGE):$(DOCKER_TAG)
