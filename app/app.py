#!/usr/bin/env python
# coding=utf-8

from playwright.sync_api import sync_playwright
from playwright_stealth import stealth_sync
from wrapt_timeout_decorator import *
import base64
import os,sys
import httpx,requests

result = """ u need to send param  event[run] or event[run_base64] """

@timeout(60*10) # 10 minutes
def handler(event, context):
    with sync_playwright() as playwright:
        global result
        if "browser" in event:
            if   event["browser"].lower() == "chromium":
                browser = playwright.chromium.launch(headless=False)
            elif event["browser"].lower() == "firefox":
                browser = playwright.firefox.launch(headless=False)
            else:
                browser = playwright.webkit.launch(headless=False)
            context = browser.new_context()
            page    = context.new_page()

        run="global result;"
        if "run" in event.keys():
            run+=event["run"]
        elif "run_base64" in event.keys():
            run+=base64.b64decode(event["run_base64"]).decode('utf-8')
        exec(run)

        return {
            'statusCode': 200,
            'body': result,
        }
