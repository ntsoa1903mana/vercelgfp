FROM python:3.10.12-slim-bullseye

WORKDIR /app

COPY requirements.txt requirements.txt

RUN python3 -m venv venv
ENV PATH="/app/venv/bin:$PATH"

RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential libffi-dev cmake libcurl4-openssl-dev nodejs screen && \
    python -m pip install --no-cache-dir -U pip==23.2.1

RUN pip install --no-cache-dir -r requirements.txt

COPY . .
RUN chmod +x ./app.py

RUN chmod -R 777 /app

EXPOSE 7000

CMD screen -d -m python3 check.py && uvicorn app:app --host 0.0.0.0 --port 7000
