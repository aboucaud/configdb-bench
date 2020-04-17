Configdb test bench
===================
Ease up the creation of a local test environement with `docker`.

- one command to remember : `make help`
- one environment variable to set : `MAIN_CCS_WORKDIR`

Current branches needed
-----------------------

As of today April 17,

- `MAIN_CCS_WORKDIR/org-lsst-ccs-localdb` should be on `master`
- `MAIN_CCS_WORKDIR/org-lsst-ccs-subsystem-demo` should be on `LSSTCCS-2090`


Setup
-----
To build the database container run sequentially the two commands
```
- make setup-db             <= create the docker volume and server db
- make init-db              <= launch a db client to populate it
```

To setup the localdb and demo images, first  
```
export MAIN_CCS_WORKDIR=/path/to/the/main/ccs/repo   <= in the terminal or in the bash profile
```
then
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