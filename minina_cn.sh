#!/bin/bash
####### MiniNA is a script to install all what to need to run (MINA PROTOCOL) in your server >>>> created By Aki
exists()
{
  command -v "$1" >/dev/null 2>&1
}

if exists dialog; then
  echo '对话框已存在!'
else
  echo "正在安装对话框..请等待..."
  sudo apt install dialog -y
fi
if exists zip; then
  echo 'zip 已存在!'
else
  echo "正在安装zip..请等待..."
  sudo apt install zip unzip -y
fi

#################################################################################################################################################################################
dialog --backtitle "[ M I n i N A_C N  1.0]" \
--title "About - [ M I n i N A_C N ]" \
--msgbox 'MiniNA 是一个脚本集合，适用于对linux不太熟悉的人。脚本集合了安装和运行mina节点需要的各种命令。
---         ---     --      ---     ----            ----    ----    --  --  ---         -   -   -   ----            ---     --  --          --  -- --   --  --  --  --  --  --  --
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
 DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE 
 OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.' 0 0
 #################################################################################################################################################################################
cmd=(dialog --separate-output --checklist "[ M I n i N A 2.1 for TestWorld - by Aki ]:" 0 0 0) \
options=(1 "Upgrade your Machine" off    # any option can be set to default to "on"
         2 "Install Mina Repositories" off
         3 "Install Mina Dependencies libffi6,libjemalloc,libprocps6,etc." off
         4 "Install Mina-testnet-postake|Mina-generate-keypair" off          
         5 "Download and Unzip your Keys.zip" off
         6 "BACKUP YOUR KEYS to $HOME/minabackups" off
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
            #echo "deb [trusted=yes] http://packages.o1test.net release main" | sudo tee /etc/apt/sources.list.d/mina.list 2>/dev/null;
            echo "deb [trusted=yes] http://packages.o1test.net release main" | sudo tee /etc/apt/sources.list.d/mina.list 2>/dev/null
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
                elif [  -n "$(cat /etc/issue | grep Debian)"  ]; then
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
				TESTNET="$(curl -s https://minaprotocol.com/docs/connecting | grep 'mina-testnet-postake-medium-curves=')" # >>> was working before.switch to manual 
					#sudo apt-get install -y curl mina-testnet-postake-medium-curves mina-generate-keypair
						${TESTNET}
                        sudo apt install mina-generate-keypair
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
				echo "we found a wallet in your system !, if you want to Download a new pairs of Keys please Backup and move those files first"
				echo " the script will continue but will not pop up the the screen to Download your keys"
				echo "Please wait 10.."
				sleep 10
				continue ## >> because one wallet was found the script jump to option 6 if was selected and keep going..
			else
				echo -e " $(tput bold)################################################################################ $(tput sgr0)"
				echo ""
				echo -e " \e[32m 	This will Download a zip file  two files on your system, ~/keys/my-wallet"
				echo "     	which contains the encrypted private key and ~/keys/my-wallet.pub"
				echo "        which contains the public key in plain text. Please store"
				echo " 	the private key file and password you used in a secure place."
				echo -e " $(tput sgr0)"
				echo -e " $(tput bold)################################################################################ $(tput sgr0)"
                echo ""
				read -n 1 -s -r -p "Press any key to continue"
                echo ""
                echo "now we will download and unzip your keys that o(1)Labs sent to you by email"
                read -p "Enter Full Url Link of your key.zip: " minakey_email
				echo ""
                mkdir -p ~/keys
                curl -o ~/keys/new-keys.zip $minakey_email
                cd ~/keys
                unzip new-keys.zip
                mv extra_fish_account_*.pub my-wallet.pub
                mv extra_fish_account_* my-wallet
                rm new-keys.zip
                ### some system complains if root use sudo xD
                if [ "${UID}" -eq 0 ]
                then
				chown -R $USER  ~/keys
				chown -R $USER  ~/keys/my-wallet
                else
				sudo chown -R $USER  ~/keys
				sudo chown -R $USER  ~/keys/my-wallet
                fi
				sudo chown -R $USER  ~/keys
				sudo chown -R $USER  ~/keys/my-wallet
				chmod 700 ~/keys
				chmod 600 ~/keys/my-wallet
                echo ""
                if [[ -e $HOME/keys/my-wallet && -e $HOME/keys/my-wallet.pub ]] ;then
                echo "zip Downladed, extracted and permissions set to both files"
                else
                    echo "something weird has happened. dragons fly around you,"
                fi    
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
#######################################################################################################################
       clear
       echo ""
       echo "hint: copy your password from your email that o(1)Labs sent to you and paste here , right click paste"
       echo "you will not see the password is for security reasons"
       echo ""
       read -s -p "Enter your Mina wallet password (from your email) that will be saved in ~/.mina-env: " MINAPASS  # >>> asking for your mina wallet password and add it to .mina-env in Home directory
cat <<EOF >~/.mina-env
CODA_PRIVKEY_PASS="${MINAPASS}"
EXTRA_FLAGS="  -file-log-level Info -work-selection seq -super-catchup "
EOF
                ## >>> add variables to .bashrc or .zshrc depends of your terminal line 171-179
echo "export CODA_PUBLIC_KEY=${MINAADRESS}" >> "${shell_profile}" 
echo  "export MINA_PUBLIC_KEY=${MINAADRESS}" >> "${shell_profile}"
         ;;   


        8)
            clear
            echo ""
            echo "Downloading Latest Peers.." ### >> dont need it anymore peers are public but works and its cool
            wget -O ~/peers.txt https://raw.githubusercontent.com/MinaProtocol/coda-automation/bug-bounty-net/terraform/testnets/testworld/peers.txt
            sleep 3
            clear
            echo ""
            echo "DOne, Time to Bootstrap!"
            echo ""
            coda version
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
            sed -i '/MINA/d' "$shell_profile" 2>/dev/null # >> remove Mina Variables from .bashrc
            sed -i '/CODA/d' "$shell_profile" 2>/dev/null # >> remove coda Variables from .bashrc
            clear
            echo ""
            echo "Done! , Mina has gone!"
        ;;
       10)
            echo ""
            echo "Removing coda-config , and coda temp folders"
            systemctl --user stop mina 2>/dev/null
            rm -rf ~/.coda-config && rm -rf /tmp/coda_cache_dir && rm -rf /tmp/s3_cache_dir
            clear
            echo "DONe!"
       ;;

esac
done
