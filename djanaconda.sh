#!/bin/sh
anacondaFileName=Anaconda3-5.0.1-Linux-x86_64.sh
djangoAppsDir=django-apps
environmentName=env
serverIp=192.168.33.10
port=8989
projectName=testsite

cd /tmp

# Update repo versions here
curl -O https://repo.continuum.io/archive/$anacondaFileName
sha256sum $anacondaFileName

bash $anacondaFileName

# install to /opt/anaconda -- be sure to change permissions
# say yes to anaconda install 

# activate install by passing in the newly created path 
# ( if there is no PATH var in the .bashrc, set it first at the beginning of the existing path var)
export PATH="/opt/anaconda3/bin:$PATH"
source ~/.bashrc



# verify install
conda list


# view python versions
conda search "^python$"

cd /var/www/
mkdir $djangoAppsDir
cd $djangoAppsDir

# create django python env
conda create --name $environmentName python=3

# activate environmentName
source activate $environmentName

# view python version
python --version

# update python for good measure
conda update python

# install django
conda install -c anaconda django 

ufw allow $port

django-admin startproject $projectName

cd $projectName

# add your server to the list of hosts
nano settings.py 

# run your serv
cd ..
python3 manage.py runserver $serverIp:8000


