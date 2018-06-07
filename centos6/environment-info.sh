#!/bin/bash
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

set -e

echo -e "System information:"
cat /etc/*-release

echo -e "\nGit version:"
git --version

echo -e "\nJava version:"
java -version

echo -e "\nMaven version:"
mvn --version

echo -e "\nPython version:"
python --version

echo -e "\ncreaterepo version:"
createrepo --version

echo -e "\nrpmbuild version:"
rpmbuild --version

echo -e "\ngenisoimage version:"
genisoimage --version

echo -e "\n--------\n"
