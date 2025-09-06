#!/bin/bash

# Папка с рабочей копией на сервере
WORK_DIR=~/devops-init

# Сообщение коммита
MSG="$1"

# Переходим в рабочую папку
cd $WORK_DIR || exit 1

# Добавляем все изменения
git add .

# Создаём коммит, если есть что коммитить
if git diff --cached --quiet; then
    echo "Нет изменений для коммита."
else
    git commit -m "$MSG"
fi

# Сначала подтягиваем изменения с сервера
git pull server main --rebase

# Пушим на сервер
git push server main

# Запуск деплоя на сервере
ssh ubuntu@192.168.0.104 "cd ~/devops-init-work && ./deploy.sh"


