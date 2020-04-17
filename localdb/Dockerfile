FROM openjdk:8
COPY main/target/distribution /home/lsst
COPY statusPersister-docker.properties /home/lsst/etc/statusPersister.properties
CMD ./home/lsst/bin/CCSbootstrap.sh -app localdb
