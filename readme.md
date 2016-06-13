# Francken Docker Environment
The `docker-compose.yml` file and associated `Docker` directories can be used to
setup a development environment to run the Francken server.

First clone this repo and the
[francken submodule](https://github.com/ProfessorFrancken/ProfessorFrancken)
by running the following command,
```
git clone --recursive git@bitbucket.org:reconcept-developers/docker.git
```

Next go to the `francken` directory and copy the `.env.example` file,
```
cd docker/Francken
cp .env.example .env
```

## Install php dependencies
Next our application's dependencies need to be installed, run
```
docker-compose run composer install
```
## Start the server
Once the composer dependencies have been installed (this might take a while
depending on your internet speed) you can start the server by running,
```
docker-compose up -d
```
Next run `docker-compose run php php artisan:migrate -seed` to migrate the
database. You should now be able to access the server at `localhost`.

## Testing
The unit and integration tests can be run using,
```
docker-compose run php vendor/bin/phpunit
```

## Testing with coverage
Use the `test_coverage` container which includes xdebug to add collect coverage
information.

```sh
docker-compose run test_coverage vendor/bin/phpunit

# Or run humbug, a mutation testing tool
docker-compose run test_coverage vendor/bin/humbug
```
