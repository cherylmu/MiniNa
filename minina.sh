#!/bin/bash
####### MiniNA is a script to install all what to need to run (MINA PROTOCOL) in your server >>>> created By Aki
exists()
{
  command -v "$1" >/dev/null 2>&1
}

if exists dialog; then
  echo 'dialog exists!'
else
  echo "installing dialog..wait"
  sudo apt install dialog -y
fi
if exists zip; then
  echo 'zip exists!'
else
  echo "installing zip..wait"
  sudo apt install zip unzip -y
fi

#################################################################################################################################################################################
dialog --backtitle "[ M I n i N A  2.0]" \
--title "About - [ M I n i N A ]" \
--msgbox 'MiniNA is a set of scripts that tries to make life easier for newcomers to Mina Protocol and who have never had prior experience with the Linux terminal.
This script is not related in any way to Mina Protocol.its just a bunch of commands that I (Aki) use personally and want to share with you. 
if MiniNA works for you? ,  perfect!, if not .. you can improve it or fix it! :D
---         ---     --      ---     ----            ----    ----    --  --  ---         -   -   -   ----            ---     --  --          --  -- --   --  --  --  --  --  --  --
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
 DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE 
 OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.' 0 0
 #################################################################################################################################################################################
f5aa1fb=l0aHVidXNlcmNvbnRlbnQuY29tL01pbmFQcm90b  ## >> f5aa1fb + e2db96a part of the base64 code to ofuscate the peers url (noob proof) 
e2db96a=3RlcnJhZm9ybS90ZXN0bmV0cy90dXJiby1waWNrbGVzL ## >> now is useless but still works :D (peers are public) check line 202
cmd=(dialog --separate-output --checklist "[ M I n i N A 2.0 by Aki ]:" 0 0 0) \
options=(1 "Upgrade your Machine" off    # any option can be set to default to "on"
         2 "Install Mina Repositories" off
         3 "Install Mina Dependencies libffi6,libjemalloc,libprocps6,etc." off
         4 "Install Mina-testnet-postake|Mina-generate-keypair" off          
         5 "Create a New Wallet-Keys" off
         6	"BACKUP YOUR KEYS to $HOME/minabackups" off
         7 "Create a **.mina-env** and **.bashrc/.zshrc** Variables" off
         8 "Download Latest Mina Peers" off
         9 "REMOVE ALL MINA PACKAGES AND DEPS (.coda-config,keys are excluded)" off 
         10 "REMOVE ~/.coda-config , /tmp/coda_cache_dir , /tmp/s3_cache_dir Folders from your system " off)
