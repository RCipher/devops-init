#!/bin/bash
set -e

echo "🔹 Переходим в рабочую папку..."
cd ~/devops-init-work

echo "🔹 Обновляем код из голого репозитория..."
git fetch origin
git reset --hard origin/main

echo "🔹 Устанавливаем зависимости (опционально)..."
pip install -r requirements.txt || echo "No dependencies"

echo "🔹 Запускаем тесты..."
pytest -v

echo "🔹 Пересобираем и запускаем контейнеры..."
docker-compose up -d --build

echo "✅ Деплой завершён!"

