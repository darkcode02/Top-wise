"""
Utilidades y helpers para la aplicación
"""
from datetime import datetime
from functools import wraps
from flask import jsonify, request

def success_response(data, status_code=200, message=None):
    """
    Respuesta de éxito estándar
    """
    response = {
        'success': True,
        'data': data,
        'timestamp': datetime.utcnow().isoformat()
    }
    if message:
        response['message'] = message
    return jsonify(response), status_code

def error_response(error, status_code=400, message=None):
    """
    Respuesta de error estándar
    """
    response = {
        'success': False,
        'error': str(error),
        'timestamp': datetime.utcnow().isoformat()
    }
    if message:
        response['message'] = message
    return jsonify(response), status_code

def validate_request_json(required_fields=None):
    """
    Decorador para validar JSON en requests
    """
    def decorator(f):
        @wraps(f)
        def decorated_function(*args, **kwargs):
            if not request.is_json:
                return error_response(
                    'Content-Type must be application/json',
                    status_code=400
                )
            
            data = request.get_json()
            
            if required_fields:
                missing = [field for field in required_fields if field not in data]
                if missing:
                    return error_response(
                        f'Missing required fields: {", ".join(missing)}',
                        status_code=400
                    )
            
            return f(*args, **kwargs)
        return decorated_function
    return decorator
