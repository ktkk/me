#!/usr/bin/env python3

import shutil
import webbrowser
import http.server
import socketserver

def run_local_server(port):
    handler = http.server.SimpleHTTPRequestHandler

    socketserver.TCPServer.allow_reuse_address = True

    with socketserver.TCPServer(("", port), handler) as httpd:
        print(f"Serving at port {port}")
        httpd.serve_forever()

def open_browser(address):
    browser = f"{shutil.which('firefox')} %s"
    webbrowser.get(browser).open_new_tab(address)

port = 8000
open_browser(f"localhost:{port}")
run_local_server(port)