###################################################################################################################################################################################
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
    case $choice in
        1)
            clear
            echo -e " $(tput bold)################################################################################ $(tput sgr0)"
            echo ""
            echo -e " \e[32m                     MiniNA will Upgrade your system with:"
            echo "                      sudo apt update && sudo apt upgrade"
            echo "               That is the First step before install all Mina paCkages"
            echo -e " $(tput sgr0)"
            echo -e " $(tput bold)################################################################################ $(tput sgr0)"
            echo ""
            echo "please wait.."
            sleep 10
            sudo apt update && sudo apt upgrade -y;

            ;;
        2)
            echo "adding http://packages.o1test.net to mina.list in /etc/apt/sources.list.d folder";
            echo "deb [trusted=yes] http://packages.o1test.net release main" | sudo tee /etc/apt/sources.list.d/mina.list 2>/dev/null;
            ;;
        3)
            clear
            echo -e " $(tput bold)################################################################################ $(tput sgr0)"
            echo ""
            echo -e " \e[32m                               Getting Started"
            echo "                     Lets download Manually some .deb packages!"
            echo "                                                  "
            echo "                                                  "
            echo -e " $(tput sgr0)"
            echo -e " $(tput bold)################################################################################ $(tput sgr0)"
            echo "Installing Dependencies..Wait !"
            sleep 5
                if [  -n "$(uname -a | grep Ubuntu)" ]; then
                        echo "your system is Based on Ubuntu..Please Wait,.."
                        sleep 5
                        mkdir -p .MiniNA/ubuntudeps;
                        cd .MiniNA/ubuntudeps;
                        #sudo apt-get install -y libprocps6;
                        sudo apt update && wget "http://de.archive.ubuntu.com/ubuntu/pool/main/libf/libffi/libffi6_3.2.1-8_amd64.deb";
                        wget "http://de.archive.ubuntu.com/ubuntu/pool/universe/j/jemalloc/libjemalloc1_3.6.0-11_amd64.deb";
                        wget "http://archive.ubuntu.com/ubuntu/pool/main/p/procps/libprocps6_3.3.12-3ubuntu1_amd64.deb";
                        sudo dpkg -i *.deb;
                        sudo apt install -f;
                        sudo rm *.deb
                         cd ../..
                         rm -rf .MiniNA
                         wait
                elif [  -n "$(uname -a | grep Debian)" ]; then
                        echo "your system is Based on Debian..Please Wait,.."
                        sleep 5
                        mkdir -p .MiniNA/debiandeps;
                        cd .MiniNA/debiandeps; 
                        #sudo apt install  libjemalloc-dev libjemalloc2 -y;
                        sudo apt update -y && wget "http://ftp.de.debian.org/debian/pool/main/libf/libffi/libffi6_3.2.1-9_amd64.deb";
                        wget "http://ftp.de.debian.org/debian/pool/main/p/procps/libprocps6_3.3.12-3+deb9u1_amd64.deb";
                        wget "http://ftp.de.debian.org/debian/pool/main/j/jemalloc/libjemalloc1_3.6.0-9.1_amd64.deb";
                        #wget "http://ftp.de.debian.org/debian/pool/main/j/jemalloc/libjemalloc-dev_3.6.0-9.1_amd64.deb";
                        sudo dpkg -i *.deb;
                        sudo apt install -f;
                        sudo rm *.deb
                        cd ../..
                        rm -rf .MiniNA
                        wait
                fi
            ;;
        4)
            echo "Installing Mina-testnet-postake|Mina-generate-keypair"
				#TESTNET="$(curl -s https://minaprotocol.com/docs/getting-started | grep 'mina-testnet-postake-medium-curves=')" # >>> was working before.switch to manual 
					sudo apt-get install -y curl mina-testnet-postake-medium-curves mina-generate-keypair
						#${TESTNET}
                        echo "done!"
						sleep 5
            ;;
        5)
            echo "Creating Folders and Files "
                echo""
                echo "Creating Key folder with my own hands.."
                sleep 3
                mkdir -p ~/keys
				echo "Done!"
				sleep 2
				clear
			if [[ -e $HOME/keys/my-wallet && -e $HOME/keys/my-wallet.pub ]] ;then # >>> check if wallet exist
				echo "we found a wallet in your system, if you want to create a new wallet please Backup and move those files first"
				echo " the script will continue but will not pop up the the screen to create a new wallet"
				echo "Please wait 10.."
				sleep 10
				continue ## >> because one wallet was found the script jump to option 6 if was selected and keep going..
			else
				echo -e " $(tput bold)################################################################################ $(tput sgr0)"
				echo ""
				echo -e " \e[32m 	This will create two files on your system, ~/keys/my-wallet"
				echo "     	which contains the encrypted private key and ~/keys/my-wallet.pub"
				echo "        which contains the public key in plain text. Please store"
				echo " 	the private key file and password you used in a secure place."
				echo -e " $(tput sgr0)"
				echo -e " $(tput bold)################################################################################ $(tput sgr0)"
				read -n 1 -s -r -p "Press any key to continue"
				echo ""
				mina-generate-keypair -privkey-path ~/keys/my-wallet | tee ~/MinaWallet.txt # >>> save a copy of the output inside MinaWallet.txt PD, password are not saved 
				sed -i '/Password for new private key file/d' ~/MinaWallet.txt # >>> delete this useless line inside the file
				sed -i '/mina-generate-keypair/d'  ~/MinaWallet.txt # >>> delete this useless line inside the file
				sudo chown -R $USER  ~/keys
				sudo chown -R $USER  ~/keys/my-wallet
				chmod 700 ~/keys
				chmod 600 ~/keys/my-wallet
				echo ""
				echo "a copy of mina-generate-keypair output have been saved to MinaWallet.txt for easy access:"
				echo "(this file is not part of coda daemon itself,is only for your personal use)"				
				echo ""
				cat ~/MinaWallet.txt
				echo ""
				echo ""
				echo "  is saved in $USER/MinaWallet.txt"
				sleep 5
			fi
            ;;
        
        6)
				echo "lets make a backup of your New wallet Files"
				echo ""
				mkdir -p $HOME/minabackups				
				DATE=$(date +%Y-%m-%d-%H%M%S)
				BACKUP_DIR="$HOME/minabackups"
				SOURCE="$HOME/keys"
				zip -r -j $BACKUP_DIR/backup-$DATE.tar.gz $SOURCE 2>/dev/null
				echo "saved to >>> $HOME/minabackup FOLDER"
                echo ""
                echo ""
            ;;
        
        7)
                ## bash or zshrc lets check it.
           if [ -n "$($SHELL -c 'echo $BASH_VERSION')" ]; then
                shell_profile="$HOME/.bashrc"
           elif [ -n "$($SHELL -c 'echo $ZSH_VERSION')" ]; then
                shell_profile="$HOME/.zshrc"
            fi
                # >>> deleting CODA_PUBLIC_KEY  & MINA_PUBLIC_KEY variables dont worry we added later in line 79-90-91
        sed -i '/MINA/d' "$shell_profile"
        sed -i '/CODA/d' "$shell_profile"

                # >>> reading your wallet to added later line 89-90
        MINAADRESS=$(cat ~/keys/my-wallet.pub)

                # >>> asking for your mina wallet password and add it to .mina-env in Home directory
        MINAPASS=$(dialog --title "adding your wallet Password to .mina-env" \
         --clear \
         --insecure \
         --passwordbox "Enter your Mina wallet password that will be storage in ~/.mina-env" 10 30 3>&1- 1>&2- 2>&3-)
