class Config:
    SECRET_KEY = ''
    SECRET_PWD = ''

    @staticmethod
    def init_app(app):
        pass

class DEVConfig(Config):
    HOST = 'localhost'
    PORT = '8080'

class LOCALConfig(Config):
    HOST = '10.68.100.168'
    PORT = '30018'

class UATConfig(Config):
    HOST = '10.68.100.168'
    PORT = '30018'


class QAConfig(Config):
    HOST = '10.71.21.158'
    PORT = '30018'


class PRDConfig(Config):
    # workaround: use public ip for the time being. 
    HOST = '47.110.36.42'
    PORT = '30018'

config = {
    'local': LOCALConfig,
    'dev': DEVConfig,
    'uat': UATConfig,
    'qa': QAConfig,
    'prd': PRDConfig,
    'production': PRDConfig,

    'default': DEVConfig
}