#!/bin/bash

#update the image
echo "Updating the system..."
sudo apt-get update
sudo apt-get -y dist-upgrade
sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:jonathonf/python-3.6
sudo apt-get update
sudo apt-get install -y python3.6 python3-pip python3-dev nginx gunicorn
sudo apt-get install -y --no-install-recommends apt-utils python3-apt
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.5 1
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 10
sudo update-alternatives --config python3

# cloning the project
sudo mkdir /home/ubuntu/trial/ && cd /home/ubuntu/trial/
echo "cloning the repository from github..."
sudo git clone https://github.com/philophilo/yummy_api.git

# create the virtual environment
echo "creating varitual environment.."
sudo pip install virtualenv
sudo virtualenv venv2
source venv2/bin/activate
cd yummy_api

# install project requirments
echo "install requirments..."
pip install -r requirements.txt
