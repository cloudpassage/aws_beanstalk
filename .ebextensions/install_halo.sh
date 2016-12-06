#!/bin/bash

install_deb() {
    server_label=$1

    # add CloudPassage repository
    echo 'deb https://production.packages.cloudpassage.com/debian debian main' | sudo tee /etc/apt/sources.list.d/cloudpassage.list > /dev/null

    # update apt repositories
    sudo apt-get update > /dev/null

    # install curl
    sudo apt-get -y install curl

    # import CloudPassage public key
    curl https://production.packages.cloudpassage.com/cloudpassage.packages.key | sudo apt-key add -

    # update apt repositories
    sudo apt-get update > /dev/null

    # install the daemon
    sudo apt-get -y install cphalo

    # configure agent key
    sudo /opt/cloudpassage/bin/configure --agent-key=$AGENT_KEY --grid=https://grid.cloudpassage.com/grid --server-label=$server_label

    # start the daemon for the first time
    sudo /etc/init.d/cphalod start
}

install_yum() {
    server_label=$1

    # add CloudPassage repository
    echo -e '[cloudpassage]\nname=CloudPassage\nbaseurl=https://production.packages.cloudpassage.com/redhat/$basearch\ngpgcheck=1' | sudo tee /etc/yum.repos.d/cloudpassage.repo > /dev/null

    # import CloudPassage public key
    sudo rpm --import https://production.packages.cloudpassage.com/cloudpassage.packages.key

    # update yum repositories
    sudo yum check-update > /dev/null

    # install the daemon
    sudo yum -y install cphalo

    # configure agent key
    sudo /opt/cloudpassage/bin/configure --agent-key=$AGENT_KEY --grid=https://grid.cloudpassage.com/grid --server-label=$server_label

    # start the daemon for the first time
    sudo /etc/init.d/cphalod start
}

platform="$(cat /etc/*-release | grep -w ID)"
if [ $AWS_SERVER_LABEL == 0 ]  ; then
    account_id=$(curl -fs http://169.254.169.254/latest/dynamic/instance-identity/document/ | python -c "import json,sys;obj=json.load(sys.stdin);print obj['accountId']")
    instance_id=$(curl -fs http://169.254.169.254/latest/dynamic/instance-identity/document/ | python -c "import json,sys;obj=json.load(sys.stdin);print obj['instanceId']")
    server_label=$account_id\_$instance_id
else
    server_label="$(hostname)"
fi

if [[ $platform == *"ubuntu"* || $platform == *"debian"* ]]; then
    install_deb $server_label
else
    install_yum $server_label
fi
