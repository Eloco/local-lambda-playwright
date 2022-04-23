# local-lambda-playwright
a local AWS lambda API which is friendly to hacker

if u want a normal version: 
https://github.com/Eloco/local-lambda-playwright

build on
- https://gallery.ecr.aws/w3s2d0z8/local-lambda-playwright
- https://github.com/Eloco/local-lambda-playwright/pkgs/container/local-lambda-playwright

note: it can run on local docker
```
sudo docker pull public.ecr.aws/w3s2d0z8/local-lambda-playwright:main
sudo docker pull ghcr.io/eloco/local-lambda-playwright:latest
sudo docker run --rm=True -p 9000:8080 ghcr.io/eloco/local-lambda-playwright
```

```
bs64=`echo "page.goto('http://example.com'); result=page.content()" | base64 -w 0`
curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{"browser":"chromium","run":"'${bs64}'"}'
```

```
bs64=`echo "stealth_sync(page);page.goto('http://whatsmyuseragent.org/',wait_until='commit'); result=page.content()" | base64 -w 0`
curl -s -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{"browser":"webkit","run":"'${bs64}'"}' | jq .body | html2text -utf8  | sed -r "s/\\\n//g"  | grep -v '^\s*$' | grep -v '^"'

 What's my User Agent?
Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38
(KHTML, like Gecko) Version/15.4 Mobile/15A372 Safari/604.1
My IP Address: 34.254.172.204
Copyright © What's my User Agent 2015
