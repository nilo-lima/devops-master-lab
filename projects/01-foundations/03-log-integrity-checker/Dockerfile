FROM python:3.13-slim

RUN groupadd -r checker && useradd -r -g checker -d /app checker

WORKDIR /app

COPY app/integrity_checker.py .

USER checker

ENTRYPOINT ["python", "integrity_checker.py"]
