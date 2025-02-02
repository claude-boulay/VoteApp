FROM python:3.11-alpine
WORKDIR /code/vote
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY . ./
CMD ["python","app.py"]