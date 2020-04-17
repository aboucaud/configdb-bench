MAIN_CCS_WORKDIR = /Users/alexandre/work/lsst/ccs/dev

# Commands
START := docker start
STOP := docker stop
KILL := docker kill
BUILD := docker build
RUN := docker run
RM_CTN := docker container rm
RM_IMG := docker image rm
RM_VOL := docker volume rm

# Docker flags
TMP := --rm
INTERACTIVE := -i
WITH_TERM := -t
DETACHED := -d

# Advanced commands
RUN_TMP := $(RUN) $(INTERACTIVE) $(TMP)
RUN_TMP_WITH_TERM := $(RUN_TMP) $(WITH_TERM) 

# Names
db = mariadbccs
dbvolume = ccsdb
dbsub = localdb
demosub = demosub

dbimg_server = mariadb/server:10.4
dbimg_client = mariadb
dbsubimg = ccs/$(dbsub):latest
dbsubdir = $(MAIN_CCS_WORKDIR)/org-lsst-ccs-localdb
demosubimg = ccs/$(demosub):latest
demosubdir = $(MAIN_CCS_WORKDIR)/org-lsst-ccs-subsystem-demo

.PHONY: help setup setup-db init-db setup-localdb setup-demo start-db start-localdb start-demo start-demo-shell stop stop-db kill-localdb kill-demo clean clean-db clean-localdb clean-demo

help:
	@echo "Configdb utility Makefile"
	@echo "========================="
	@echo "Ease up the creation of a local test environement with docker"
	@echo
	@echo "Setup"
	@echo "-----"
	@echo "To build the database container run sequentially the two commands"
	@echo "- make setup-db             <= create the docker volume and server db"
	@echo "- make init-db              <= launch a db client to populate it"
	@echo
	@echo "To setup the localdb and demo images"
	@echo "- export MAIN_CCS_WORKDIR=/path/to/the/main/ccs/repo"
	@echo "- make setup                <= build the subsystem images"
	@echo 
	@echo "Usage"
	@echo "-----"
	@echo "Open three terminals in this directory to run *in order* the commands"
	@echo "- make start-localdb        <=  for monitoring the configdb"
	@echo "- make start-demo           <=  for monitoring the demo subsystem"
	@echo "- make start-demo-shell     <=  for changing the configuration parameters"
	@echo
	@echo "Shutdown and cleanup"
	@echo "--------------------"
	@echo "- make stop                 <= kill the subsystems and stops the db"
	@echo "- make clean                <= delete the localdb and demo images"
	@echo "- make clean-db             <= delete the DB container and the docker volume"

check-env:
ifndef MAIN_CCS_WORKDIR
    $(error MAIN_CCS_WORKDIR is undefined)
endif

setup: setup-localdb setup-demo

setup-db:
	docker volume create $(dbvolume)
	$(RUN) --name $(db) $(DETACHED) -v $(dbvolume):/var/lib/mysql -e MYSQL_ROOT_PASSWORD=lsstfcs $(dbimg_server)

init-db: start-db
	$(RUN_TMP) --link $(db):$(db) $(dbimg_client) mysql -h$(db) -uroot -plsstfcs < mariadb/ccsdb-init.sql 
	$(RUN_TMP) --link $(db):$(db) $(dbimg_client) mysql -h$(db) -uccs -pccs23 ccs < mariadb/ccsdb-structure.sql

setup-localdb: check-env
	cp localdb/statusPersister-docker.properties $(dbsubdir)
	$(BUILD) -f localdb/Dockerfile -t $(dbsubimg) $(dbsubdir)

setup-demo: check-env
	$(BUILD) -f demosubsystem/Dockerfile -t $(demosubimg) $(demosubdir)
	
start-db:
	$(START) $(db)

start-localdb: start-db
	$(RUN_TMP) --name $(dbsub) --link $(db):$(db) $(dbsubimg)

start-demo:
	$(RUN_TMP) --name $(demosub) --link $(dbsub):$(dbsub) $(demosubimg)

start-demo-shell:
	$(RUN_TMP_WITH_TERM) --name $(demosub)-with-shell $(demosubimg) ./home/lsst/bin/CCSbootstrap.sh -app ccs-shell

stop: kill-demo kill-localdb stop-db

stop-db: 
	-$(STOP) $(db)

kill-localdb: 
	-$(KILL) $(dbsub)

kill-demo: 
	-$(KILL) $(demosub)

clean: clean-localdb clean-demo

clean-db: stop-db
	-$(RM_CTN) $(db)
	-$(RM_VOL) $(dbvolume)

clean-demo: kill-demo
	$(RM_IMG) $(demosubimg)

clean-localdb: kill-localdb
	$(RM_IMG) $(dbsubimg)

