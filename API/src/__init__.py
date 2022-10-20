from flask import Flask
from api import scan

def create_app():
    app = Flask(__name__, instance_relative_config=True)

    app.register_blueprint(scan)

    return app  
