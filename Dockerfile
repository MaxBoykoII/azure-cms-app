FROM python:3.7.11-slim-buster

WORKDIR /usr/src/app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apt-get update && apt-get install -y --no-install-recommends \
    unixodbc-dev \
    python3-dev \
    build-essential \
    libssl-dev \
    libffi-dev

COPY ./requirements.txt .
RUN pip install -r requirements.txt

COPY . .

CMD python application.py