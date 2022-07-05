FROM rundeck/rundeck:4.1.0

RUN sudo apt-get -y update \
  && sudo apt-get -y --no-install-recommends install ca-certificates python3-pip python3-setuptools \
    python3-venv sshpass zip unzip jq git\
  && sudo -H pip3 install --upgrade pip==20.3.4 \
  && sudo -H pip3 --no-cache-dir install ansible==2.9.22 \
  && sudo rm -rf /var/lib/apt/lists/* \ 
  && mkdir -p ${PROJECT_BASE}/etc/ \
  && sudo mkdir /etc/ansible \
  && sudo mkdir /workspace && sudo chown rundeck:root /workspace

# Install minio client
RUN sudo wget -O - https://dl.min.io/client/mc/release/linux-amd64/mc > /tmp/mc && sudo mv /tmp/mc /usr/bin/mc && sudo chmod +x /usr/bin/mc

# Install rundeck client
RUN sudo mkdir -p /var/lib/rundeck-cli/ \
    && wget -O - https://github.com/rundeck/rundeck-cli/releases/download/v2.0.1/rd-2.0.1.zip > /tmp/rd.zip \
    && sudo unzip /tmp/rd.zip -d /var/lib/rundeck-cli/ \
    && sudo ln -s /var/lib/rundeck-cli/rd-2.0.1/bin/rd /usr/bin/rd

RUN mkdir -p /home/rundeck/.mc

#install slack plugin
RUN sudo wget -O - https://github.com/rundeck-plugins/slack-incoming-webhook-plugin/releases/download/v1.2.5/slack-incoming-webhook-plugin-1.2.5.jar > /tmp/slack-incoming-webhook-plugin-1.2.5.jar && sudo mv /tmp/slack-incoming-webhook-plugin-1.2.5.jar /home/rundeck/libext/slack-incoming-webhook-plugin-1.2.5.jar
