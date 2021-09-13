#!/usr/bin/env python
import json
import yaml
import sys

yaml_load = yaml.safe_load(sys.stdin)
json.dump(yaml_load, sys.stdout)
