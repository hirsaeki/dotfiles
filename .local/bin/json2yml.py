#!/usr/bin/env python
import json
import yaml
import sys

json_load = json.load(sys.stdin)
yaml.safe_dump(json_load, sys.stdout, encoding='utf-8', allow_unicode=True, default_flow_style=False)
