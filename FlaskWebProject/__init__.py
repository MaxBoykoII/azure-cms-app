"""
The flask application package.
"""

import logging
from logging import StreamHandler

from flask_session import Session

from FlaskWebProject.login import login
from FlaskWebProject.models import db
from FlaskWebProject.views import app

Session(app)

db.init_app(app)
login.init_app(app)

streamHandler = StreamHandler()
streamHandler.setLevel(logging.INFO)
app.logger.addHandler(streamHandler)
app.logger.setLevel(logging.INFO)
