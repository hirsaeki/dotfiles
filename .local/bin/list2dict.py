#!/usr/bin/env python

import yaml
import sys

list_ = yaml.safe_load(sys.stdin)
dict_ = {}
for i in list_:
    dict_.update({i['section']: {i['key']: None}})
for i in list_:
    dict_[i['section']].update({i['key']: i['value']})
yaml.safe_dump(dict_, sys.stdout, allow_unicode=True,
               default_flow_style=False, encoding='utf-8')
