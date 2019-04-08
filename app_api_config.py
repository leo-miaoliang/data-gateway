# import multiprocessing

bind = '0.0.0.0:5000'
backlog = 2048
# workers = multiprocessing.cpu_count() * 2 + 1
workers = 4
worker_class = 'gevent'
worker_connections = 1000
accesslog = '/var/log/gunicorn/access.log'
access_log_format = '%(h)s %(l)s %(u)s %(t)s %({Host}i)s %(m)s "%(U)s" "%(q)s" %(s)s %(b)s ' \
                    '"%(f)s" %(T)s %(l)s "%(a)s" "%({X-Forwarded-For}i)s"'
errorlog = '/var/log/gunicorn/error.log'
loglevel = 'warning'
pidfile = '/var/run/gunicorn.pid'
