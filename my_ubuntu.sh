#!/usr/bin/env bash
# ----------------------------- VARIÁVEIS ----------------------------- #

PPA_ATOM="ppa:webupd8team/atom"
PPA_CAFFEINE="ppa:caffeine-developers/ppa"
PPA_GRAPHICS_DRIVERS="ppa:graphics-drivers/ppa"
PPA_TESSERACT="ppa:alex-p/tesseract-ocr"
PPA_TEX_STUDIO="ppa:sunderme/texstudio"

REPO_TYPORA="deb https://typora.io/linux ./"
REPO_VIVALDI="deb https://repo.vivaldi.com/archive/deb/ stable main"

URL_FRANZ="https://github.com/meetfranz/franz/releases/download/v5.4.0/franz_5.4.0_amd64.deb"
URL_INSYNC="https://d2t3ff60b2tol4.cloudfront.net/builds/insync_3.0.23.40579-bionic_amd64.deb" ## Not shure, review ##
URL_PCLOUD="https://www.pcloud.com/pt/how-to-install-pcloud-drive-linux.html?download=electron-64"
URL_ZOTERO="https://github.com/retorquere/zotero-deb/releases/download/apt-get/install.sh"

DIRETORIO_DOWNLOADS="$HOME/$USER/Downloads/programas"

PROGRAMAS_PARA_INSTALAR=(
  atom
  caffeine
  chromium-browser
  flameshot ## Screenshot
  gdebi-core ## Pre-req RStudio
  gnome-tweaks
  ghostscript ## Pre-req ocrmypdf
  gretl
  insync
  libexempi3 ## Pre-req ocrmypdf
  libffi6 ## Pre-req ocrmypdf
  pngquant ## Pre-req ocrmypdf
  qpdf ## Pre-req ocrmypdf
  r-base
  snapd
  tesseract-ocr ## Pre-req ocrmypdf
  texstudio
  texlive-latex-recommended
  texlive-latex-extra
  texlive-publishers
  texlive-science
  texlive-humanities
  texlive-font-utils
  texlive-bibtex-extra
  texlive-lang-portuguese
  typora
  vivaldi-stable
  ubuntu-restricted-extras ## Codecs ##
  unpaper ## Pre-req ocrmypdf
  zotero
)
# ---------------------------------------------------------------------- #

# ----------------------------- REQUISITOS ----------------------------- #
## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

## Adicionando/Confirmando arquitetura de 32 bits ##
sudo dpkg --add-architecture i386

## Adicionando Keys ##
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys ACCAF35C ## Insync
wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add - ## typora


## Criando pastas ##
deb http://apt.insync.io/ubuntu focal non-free contrib ## Check

## Atualizando o repositório ##
sudo apt update -y

## Adicionando repositórios de terceiros##
sudo apt-add-repository "$PPA_GRAPHICS_DRIVERS" -y
sudo apt-add-repository "$REPO_TYPORA" -y
sudo apt-add-repository "$REPO_VIVALDI" -y

# ---------------------------------------------------------------------- #

# ----------------------------- EXECUÇÃO ----------------------------- #
## Atualizando o repositório depois da adição de novos repositórios ##
sudo apt update -y

## Download e instalaçao de programas externos ##
mkdir "$DIRETORIO_DOWNLOADS"
wget -c "$URL_INSYNC"              -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_PCLOUD"              -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_FRANZ"              -P "$DIRETORIO_DOWNLOADS"
wget -qO- "$URL_ZOTERO"  -P "$DIRETORIO_DOWNLOADS" | sudo bash



## Instalando pacotes .deb baixados na sessão anterior ##
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb
sudo apt install -f

# Instalar programas no apt
for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done


## Instalando pacotes Snap ##
sudo snap install drawio
sudo snap install okular 
sudo snap install skype --classic
sudo snap install spotify
sudo snap install telegram-desktop
# ---------------------------------------------------------------------- #


## Pacotes pyton
PACOTES_PYTHON=(
	datetime
	jupyterlab
	matplotlib
	notebook
	numba
	numpy	
	ocrmypdf
	pandas
	pandas-datareader
	pysolve3
	rpy2
	scipy
	seaborn
	statsmodels
	sympy
	twine ## Compilar pacote
	wheel ## Compilar pacote
)

for pacote in ${PACOTES_PYTHON[@]}; do
  sudo -H pip3 install --user "$pacote"
  echo "[INSTALADO] - $pacote"
done


# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #
## Finalização, atualização e limpeza##
sudo apt update && sudo apt dist-upgrade -y

sudo apt autoclean
sudo apt autoremove -y
# ---------------------------------------------------------------------- #

PROGRAMAS_NAO_INSTALADOS=(
	RStudio
	InternetBanking
)

echo "Instalação automatizada encerrada"

for nome_do_programa in ${PROGRAMAS_NAO_INSTALADOS[@]}; do
  echo "Seguir para a instalação de  $nome_do_programa"
done


