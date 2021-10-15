"""
The flask application package.
"""

from flask_session import Session
from FlaskWebProject.login import login
from FlaskWebProject.models import db
from FlaskWebProject.views import app

# TODO: Add any logging levels and handlers with app.logger
Session(app)
db.init_app(app)
login.init_app(app)
