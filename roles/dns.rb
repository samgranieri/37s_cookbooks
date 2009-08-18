# Ezample dns server role using search indexes to generate DNS entries
name "dns"
description "DNS server"
recipes "djbdns::cache", "djbdns::internal_server", "djbdns::autozone"