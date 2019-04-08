import os
from flask import Flask
from config import config
from api.main import main as main_blueprint

def create_app(config_name='default'):
    app = Flask(__name__)
    conf = config[config_name]
    app.config.from_object(conf)
    conf.init_app(app)
    app.register_blueprint(main_blueprint)
    return app

def get_env():
    __default_environment__ = 'default'
    env = os.environ.get('PYTHON_ENV')
    if not env:
        return __default_environment__
    env = env.lower()
    if env in config:
        return env
    return __default_environment__