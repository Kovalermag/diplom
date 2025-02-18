from http.server import BaseHTTPRequestHandler, HTTPServer
from prometheus_client import start_http_server, Counter

# Создаем счетчик HTTP-запросов
http_requests_total = Counter('http_requests_total', 'Total HTTP Requests')

class MetricsHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/metrics':
            http_requests_total.inc()
            self.send_response(200)
            self.send_header('Content-Type', 'text/plain; version=0.0.4; charset=utf-8')
            self.end_headers()
            self.wfile.write(http_requests_total.collect()[0].to_string().encode('utf-8'))
        else:
            self.send_response(404)
            self.end_headers()

if __name__ == '__main__':
    start_http_server(19100)
    server = HTTPServer(('0.0.0.0', 8080), MetricsHandler)
    print("Metrics server running on port 8080...")
    server.serve_forever()