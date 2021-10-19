"""
The flask application package.
"""

from flask_session import Session
from logging import StreamHandler

from FlaskWebProject.login import login
from FlaskWebProject.models import db
from FlaskWebProject.views import app

Session(app)

db.init_app(app)
login.init_app(app)

streamHandler = StreamHandler()
app.logger.addHandler(streamHandler)


