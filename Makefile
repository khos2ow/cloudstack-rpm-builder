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

.PHONY: all centos6 centos7 latest

all: centos6 centos7 latest

centos6:
	docker build -t khos2ow/cloudstack-rpm-builder:centos6 centos6/

centos7:
	docker build -t khos2ow/cloudstack-rpm-builder:centos7 centos7/

latest:
	docker build -t khos2ow/cloudstack-rpm-builder:latest centos7/