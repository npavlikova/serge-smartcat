#!/usr/bin/env bash

sudo groupadd serge
sudo useradd -g serge serge -m -d /usr/local/serge


sudo apt-get -qq update

sudo apt-get -qq -y install build-essential libssl-dev libexpat-dev unzip wget

cd /usr/local/serge
sudo -u serge wget https://github.com/evernote/serge/archive/master.zip -O serge-master.zip
sudo -u serge unzip serge-master.zip
sudo -u serge unlink serge-master.zip
sudo cpan App::cpanminus
cd serge-master
sudo cpanm --installdeps .
sudo ln -s /usr/local/serge/serge-master/bin/serge /usr/local/bin/serge

# 6.03 актуальная, ставим 6.01 принудительно так как 6.03 вызывает неразрешаемые зависимости
sudo cpanm HTTP::Daemon@6.01

sudo cpanm Serge::Sync::Plugin::TranslationService::Smartcat

sudo cpan install LWP::Protocol::https

sudo -u serge ssh-keygen -t rsa -N "" -f .id_rsa_serge

sudo -u serge cp /usr/local/serge/serge-master/bin/tools/feature-branch-config-generator/fbcgen.pl /usr/local/serge/serge-master/
sudo -u serge mkdir groups
cd groups
sudo -u serge mkdir myproject
cd myproject
sudo -u serge cp /usr/local/serge/serge-master/bin/tools/feature-branch-config-generator/{myproject.cfg,myproject.inc,myproject.serge.tmpl,myproject_branches.txt} /usr/local/serge/serge-master/groups/myproject
sudo -u serge cp /usr/local/serge/serge-master/bin/tools/feature-branch-config-generator/fbcgen.pl /usr/local/serge/serge-master/
mkdir log
cd log
touch smartcat.log
