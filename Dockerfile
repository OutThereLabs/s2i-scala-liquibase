# This image provides an environment for building and running Scala applications and Liquibase.

FROM outtherelabs/s2i-scala

MAINTAINER Julian Tescher <julian@outtherelabs.com>

ENV LIQUIBASE_VERSION=3.5.3 \
    LIQUIBASE_HOME=/opt/liquibase \
    JDBC_DRIVER_HOME=/opt/jdbc_drivers

LABEL io.k8s.description="Platform for building Scala applications with Liquibase" \
      io.k8s.display-name="Scala 2.11, Java 8, Liquibase ${LIQUIBASE_VERSION}" \
      io.openshift.expose-services="9000:http,8778:jolokia" \
      io.openshift.tags="builder,scala,java,liquibase,${LIQUIBASE_VERSION}"

# Install as root
USER root

RUN mkdir $LIQUIBASE_HOME && \
    curl -L https://github.com/liquibase/liquibase/releases/download/liquibase-parent-${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}-bin.tar.gz | \
    tar -xz -C $LIQUIBASE_HOME && \
    chmod +x $LIQUIBASE_HOME/liquibase && \
    ln -s $LIQUIBASE_HOME/liquibase /usr/local/bin/ && \
    mkdir $JDBC_DRIVER_HOME && \
    curl -o $JDBC_DRIVER_HOME/psql-jdbc.jar https://jdbc.postgresql.org/download/postgresql-42.0.0.jar && \
    ln -s $JDBC_DRIVER_HOME/psql-jdbc.jar $LIQUIBASE_HOME/lib/

# Copy the liquibase script
COPY s2i/bin $STI_SCRIPTS_PATH

# Run as the default user from openshift/base-centos7
USER 1001

# Expose default Play and Jolokia ports
EXPOSE 9000 8778

CMD $STI_SCRIPTS_PATH/usage
