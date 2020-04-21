FROM openjdk:8
COPY main/target/distribution /home/lsst
CMD ./home/lsst/bin/CCSbootstrap.sh -app demo-subsystem-with-monitoring -D org.lsst.ccs.config.dual=True