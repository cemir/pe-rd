FROM rundeck/rundeck:4.1.0

RUN sudo apt-get -y update \
  && sudo apt-get -y --no-install-recommends install ca-certificates python3-pip python3-setuptools \
    python3-venv sshpass zip unzip \
  # https://pypi.org/project/ansible/#history
  && sudo -H pip3 install --upgrade pip==20.3.4 \
  && sudo -H pip3 --no-cache-dir install ansible==2.9.22 \
  && sudo rm -rf /var/lib/apt/lists/* \
  && mkdir -p ${PROJECT_BASE}/etc/ \
  && sudo mkdir /etc/ansible