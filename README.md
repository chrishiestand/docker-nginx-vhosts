# vhosts (an nginx docker image)

This is a project to build arbitrary static sites into a docker container and ship it.

Sites should all be put into the `sites/` folder with the domain names that they use.
If the site has a `webroot` subfolder, that folder will be used as the root for the static site. Otherwise the entire site subfolder will be used.

This might be useful if your static website is constructed from build tools.

For example, the source files might be structured like so:
```
sites/mystaticdomain.com/index.html
sites/mystaticdomain.com/js/...
sites/mystaticdomain.com/css/...
sites/anotherdomain.com/webroot/index.html
sites/anotherdomain.com/webroot/js/...
sites/anotherdomain.com/webroot/css/...
```

## TLS
This assumes that one way or another, TLS is required for these sites. If TLS is not terminated by a load balancer or terminator, it should be terminated by nginx.
Different ports are exposed to support different tls setups.


## Deployment
This has been tested working on kubernetes/GKE and GCP. YMMV.
