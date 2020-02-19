# Dockerfile
# MOC Billing

FROM centos:7.7.1908
LABEL Description="MOC Billing" Version="0.1"

################################################################################
# Base Install
RUN yum update -y \
 && yum group install -y "Development Tools" \
 && yum install -y libcurl-devel postgresql-server postgresql-devel perl perl-CPAN perl-App-cpanminus \
 && yum clean all
RUN cpanm YAML::XS Parse::CSV JSON Data::Dumper Time::Local Date::Parse POSIX WWW::Curl::Easy WWW::Curl::Multi DBI DBD::Pg

################################################################################
# Variables
ENV LOGDIR "/var/log"
ENV PGDIR "/usr/local/pgsql"
ENV PGDATA "${PGDIR}/data"
ENV PGLOG "${LOGDIR}/postgres-server"
ENV PGUSER "postgres"
ENV PGGROUP "postgres"

ENV WORKUSER reporting
ENV WORKGROUP reporting
ENV WORKGROUP_ID 6555

ENV SRC "./code"
ENV WORKDIR "/reporting"
ENV MAIN "main.sh"

################################################################################
# Add User and Groups
# NOTE: user 'postgres' comes for free w/ install (above)
RUN groupadd --gid ${WORKGROUP_ID} ${WORKGROUP}
RUN useradd -m -d /reporting -u 999 -g ${WORKGROUP_ID} reporting

################################################################################
# Add mounting points
RUN touch ${PGLOG} && chgrp ${PGGROUP} ${PGLOG} && chmod g+w ${PGLOG}
RUN mkdir -p ${PGDATA} && chown -R ${PGUSER}:${PGGROUP} ${PGDATA}

################################################################################
# Copy code into image
RUN mkdir -p ${WORKDIR}
ADD ${SRC} ${WORKDIR}
RUN chown -R ${WORKUSER}:${WORKGROUP} ${WORKDIR}
RUN chmod a+x ${WORKDIR}/${MAIN}

################################################################################
# Configure run profile
VOLUME ["${LOGDIR}", "${PGDATA}"]
WORKDIR ${WORKDIR}
ENTRYPOINT [${WORKDIR}/${MAIN}]

################################################################################
# Config Loaded via Secrets
