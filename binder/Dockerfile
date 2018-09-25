FROM jmodelica/ubuntu_base:18.04

# create user with a home directory
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

USER root
RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}

USER ${NB_USER}
WORKDIR ${HOME}