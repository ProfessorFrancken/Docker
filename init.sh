#!/usr/bin/env sh

# TODO check if installation requirements are available

# TODO send all output to dev null and add useful messages instead

git clone git@github.com:ProfessorFrancken/Docker.git docker-francken && cd docker-francken
git clone git@github.com:ProfessorFrancken/ProfessorFrancken.git Francken

docker-compose build

cd Francken

cp .env.example .env
docker-compose run composer install
docker-compose run npm npm install
docker-compose run npm npm run dev
docker-compose run php php artisan key:generate
docker-compose up nginx

# Can't do migrate yet since mysql hasn't started yet
# docker-compose run php php artisan migrate -seed
