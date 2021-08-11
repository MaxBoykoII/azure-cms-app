"""
This script runs the FlaskWebProject application using the flask cli
"""

from os import environ
from FlaskWebProject import app
from flask.cli import FlaskGroup

cli = FlaskGroup(app)

if __name__ == '__main__':
    cli()
