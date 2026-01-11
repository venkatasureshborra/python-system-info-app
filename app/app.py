from flask import Flask, jsonify
import socket
import os

app = Flask(__name__)

@app.route("/")
def home():
    hostname = socket.gethostname()
    ip_address = socket.gethostbyname(hostname)

    return f"""
    <html>
        <body style="font-family: Arial;">
            <h1> Python Application - Deployement by Venkata Suresh </h1>
            <p><b>Hostname:</b> {hostname}</p>
            <p><b>Server IP:</b> {ip_address}</p>
            <p><b>Status:</b> Application running</p>
        </body>
    </html>
    """

# Liveness probe endpoint
@app.route("/health/live")
def liveness():
    return jsonify(status="alive"), 200

# Readiness probe endpoint
@app.route("/health/ready")
def readiness():
    return jsonify(status="ready"), 200

if __name__ == "__main__":
    port = int(os.getenv("APP_PORT", 8080))
    app.run(host="0.0.0.0", port=port)
