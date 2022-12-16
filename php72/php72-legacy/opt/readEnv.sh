#!/bin/bash
#
# Copyright 2021 LABOR.digital
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Last modified: 2021.04.08 at 11:53
#

if [ -f "/opt/.env.app" ]; then
  echo "Reading env variables from /opt/.env.app"
  set -a
  source <(cat "/opt/.env.app" | \
    sed -e '/^#/d;/^\s*$/d' -e "s/=\s\(.*\)/=\1/g" -e "s/=\s*\"\(.*\)\"$/=\1/g" -e "s/'/'\\\''/g" -e "s/=\(.*\)/='\1'/g")
  set +a
else
  echo "There is no /opt/.env.app, skip reading env variables"
fi
