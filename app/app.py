#!/usr/bin/env python
# coding=utf-8

from playwright.sync_api import sync_playwright
from playwright_stealth import stealth_sync
from wrapt_timeout_decorator import *
import base64
import os,sys
import datetime,time,random
import httpx,requests

result = """ u need to send param  event[run] with base64 encode """

@timeout(60*10) # 10 minutes
def handler(event, context):
    with sync_playwright() as playwright:
        global result
        if "browser" in event:
            if   event["browser"].lower() == "chromium":
                browser = playwright.chromium.launch(headless=True)
            elif event["browser"].lower() == "firefox":
                browser = playwright.firefox.launch(headless=True)
            else:
                browser = playwright.webkit.launch(headless=True)
            context = browser.new_context()
            page    = context.new_page()

        run="global result;"
        if "run" in event.keys():
            try:
                run+=base64.b64decode(event["run"]).decode('utf-8')
            except:
                run+=event["run"]

        exec(run)

        return {
            'statusCode': 200,
            'body': result,
        }