cat <<EOF >~/.mina-env
CODA_PRIVKEY_PASS="${MINAPASS}"
EXTRA_FLAGS=" -file-log-level Info "
EOF
                ## >>> add variables to .bashrc or .zshrc depends of your terminal line 171-179
echo "export CODA_PUBLIC_KEY=${MINAADRESS}" >> "${shell_profile}" 
echo  "export MINA_PUBLIC_KEY=${MINAADRESS}" >> "${shell_profile}"
         ;;   


        8)
            clear
            echo ""
            echo "Downloading Latest Peers.." ### >> dont need it anymore peers are public but works and its cool
            MINAPEERS=$(echo -n "aHR0cHM6Ly9yYXcuZ2"$f5aa1fb"2NvbC9jb2RhLWF1dG9tYXRpb24vbWFzdGVyL"$e2db96a"3BlZXJzLnR4dAo=" | base64 --decode) &&  wget -q --show-progress -O ~/peers.txt $MINAPEERS
            sleep 3
            echo ""
            echo "DOne, Time to Bootstrap!"
        ;; 
        
        9)
            echo ""
            echo "removing libjemalloc-dev libjemalloc2 libffi6 mina-testnet-postake-medium-curves  mina-generate-keypair that was previously installed"
            echo "MiniNa will not remove your coda-config,keys folders"
            echo ""
            echo "Please Wait.."
            sleep 5
            sudo apt purge libjemalloc-dev libjemalloc2 mina-testnet-postake-medium-curves  mina-generate-keypair -y # >>> delete mina-testnet and deps..
            sudo apt autoremove -y 
            sed -i '/MINA/d' "$shell_profile" 2>/dev/null # >> remove Mina varibales from .bashrc
            sed -i '/CODA/d' "$shell_profile" 2>/dev/null # >> remove coda varibales from .bashrc
            echo ""
            echo "Done! , Mina has gone!"
        ;;
       10)
            echo ""
            echo "Removing coda-config , and coda temp folders"
            systemctl --user stop mina 2>/dev/null
            rm -rf ~/.coda-config && rm -rf /tmp/coda_cache_dir && rm -rf /tmp/s3_cache_dir
            echo "DONe!"
       ;;

esac
done
