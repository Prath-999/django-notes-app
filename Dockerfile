# FROM python:3.9

# WORKDIR /app/backend

# COPY requirements.txt /app/backend
# RUN apt-get update \
#     && apt-get upgrade -y \
#     && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
#     && rm -rf /var/lib/apt/lists/*


# # Install app dependencies
# RUN pip install mysqlclient
# RUN pip install --no-cache-dir -r requirements.txt

# COPY . /app/backend

# EXPOSE 8000
# #CMD ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]
# CMD ["sh", "-c", "sleep 10 && python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]
#RUN python manage.py migrate
#RUN python manage.py makemigrations

FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .

# Install system dependencies for mysqlclient
RUN apt-get update && \
    apt-get install -y gcc default-libmysqlclient-dev pkg-config && \
    pip install --no-cache-dir mysqlclient && \
    pip install --no-cache-dir -r requirements.txt && \
    rm -rf /var/lib/apt/lists/*

COPY . .

EXPOSE 8000

CMD ["sh", "-c", "sleep 10 && python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]
