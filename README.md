# MiniNa: Ready to be used with Mina Protocol "TestWorld"
* you must have a keypairs and password to full use this tool
MiniNa is a deps Mina Protocol installer , made for Noobs by Noobs
What the script do:
[![testworld1.png](https://i.postimg.cc/BZpJsdsq/testworld1.png)](https://postimg.cc/rzDBNZKb)

Usage:
* First download it ```wget https://raw.githubusercontent.com/AkiAfroo/MiniNa/main/minina.sh```
* Second: chmod +x minina.sh 
* third:  bash minina.sh
* the script will try to install dialog , zip , unzip if are not installed in your system before launch the menu.
* Fresh install after menu pop up: select with mouse or moving with arrows and using spacebar
* options : ```1,2,3,4,5,7,8```
[![first-install-minina.png](https://i.postimg.cc/q750w1LV/first-install-minina.png)](https://postimg.cc/yJcwYXtv)

Backup:
* you can backup your wallet >> option 6
[![backup-minina.png](https://i.postimg.cc/VLgj6tg0/backup-minina.png)](https://postimg.cc/0b66XbL9)


Removing Mina from your system
* ~/.coda-config , keys folder and .mina-env are exclude >> option 9
[![remove-mina-packages-deps.png](https://i.postimg.cc/3r4Gh646/remove-mina-packages-deps.png)](https://postimg.cc/vDyTL0vL)

Removing temp directories and coda-config
* when the daemon stuck sometimes a good option is clean tmp mina folders and ~/.coda-config folder
[![remove-temp-Folders-coda-config.png](https://i.postimg.cc/sfv85p1S/remove-temp-Folders-coda-config.png)](https://postimg.cc/7brmkJ3Y)

Notes
* the script will detect if a wallet is storage in ~/keys folder to avoid overwrite the current ones if you select option 5 my mistake.

* now after is installed run ```coda``` in your terminal or ```coda version``` to check the installation is OK.
* Have fun !
