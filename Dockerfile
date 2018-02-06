FROM alpine:3.7

COPY bin/site-build /build/site-build
COPY sites /build/sites

RUN apk add --update bash && \
    mkdir /dest_root && \
    /build/site-build /build/sites /dest_root webroot


FROM chrishiestand/nginx-static-base:1.13

USER root

RUN apk add --update nginx-mod-http-lua git && \
    rm /etc/nginx/conf.d/default.conf && \
    cd /var/opt && \
    chmod a+rx /var/lib/nginx && \
    git clone https://github.com/knyar/nginx-lua-prometheus.git && \
    apk del --purge git && \
    rm -rf /var/cache/apk/*

# Copy snakeoil certs so nginx will start, mount-over proper cert/key in production
COPY etc/dhparam-snakeoil.pem /etc/nginx/ssl/dhparam.pem
COPY etc/snakeoil.crt /opt/tls/san/tls.crt
COPY etc/snakeoil.key /opt/tls/san/tls.key

COPY etc/nginx-vhosts.conf /etc/nginx/nginx-http/vhosts.conf
COPY etc/nginx-main-lua.conf /etc/nginx/nginx-main/lua.conf

COPY --from=0 /dest_root /www

USER guest
