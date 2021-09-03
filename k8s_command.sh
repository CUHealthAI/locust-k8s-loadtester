#!/usr/bin/env bash

echo kubernetes-config/*.yaml | xargs -n 1 kubectl ${1:-apply} -f
