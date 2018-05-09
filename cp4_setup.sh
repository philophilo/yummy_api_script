update_python(){
	echo ============================================= update ubuntu  ================================================================
    sudo apt-get update # update source list for packages and versions that can be installed
}

install_npm(){
	echo ============================================= install python3.6 ==============================================================
    sudo apt-get install npm # install npm
}

install_nodejs(){
	echo ============================================= install nodejs =================================================================
    curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
    sudo apt-get install -y nodejs # install nodejs
}

install_essentials(){
	echo ======================================== install build essentials ============================================================
    sudo apt-get install -y build-essential # references all the packages needed to compile a debian package
}

app_setup(){
	echo ============================================= start application ==============================================================
    git clone https://github.com/philophilo/yummy-react.git # clone the repo
    cd yummy_react
    npm install # install dependencies in packages.json
    npm start # start application
}

run(){
    update_python
    install_npm
    install_nodejs
    install_essentials
    app_setup
}

run
