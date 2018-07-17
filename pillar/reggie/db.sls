{%- set private_ip = salt['network.interface_ip']('eth0' if salt['grains.get']('is_vagrant') else 'eth1') -%}

include:
  - reggie


ufw:
  enabled: True

  settings:
    ipv6: False

  sysctl:
    ipv6_autoconf: 0

  applications:
    OpenSSH:
      limit: True
      to_addr: {{ private_ip }}
    Postgresql:
      to_addr: {{ private_ip }}

  services:
    http:
      protocol: tcp
    https:
      protocol: tcp


postgres:
  use_upstream_repo: False
  pkgs_extra:
    - postgresql-contrib
  manage_force_reload_modules: False
