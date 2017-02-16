#!/bin/bash
# NVIDIA Jetson TX1
# Sourced from Jetsonhacks via MIT License
# Remove the Libre Office installation
# Useful if you need the extra room
sudo apt-get purge libreoffice*
sudo apt autoremove

# note:  to remove online search (wikipedia, amazon, ect.)
#        go to 'Security & Privacy' settings -> Search tab
#        and disable Online search

# remove unity scope
gsettings set com.canonical.Unity.Lenses disabled-scopes "['more_suggestions-amazon.scope', \
    'more_suggestions-u1ms.scope', 'more_suggestions-populartracks.scope', 'music-musicstore.scope', \
    'more_suggestions-ebay.scope', 'more_suggestions-ubuntushop.scope', 'more_suggestions-skimlinks.scope']"

sudo apt-get remove --purge unity-lens-friends -y
sudo apt-get remove --purge unity-lens-music -y
sudo apt-get remove --purge unity-lens-music -y
sudo apt-get remove --purge unity-lens-photos -y
sudo apt-get remove --purge unity-lens-video -y

sudo apt-get remove --purge unity-scope-audacious -y
sudo apt-get remove --purge unity-scope-calculator -y
sudo apt-get remove --purge unity-scope-chromiumbookmarks -y
sudo apt-get remove --purge unity-scope-clementine -y
sudo apt-get remove --purge unity-scope-colourlovers -y
sudo apt-get remove --purge unity-scope-devhelp -y 
sudo apt-get remove --purge unity-scope-firefoxbookmarks -y 
sudo apt-get remove --purge unity-scope-gdrive -y 
sudo apt-get remove --purge unity-scope-gmusicbrowser -y 
sudo apt-get remove --purge unity-scope-gourmet -y 
sudo apt-get remove --purge unity-scope-guayadeque -y 
sudo apt-get remove --purge unity-scope-manpages -y 
sudo apt-get remove --purge unity-scope-musicstores -y 
sudo apt-get remove --purge unity-scope-musique -y 
sudo apt-get remove --purge unity-scope-openclipart -y 
sudo apt-get remove --purge unity-scope-exdoc -y 
sudo apt-get remove --purge unity-scope-tomboy -y 
sudo apt-get remove --purge unity-scope-video-remote -y 
sudo apt-get remove --purge unity-scope-virtualbox -y 
sudo apt-get remove --purge unity-scope-yelp -y
sudo apt-get remove --purge unity-scope-zotero -y
