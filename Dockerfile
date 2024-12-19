FROM python:3.10-slim
EXPOSE 5000  # Открываем порт 5000 для Flask приложения
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
# Устанавливаем рабочую директорию в контейнере
WORKDIR /app
# Копируем файл с зависимостями в контейнер
COPY requirements.txt /app/requirements.txt
# Копируем исходный код приложения и миграции в контейнер
COPY src /app/src
COPY migrations /app/migrations
COPY config.py /app/config.py
COPY wsgi.py /app/wsgi.py
# Обновляем pip до последней версии
RUN python -m pip install --upgrade pip
# Устанавливаем зависимости из requirements.txt
RUN python -m pip install -r requirements.txt
# Создаем пользователя с явным UID и даем ему права на доступ к папке /app
RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app
# Переходим на созданного пользователя для повышения безопасности
USER appuser
# Запускаем приложение с помощью Gunicorn на порту 5000
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "wsgi:app"]
