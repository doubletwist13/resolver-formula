# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as resolver with context %}

resolver-service-clean-service-dead:
  service.dead:
    - name: {{ resolver.service.name }}
    - enable: False
