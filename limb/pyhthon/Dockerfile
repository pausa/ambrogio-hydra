FROM python:3.7
RUN pip install pipenv
ENV AMBROGIO_HOME=/workspace/config

WORKDIR /workspace
RUN mkdir config

COPY app/ .

RUN pipenv install --system --deploy

ENTRYPOINT ["python", "main.py"]