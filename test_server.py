import http.server
import socketserver

PORT = 8082
Handler = http.server.SimpleHTTPRequestHandler

try:
    with socketserver.TCPServer(("", PORT), Handler) as httpd:
        print(f"serving at port {PORT}")
        httpd.serve_forever()
except Exception as e:
    print(f"Error starting server: {e}")
