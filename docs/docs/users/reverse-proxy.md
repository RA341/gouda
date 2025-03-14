---
sidebar_position: 2
---
# Reverse Proxy

To setup Gouda for a reverse proxy, follow for some of the common config for popular reverse proxies

## General requirements

Whatever reverse proxy you use you must ensure it supports HTTP/2 and grpc, since that's what gouda uses for it api.

## Introduction

Find reverse proxy configurations to setup Gouda running on port 9862. These configurations are designed to handle HTTP/2 traffic, which is required for gRPC services.

## Some popular proxies
- [NGINX](#nginx-configuration)
- [Apache](#apache-configuration)
- [HAProxy](#haproxy-configuration)
- [Traefik](#traefik-configuration)
- [Envoy Proxy](#envoy-proxy-configuration)
- [Caddy](#caddy-configuration)

### NGINX Configuration

```nginx
# File: /etc/nginx/conf.d/gouda-service.conf

server {
    listen 443 ssl http2;
    server_name gouda.example.com;

    # SSL configuration
    ssl_certificate /etc/nginx/ssl/cert.pem;
    ssl_certificate_key /etc/nginx/ssl/key.pem;
    
    # HTTP/2 settings
    http2_max_field_size 16k;
    http2_max_header_size 32k;
    http2_max_requests 10000;

    # Timeouts
    keepalive_timeout 300s;
    client_max_body_size 0;  # Allow unlimited body size for streaming
    client_body_timeout 300s;
    
    location / {
        grpc_pass grpc://backend;
        grpc_set_header Host $host;
        grpc_set_header X-Real-IP $remote_addr;
        grpc_read_timeout 300s;
    }
}

upstream backend {
    server gouda:9862;  # Gouda service port
}
```

### Apache Configuration

```apache
# Requires mod_proxy_http2 module
# File: /etc/apache2/sites-available/gouda-service.conf

<VirtualHost *:443>
    ServerName gouda.example.com
    
    # SSL Configuration
    SSLEngine on
    SSLCertificateFile /etc/ssl/certs/cert.pem
    SSLCertificateKeyFile /etc/ssl/private/key.pem
    
    # HTTP/2 settings
    Protocols h2 h2c http/1.1
    H2Direct on
    
    # Proxy settings
    ProxyPreserveHost On
    ProxyTimeout 300
    ProxyRequests Off
    
    # gRPC proxy directive
    ProxyPass / h2://gouda:9862/
    ProxyPassReverse / h2://gouda:9862/
    
    # Logs
    ErrorLog ${APACHE_LOG_DIR}/gouda-error.log
    CustomLog ${APACHE_LOG_DIR}/gouda-access.log combined
</VirtualHost>
```

### HAProxy Configuration

```haproxy
# File: /etc/haproxy/haproxy.cfg

global
    log /dev/log local0
    log /dev/log local1 notice
    user haproxy
    group haproxy
    ssl-default-bind-options ssl-min-ver TLSv1.2

defaults
    log global
    mode http
    option httplog
    timeout connect 10s
    timeout client 300s
    timeout server 300s

frontend grpc_frontend
    bind *:443 ssl crt /etc/ssl/private/combined-cert.pem alpn h2
    mode http
    
    # Only accept HTTP/2 traffic
    acl is_http2 ssl_fc_alpn -i h2
    use_backend grpc_backend if is_http2
    
    # Default backend for non-HTTP/2 traffic 
    default_backend error_backend

backend grpc_backend
    mode http
    
    # Enable HTTP/2
    http-request set-header X-Forwarded-Proto https
    
    # Mark traffic as HTTP/2 for the backend
    server gouda gouda:9862 check proto h2

backend error_backend
    mode http
    errorfile 503 /etc/haproxy/errors/503.http
```

### Traefik Configuration

```yaml
# File: traefik.yml

entryPoints:
  web:
    address: ":80"
    http:
      redirections:
        entryPoint:
          to: websecure
          scheme: https
  
  websecure:
    address: ":443"
    http:
      tls: {}

providers:
  file:
    filename: "/etc/traefik/dynamic_conf.yml"
```

```yaml
# Dynamic configuration file: /etc/traefik/dynamic_conf.yml
tls:
  certificates:
    - certFile: "/etc/traefik/certs/cert.pem"
      keyFile: "/etc/traefik/certs/key.pem"

http:
  routers:
    grpc-router:
      entryPoints:
        - websecure
      rule: "Host(`gouda.example.com`)"
      service: gouda-service
      tls: {}
  
  services:
    gouda-service:
      loadBalancer:
        servers:
          - url: "h2c://gouda:9862"
```

### Envoy Proxy Configuration

```yaml
# File: envoy.yaml

admin:
  address:
    socket_address: { address: 0.0.0.0, port_value: 9901 }

static_resources:
  listeners:
  - name: listener_0
    address:
      socket_address: { address: 0.0.0.0, port_value: 443 }
    filter_chains:
    - filters:
      - name: envoy.filters.network.http_connection_manager
        typed_config:
          "@type": type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.HttpConnectionManager
          stat_prefix: ingress_http
          codec_type: AUTO
          route_config:
            name: local_route
            virtual_hosts:
            - name: local_service
              domains: ["*"]
              routes:
              - match:
                  prefix: "/"
                route:
                  cluster: gouda_service
                  timeout: 300s
                  max_stream_duration:
                    grpc_timeout_header_max: 300s
          http_filters:
          - name: envoy.filters.http.router
            typed_config:
              "@type": type.googleapis.com/envoy.extensions.filters.http.router.v3.Router
      transport_socket:
        name: envoy.transport_sockets.tls
        typed_config:
          "@type": type.googleapis.com/envoy.extensions.transport_sockets.tls.v3.DownstreamTlsContext
          common_tls_context:
            tls_certificates:
              - certificate_chain:
                  filename: "/etc/envoy/certs/cert.pem"
                private_key:
                  filename: "/etc/envoy/certs/key.pem"
  
  clusters:
  - name: gouda_service
    connect_timeout: 0.25s
    type: LOGICAL_DNS
    lb_policy: ROUND_ROBIN
    dns_lookup_family: V4_ONLY
    typed_extension_protocol_options:
      envoy.extensions.upstreams.http.v3.HttpProtocolOptions:
        "@type": type.googleapis.com/envoy.extensions.upstreams.http.v3.HttpProtocolOptions
        explicit_http_config:
          http2_protocol_options: {}
    load_assignment:
      cluster_name: gouda_service
      endpoints:
      - lb_endpoints:
        - endpoint:
            address:
              socket_address:
                address: gouda
                port_value: 9862
```

### Caddy Configuration

```caddy
# File: Caddyfile

gouda.example.com {
    # Forward all traffic to the gRPC backend
    reverse_proxy * {
        transport http {
            versions h2c 2
        }
        to gouda:9862
    }
}
```
