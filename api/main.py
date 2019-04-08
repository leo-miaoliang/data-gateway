from flask import Blueprint, jsonify, request
from api.presto_client import presto_service

main = Blueprint('main', __name__)

@main.route('/', methods=['POST'])
def get_data():
    data = request.get_json(True, True, True)
    if (not data) or (not data.get('sql_txt')):
        return jsonify({
            "is_success": False,
            "error": "request data is empty"
        })
    try:
        pre_client = presto_service()
        sql_txt = data.get('sql_txt')
        dt_list = pre_client.exec_query(sql_txt)
        return jsonify({
            "is_success": True,
            "data": dt_list
        })
    except Exception as e:
        return jsonify({
            "is_success": False,
            "error": "execute query failed",
            "exception": str(e)
        })