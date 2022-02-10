# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_file = tplroot ~ '.config.file' %}
{%- set sls_enable_check = tplroot ~ '.check' %}
{%- from tplroot ~ "/map.jinja" import mapdata as TEMPLATE with context %}

include:
  - {{ sls_enable_check }}
  - {{ sls_config_file }}

TEMPLATE-service-running-service-running:
  service.running:
    - name: {{ TEMPLATE.service.name }}
    - enable: True
    - watch:
      - sls: {{ sls_config_file }}
