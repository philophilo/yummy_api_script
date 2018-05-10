#!/usr/bin/env bash

update_ubuntu(){
	echo ============================================= update ubuntu  ================================================================
	cd .. # step out of git repo
	sudo apt-get update # update source list for packages and versions that can be installed
}

update_python(){
	echo ============================================= install python3.6 ==============================================================
	sudo add-apt-repository -y ppa:deadsnakes/ppa # add python3.6 PPA == Personal Packages Archives ==  to the list of sources
	sudo apt-get update #update python 3.6 among the list of packages that can be installed
	sudo apt-get install -y python3.6 python3.6-dev # install python3.6 and python3.6 dev 
	sudo apt-get install -y python3-pip
} 

set_default_python(){
	echo ============================ make python3.6 default the python3 by symbolic links in /etc/alternatives ========================
	sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.5 1
	sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 10
	sudo update-alternatives --config -y python3
}

install_server(){
	echo ============================================== install gunicorn and nginx ====================================================
	sudo apt-get install -y nginx gunicorn
}

install_python_dependencies(){
    echo ====================================== install extra packages for python development environment==============================
    sudo apt-get install -y build-essential autoconf libtool pkg-config python-opengl python-imaging python-pyrex python-pyside.qtopengl idle-python2.7 qt4-dev-tools qt4-designer libqtgui4 libqtcore4 libqt4-xml libqt4-test libqt4-script libqt4-network libqt4-dbus python-qt4 python-qt4-gl libgle3 python-dev libssl-dev
    sudo easy_install greenlet
    sudo easy_install gevent
}

create_virtual_environment(){
    echo ============================================ create python3.6 virtual environment ============================================
    pip3 install virtualenv # install virtualenv
    virtualenv -p python3 venv # creating the virtual environment
    source venv/bin/activate # activate the virtual env
}

app_setup(){
    echo ================================================= app setup ==================================================================
    git clone https://github.com/philophilo/yummy_api.git # Clone the repo
    cd yummy_api # Entering the project folder
    pip install -r requirements.txt # installing all the project requirements
}

nginx_setup(){
    echo ================================================= nginx setup ================================================================
    sudo systemctl start nginx # start nginx
    sudo cp ../yummy_api_script/yummy /etc/nginx/sites-available/ # copy nginx config to available sites
    sudo rm -rf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default # remove default nginx configurations
    sudo ln -s /etc/nginx/sites-available/yummy /etc/nginx/sites-enabled/ # create symbolic link to nginx new configuration
    sudo systemctl restart nginx # restart nginx
    sudo systemctl status nginx
}

database_setup(){
    echo ================================================= database setup ============================================================
    # export environment variables 
    export DATABASE_URL='postgresql://philophilo:12345678@databasepsql.c4ecouwmxh9c.us-east-2.rds.amazonaws.com:5432/yummy'
    # perform database migrations
    python manage.py db init
    python manage.py db migrate
    python manage.py db upgrade
}

setup_ssh_certbot(){
    echo ================================================= certbot setup ============================================================
    sudo add-apt-repository ppa:certbot/certbot
    sudo apt-get update
    sudo apt-get install python-certbot-nginx
    sudo certbot --nginx
}

setup_supervisor(){
    echo ================================================= supervisor setup ============================================================
    sudo apt-get install -y supervisor
    sudo cp ../yummy_api_script/yummy.conf /etc/supervisor/conf.d/yummy.conf
}

start_app(){
    echo ================================================= start with gunicorn ======================================================
    sudo supervisorctl reread
    sudo supervisorctl update
    sudo supervisorctl start yummy
}

run(){
    update_ubuntu
    update_python
    set_default_python
    install_server
    install_python_dependencies
    create_virtual_environment
    app_setup
    nginx_setup
    database_setup
    setup_ssh_certbot
    setup_supervisor
    start_app
}

run
