# super-lambda-playwright
a AWS lambda API which is friendly to hacker

docker base on https://github.com/Eloco/lambda-playwright-python

build on
- https://gallery.ecr.aws/w3s2d0z8/super-lambda-playwright
- https://github.com/Eloco/super-lambda-playwright/pkgs/container/super-lambda-playwright

```
sudo docker pull ghcr.io/eloco/super-lambda-playwright:latest
sudo docker run --rm=True -p 9000:8080 ghcr.io/eloco/super-lambda-playwright
```

```
bs64=`echo "page.goto('http://example.com'); result=page.content()" | base64 -w 0`
curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{"browser":"chromium","run_base64":"'${bs64}'"}'
```

```
bs64=`echo "stealth_sync(page);page.goto('http://whatsmyuseragent.org/',wait_until='commit'); result=page.content()" | base64 -w 0`
curl -s -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{"browser":"webkit","run_base64":"'${bs64}'"}' | jq .body | html2text | sed  's/[\\n" ]//g' | grep -v '^$'

__[__What'smyUserAget?](#page-top)
*[](#page-top)
Mozilla/5.0(Macitosh;ItelMacOSX10_15_7)AppleWebKit/605.1.15(KHTML,
likeGecko)Versio/15.4Safari/605.1.15
MyIPAddress:xx.xx.xx.xx
Copyright©What'smyUserAget2015
```
