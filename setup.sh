#!/usr/bin/env bash

echo ======= step out of git repo
cd ..
 
echo ======= update source list for packages and versions that can be installed
sudo apt-get update

echo ======= add python3.6 PPA == Personal Packages Archives ==  to the list of sources
sudo add-apt-repository -y ppa:deadsnakes/ppa

echo ======= update python 3.6 among the list of packages that can be installed
sudo apt-get update

echo ======= install python3.6
sudo apt-get install -y python3.6

echo ======= make python3.6 default the python3 by symbolic links in /etc/alternatives
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.5 1
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 10
sudo update-alternatives --config -y python3

echo ======= install gunicorn, pip and nginx
sudo apt-get install -y python3-pip nginx gunicorn

echo ======= install virtualenv
sudo pip3 install virtualenv

echo ======= creating the virtual environment
sudo virtualenv -p python3 venv

echo ======= activate the virtual env
source venv/bin/activate

echo ======= Clone the repo
sudo git clone https://github.com/philophilo/yummy_api.git

echo ======= Entering the project folder
cd yummy_api

echo ======= installing all the project requirements
sudo pip3 install -r requirements.txt
