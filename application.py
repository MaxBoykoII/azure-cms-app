"""
This script runs the FlaskWebProject application using the flask cli
"""

from os import environ

from flask.cli import FlaskGroup

from FlaskWebProject import app

cli = FlaskGroup(app)

if __name__ == '__main__':
    cli()
