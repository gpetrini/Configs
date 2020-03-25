#!/usr/bin/env bash
# ----------------------------- VARIÁVEIS ----------------------------- #

PPA_GRAPHICS_DRIVERS="ppa:graphics-drivers/ppa"
PPA_TEX_STUDIO="ppa:sunderme/texstudio"
PPA_TESSERACT="ppa:alex-p/tesseract-ocr"
PPA_ATOM="ppa:webupd8team/atom"
PPA_CAFFEINE="ppa:caffeine-developers/ppa"

URL_INSYNC="https://d2t3ff60b2tol4.cloudfront.net/builds/insync_3.0.23.40579-bionic_amd64.deb" ## Not shure, review ##
URL_PCLOUD="https://www.pcloud.com/pt/how-to-install-pcloud-drive-linux.html?download=electron-64"
URL_RSTUDIO=""

DIRETORIO_DOWNLOADS="$HOME/$USER/Downloads/programas"

PROGRAMAS_PARA_INSTALAR=(
  snapd
  ubuntu-restricted-extras ## Codecs ##
  gdebi-core ## Pre-req RStudio
  gnome-tweaks
  caffeine
  chromium-browser
  flameshot ## Screenshot
  gretl
  pspp
  r-base
  libcanberra-gtk-module ## Pre-req popcorntime
  libgconf-2-4 ## Pre-req popcorntime
  vim
  atom
  texstudio
  texlive-latex-extra
  ghostscript ## Pre-req ocrmypdf
  libexempi3 ## Pre-req ocrmypdf
  libffi6 ## Pre-req ocrmypdf
  pngquant ## Pre-req ocrmypdf
  qpdf ## Pre-req ocrmypdf
  tesseract-ocr ## Pre-req ocrmypdf
  unpaper ## Pre-req ocrmypdf


  libgnutls30:i386
  libldap-2.4-2:i386
  libgpg-error0:i386
  libxml2:i386
  libasound2-plugins:i386
  libsdl2-2.0-0:i386
  libfreetype6:i386
  libdbus-1-3:i386
  libsqlite3-0:i386
)
# ---------------------------------------------------------------------- #

# ----------------------------- REQUISITOS ----------------------------- #
## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

## Adicionando/Confirmando arquitetura de 32 bits ##
sudo dpkg --add-architecture i386

## Atualizando o repositório ##
sudo apt update -y

## Adicionando repositórios de terceiros (Driver Logitech, Lutris e Drivers Nvidia)##
sudo apt-add-repository "$PPA_GRAPHICS_DRIVERS" -y
# ---------------------------------------------------------------------- #

# ----------------------------- EXECUÇÃO ----------------------------- #
## Atualizando o repositório depois da adição de novos repositórios ##
sudo apt update -y

## Download e instalaçao de programas externos ##
mkdir "$DIRETORIO_DOWNLOADS"
wget -c "$URL_INSYNC"              -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_PCLOUD"              -P "$DIRETORIO_DOWNLOADS"

## Instalando pacotes .deb baixados na sessão anterior ##
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

# Instalar programas no apt
for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done

curl https://rclone.org/install.sh | sudo bash ## RClone


## Instalando pacotes Snap ##
sudo snap install spotify
sudo snap install drawio
sudo snap install okular 
sudo snap install skype --classic
# ---------------------------------------------------------------------- #

# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #
## Finalização, atualização e limpeza##
sudo apt update && sudo apt dist-upgrade -y

sudo apt autoclean
sudo apt autoremove -y
# ---------------------------------------------------------------------- #

PROGRAMAS_NAO_INSTALADOS=(
	RStudio
	Franz
	Telegram
	Vivaldi
	Popcorntime
)

echo "Instalação automatizada encerrada"

for nome_do_programa in ${PROGRAMAS_NAO_INSTALADOS[@]}; do
  echo "Seguir para a instalação de  $nome_do_programa"
done


## Pacotes pyton
PACOTES_PYTHON=(
	ocrmypdf
	pandas
	sympy
	numpy
	matplotlib
	seaborn
	pysolve3
	statsmodels
	scipy
	numba
	pandas-datareader
	rpy2
	wheel ## Compilar pacote
	twine ## Compilar pacote
)

for pacote in ${PACOTES_PYTHON[@]}; do
  pip3 install --user "$nome_do_programa"
  echo "[INSTALADO] - $nome_do_programa"
done



