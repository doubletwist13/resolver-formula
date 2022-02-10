# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata without context %}

{% if not mapdata.enabled %}
TEMPLATE/enabled/false:
  test.configurable_test_state:
    - result: false
    - changes: false
    - comment: The TEMPLATE formula is not enabled for this minion, abort
    - failhard: true
{% endif %}