#!/usr/bin/env python

# Copyright 2015 Google Inc. All rights reserved.
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

import re

from datetime import datetime
from locust import HttpUser, TaskSet, task, events

# 192.168.0.132 - - [25/Aug/2021:03:31:05 -0700] "GET /api/bioentity/disease/ORPHA:1899 HTTP/1.1" 200 2500 "-" "Mozilla/5.0 (iPhone; CPU iPhone OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)"
logparse_re = re.compile(r'(?P<ip>([0-9]{1,3}\.){3}[0-9]{1,3}) - - \[(?P<timestamp>.*?)\] "(?P<query>.*?)" (?P<code>\d+) (?P<duration>\d+) "(?P<refer>.*?)" "(?P<agent>.*?)"')

@events.init_command_line_parser.add_listener
def _(parser):
    parser.add_argument("--target-logfile", type=str, env_var="LOCUST_TARGET_LOGFILE", default="", help="Logfile out of which to parse tasks")


@events.init.add_listener
def _(environment, **kw):
    print("Logfile supplied: %s" % environment.parsed_options.target_logfile)

def rec_to_op(rec):
    """
    Converts a parsed record into an HTTP request.

    While all verbs are supported in theory, in practice there usually isn't enough data in the logfile to mimic POST requests.
    """

    def query_task(self):
        action, path, _ = rec['query'].split(" ")
        self.client.request(method=action, url=path)
    
    return query_task

class LogLocust(HttpUser):
    def __init__(self, environment):
        super().__init__(environment)

        target_logfile = environment.parsed_options.target_logfile
        print("LogLocust.__init__: Logfile supplied: %s" % target_logfile)

        with open(target_logfile, "r") as fp:
            recs = [ m.groupdict() for m in [logparse_re.match(x) for x in fp.readlines()] if m is not None ]
            print("Read %d lines" % len(recs))

        self.tasks = [ rec_to_op(x) for x in recs ]
