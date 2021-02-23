#!/bin/bash  -l

rvm use ruby-2.6.3        
while :; do 
    ruby push_to_google_drive.rb /home/jecable/distro/sandy_dog_bk/*
    sudo chown -R jecable /home/jecable/distro/sandy_dog_bk/incoming/*
    ruby clean_google_drive.rb /home/jecable/distro/sandy_dog_bk/*; 
    echo "Done." 
    sleep 43200; 
done
