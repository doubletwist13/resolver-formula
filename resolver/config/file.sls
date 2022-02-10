# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- set sls_enable_check = tplroot ~ '.check' %}
{%- from tplroot ~ "/map.jinja" import mapdata as resolver with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_enable_check }}
  - {{ sls_package_install }}

resolver-config-file-file-managed:
  file.managed:
    - name: {{ resolver.config }}
    - source: {{ files_switch(['example.tmpl'],
                              lookup='resolver-config-file-file-managed'
                 )
              }}
    - mode: "0644"
    - user: root
    - group: {{ resolver.rootgroup }}
    - makedirs: True
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        resolver: {{ resolver | json }}
