Configdb utility Makefile
=========================
Ease up the creation of a local test environement with `docker`.

**One command to remember** : `make help`

Setup
-----
To build the database container run sequentially the two commands
```
- make setup-db             <= create the docker volume and server db
- make init-db              <= launch a db client to populate it
```

To setup the localdb and demo images
export MAIN_CCS_WORKDIR=/path/to/the/main/ccs/repo
```
- make setup                <= build the subsystem images
```

Usage
-----
Open three terminals in this directory to run *in order* the commands
```
- make start-localdb        <=  for monitoring the configdb
- make start-demo           <=  for monitoring the demo subsystem
- make start-demo-shell     <=  for changing the configuration parameters
```

Shutdown and cleanup
--------------------
```
- make stop                 <= kill the subsystems and stops the db
- make clean                <= delete the localdb and demo images
- make clean-db             <= delete the DB container and the docker volume
```