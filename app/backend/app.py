from flask import Flask, jsonify
import os

app = Flask(__name__)

@app.route('/')
def index():
    return jsonify({
        'service': 'cloudops-360-backend',
        'status': 'ok'
    })

@app.route('/health')
def health():
    return jsonify({'status': 'healthy'})

@app.route('/status')
def status():
    return jsonify({
        'service': 'cloudops-360-backend',
        'api': 'status',
        'status': 'ok'
    })

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port)
