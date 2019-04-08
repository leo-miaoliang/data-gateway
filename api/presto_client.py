from pyhive import presto
from flask import current_app as app

class presto_service:

    def exec_query(self,sql_txt):
        cursor = presto.connect(host=app.config.get('HOST'),port=app.config.get('PORT')).cursor()
        cursor.execute(sql_txt)
        data = cursor.fetchall()
        return data
        
