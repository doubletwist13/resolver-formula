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
    - source: {{ files_switch(['/etc/resolv.conf.jinja'],
                              lookup='resolver-config-file-file-managed'
                 )
              }}
    - mode: "0644"
    - user: root
    - group: root
    - makedirs: True
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        resolver: {{ resolver | json }}


{# if we are using the resolvconf package we run an update command on changes #}
{% if resolver.pkg.state == 'installed' %}
resolv-update-command:
  cmd.run:
    - name: resolvconf -u
    - onchanges:
      - file: resolver-config-file-file-managed
{% endif %}
