# Francken Docker Environment

The `docker-compose.yml` file and associated `Docker` directories can be used to
setup a development environment to run the Francken server.

First clone this repo and the
[francken submodule](https://github.com/ProfessorFrancken/ProfessorFrancken)
by running the following command,
```
git clone --recursive git@bitbucket.org:reconcept-developers/docker.git
```

Next go to the `francken` directory and copy and rename the `.env.example` file,
```
cd docker/Francken
cp .env.example .env
```

*Note*: if you use windows first read,
[Windows installation instructions](#windows-installation-instructions).

## Install php dependencies
Next our application's dependencies need to be installed, run
```
docker-compose run composer install
```
Next run (this will generate a private key that is used for encryption)
```
docker-compose run php php artisan key:generate
```

## Start the server
Once the composer dependencies have been installed (this might take a while
depending on your internet speed) you can start the server by running,
```
docker-compose up -d
```
Next run `docker-compose run php php artisan:migrate -seed` to migrate the
database. You should now be able to access the server at `localhost`.

### Stopping the server
To stop the server run `docker-compose down`.

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

# Windows installation instructions
*Currently only windows 10 is supported*. If you use an old version of windows
you should use virtualbox + vagrant.

First install [docker for windows](https://docs.docker.com/docker-for-windows/),
next after restarting your computer a bazilliion times go to the docker settings
and select shared drives. Make sure that the drive on which you've cloned
`ProfessorFrancken/Docker` is selected, if not select it and apply the changes.

You can now start [install php dependencies](#install-php-dependencies) using
composer. However you will probably notice that whenever you run `docker-compose
run ...` you get an error message,

> Interactive mode is not yet supported on Windows.
> Please pass the -d flag when using `docker-compose run`.

To resolve this you will have to add the `-d` flag after `run`, i.e.
`docker-compose run -d composer install`.
Not being able to use `interactive mdoe` means that you won't get any feedback
on whether the command has run succesfully.
You can use `docker ps -a` to see whether a command is finished. For instance if
you run `docker-compose run -d composer install` you will see,
```
λ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
0d45f55729aa        docker_composer     "composer --ansi inst"   42 seconds ago      Up 41 seconds                           docker_composer_run_1
```

After waiting a while  its status will be `Exited` after which you can continue
to the next step.
```
λ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                     PORTS               NAMES
0d45f55729aa        docker_composer     "composer --ansi inst"   6 minutes ago       Exited (0) 2 minutes ago                       docker_composer_run_1
```
