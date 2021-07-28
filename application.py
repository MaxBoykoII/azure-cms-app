"""
This script runs the FlaskWebProject application using a development server.
"""

from os import environ
from FlaskWebProject import app

if __name__ == '__main__':
    HOST = environ.get('SERVER_HOST', '0.0.0.0')
    try:
        PORT = int(environ.get('WEBSITES_PORT', '5000'))
    except ValueError:
        PORT = 5000
    # app.run(HOST, PORT, ssl_context='adhoc')
    app.run(HOST, PORT)
