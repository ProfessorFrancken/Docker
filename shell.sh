#!/usr/bin/env sh

git clone git@github.com:ProfessorFrancken/Docker.git docker-francken && cd docker-francken
git clone git@github.com:ProfessorFrancken/ProfessorFrancken.git Francken

docker-compose build

cd Francken

cp .env.example .env
docker-compose run composer install
docker-compose run php php artisan key:generate
docker-compose run npm npm run dev
docker-compose run php php artisan:migrate -seed
docker-compose up -d nginx
