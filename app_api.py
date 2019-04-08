from api import create_app,get_env

env = get_env()
app = create_app(env)

if __name__ == '__main__':
    app.run()