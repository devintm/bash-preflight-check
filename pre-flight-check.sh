#!/bin/bash

# COLOUR CONSTANTS
GREEN='\033[0;32m'
LIGHT_BLUE='\033[1;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

verify_proxies_setup() {
  printf "${LIGHT_BLUE}Checking proxies${NC}\n"
  if [[ ! -z "${HTTP_PROXY// }" ]];then
    curl -s --max-time 10 -x "${HTTP_PROXY}" ip-api.com/json | sed 's/\\\\\//\//g' | sed 's/[{}]//g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | sed 's/\"\:\"/\|/g'| sed 's/[\,]/ /g' | sed 's/\"//g' | grep -w "city" | sed -e "s/^city|//"
    _country_code=$!
    if [[ ! -z "$_country_code// " ]];then
      printf "${GREEN} --> HTTP_PROXY is set : ${HTTP_PROXY} and working${NC}\n"
    else
      printf "${YELLOW} --> HTTP_PROXY is set : ${HTTP_PROXY} but doesn't work${NC}\n"
    fi
  else
    printf "${RED} --> HTTP_PROXY is not set${NC}\n"
  fi

  if [[ ! -z "${http_proxy// }" ]];then
    curl -s --max-time 10 -x "${http_proxy}" ip-api.com/json | sed 's/\\\\\//\//g' | sed 's/[{}]//g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | sed 's/\"\:\"/\|/g'| sed 's/[\,]/ /g' | sed 's/\"//g' | grep -w "city" | sed -e "s/^city|//"
    _country_code=$!
    if [[ ! -z "$_country_code// " ]];then
      printf "${GREEN} --> http_proxy is set : ${http_proxy} and working${NC}\n"
    else
      printf "${YELLOW} --> http_proxy is set : ${http_proxy} but doesn't work${NC}\n"
    fi
  else
    printf "${RED} --> http_proxy is not set${NC}\n"
  fi

  if [[ ! -z "${HTTPS_PROXY// }" ]];then
    curl -s --max-time 10 -x "${HTTPS_PROXY}" ip-api.com/json | sed 's/\\\\\//\//g' | sed 's/[{}]//g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | sed 's/\"\:\"/\|/g'| sed 's/[\,]/ /g' | sed 's/\"//g' | grep -w "city" | sed -e "s/^city|//"
    _country_code=$!
    if [[ ! -z "$_country_code// " ]];then
      printf "${GREEN} --> HTTPS_PROXY is set : ${HTTPS_PROXY} and working${NC}\n"
    else
      printf "${YELLOW} --> HTTPS_PROXY is set : ${HTTPS_PROXY} but doesn't work${NC}\n"
    fi
  else
    printf "${RED} --> HTTPS_PROXY is not set${NC}\n"
  fi

  if [[ ! -z "${https_proxy// }" ]];then
    curl -s --max-time 10 -x "${https_proxy}" ip-api.com/json | sed 's/\\\\\//\//g' | sed 's/[{}]//g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | sed 's/\"\:\"/\|/g'| sed 's/[\,]/ /g' | sed 's/\"//g' | grep -w "city" | sed -e "s/^city|//"
    _country_code=$!
    if [[ ! -z "$_country_code// " ]];then
      printf "${GREEN} --> https_proxy is set : ${https_proxy} and working${NC}\n"
    else
      printf "${YELLOW} --> https_proxy is set : ${https_proxy} but doesn't work${NC}\n"
    fi
  else
    printf "${RED} --> https_proxy is not set${NC}\n"
  fi
}

internet_connection() {
  printf "${LIGHT_BLUE}Checking internet connectivity${NC}\n"
  if [[ `curl --silent --max-time 10 http://google.com` ]]; then
    printf "${GREEN} --> Online${NC}\n"
  else
    printf "${RED} --> Offline${NC}\n"
  fi
}

verify_wget_setup() {
  printf "${LIGHT_BLUE}Checking wget setup${NC}\n"
  if type -p wget; then
    printf "${GREEN} --> Found wget executable in PATH${NC}\n"
    wget_version=`wget --version | sed 's/[^0-9.]*\([0-9.]*\).*/\1/' | sed -n 1p`
    printf "${GREEN} --> wget version $wget_version is installed${NC}\n"
  else
    printf "${RED} --> No wget executable is found${NC}\n"
  fi
}

get_var () {
    eval 'printf "%s\n" "${'"$1"'}"'
}
set_var () {
    eval "$1=\"\$2\""
}

deduplicate() {
    printf "${LIGHT_BLUE}PATH Deduplication${NC}\n"
    pathvar_name="$1"
    pathvar_value="$(get_var "$pathvar_name")"
    deduped_path="$(perl -e 'print join(":",grep { not $seen{$_}++ } split(/:/, $ARGV[0]))' "$pathvar_value")"
    set_var "$pathvar_name" "$deduped_path"
    printf "${GREEN} --> Completed${NC}\n"
}

verify_java_setup() {
  printf "${LIGHT_BLUE}Checking Java setup${NC}\n"
  if type -p java; then
    printf "${GREEN} --> Found Java executable in PATH${NC}\n"
    _java=java
  elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
    printf "${GREEN} --> Found Java executable in JAVA_HOME${NC}\n"
    _java="$JAVA_HOME/bin/java"
  else
    printf "${RED}Java is not available - Check JAVA_HOME or PATH${NC}\n"
  fi

  if [[ "$_java" ]]; then
    java_version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
    printf "${GREEN} --> Java version $java_version is installed${NC}\n"
    if [[ "$java_version" < "1.7" ]]; then
      printf "${YELLOW}Please upgrade your Java to version 1.7 or above${NC}\n"
    fi
  fi
}

verify_python_setup() {
  printf "${LIGHT_BLUE}Checking Python setup${NC}\n"
  if type -p python; then
    printf "${GREEN} --> Found Python executable in PATH${NC}\n"
    python_version=`python --version 2>&1 | awk '{print $2}'`
    printf "${GREEN} --> Python version $python_version is installed${NC}\n"
  else
    printf "${RED} --> No Python executable is found${NC}\n"
  fi
}

verify_ruby_setup() {
  printf "${LIGHT_BLUE}Checking Ruby setup${NC}\n"
  if type -p ruby; then
    printf "${GREEN} --> Found Ruby executable in PATH${NC}\n"
    ruby_version=`ruby -v | awk '{print $2}' || echo ""`
    if [[ ! -z "$ruby_version" ]];then
      printf "${GREEN} --> Ruby version $ruby_version is installed${NC}\n"
    else
      printf "${YELLOW} --> Ruby version is not recognized, possibly you did not set it. Try run 'rbenv global [version]' if you have rbenv installed${NC}\n"
    fi
  else
    printf "${RED} --> No Ruby executable is found${NC}\n"
  fi
}

verify_docker_setup() {
  printf "${LIGHT_BLUE}Checking Docker setup${NC}\n"
  if type -p docker; then
    printf "${GREEN} --> Found Docker executable in PATH${NC}\n"
    docker_version=`docker --version | awk '{print $3}' | sed 's/,*$//g'`
    printf "${GREEN} --> Docker version $docker_version is installed${NC}\n"
  else
    printf "${RED} --> No Docker executable is found${NC}\n"
  fi
}

verify_vagrant_setup() {
  printf "${LIGHT_BLUE}Checking Vagrant setup${NC}\n"
  if type -p vagrant; then
    printf "${GREEN} --> Found Vagrant executable in PATH${NC}\n"
    vagrant_version=`vagrant --version | awk '{print $2}'`
    printf "${GREEN} --> Vagrant version $vagrant_version is installed${NC}\n"
  else
    printf "${RED} --> No Vagrant executable is found${NC}\n"
  fi
}

verify_chef_setup() {
  printf "${LIGHT_BLUE}Checking Chef setup${NC}\n"
  if type -p chef-client; then
    printf "${GREEN} --> Found Chef executable in PATH${NC}\n"
    chef_version=`chef-client -version | awk '{print $2}'`
    printf "${GREEN} --> Chef version $chef_version is installed${NC}\n"
  else
    printf "${RED} --> No Chef executable is found${NC}\n"
  fi
}

verify_git_setup() {
  printf "${LIGHT_BLUE}Checking Git setup${NC}\n"
  if type -p git; then
    printf "${GREEN} --> Git is installed${NC}"
    git_version=`git --version | awk '{print $3}'`
    printf "${GREEN} --> Git version $git_version is installed${NC}\n"
  else
    printf "${RED} --> No Git executable is found${RED}\n"
  fi
}

verify_vim_setup() {
  printf "${LIGHT_BLUE}Checking Vim setup${NC}\n"
  if type -p vim; then
    printf "${GREEN} --> Vim executable in PATH${NC}\n"
    vim_version=`vim --version | grep "VIM" | awk '{print $5}' | tr -d '\n'`
    printf "${GREEN} --> Vim version $vim_version is installed${NC}\n"
  else
    printf "${RED} --> No Vim executable is found${NC}\n"
  fi
}

verify_homebrew_setup() {
  printf "${LIGHT_BLUE}Checking Homebrew setup${NC}\n"
  if type -p brew; then
    printf "${GREEN} --> Homebrew executable in PATH${NC}\n"
    brew_version=`brew --version | awk '{print $2}' | tr -d '(git' | tr -d '\n'`
    printf "${GREEN} --> Homebrew version $brew_version is installed${NC}\n"
  else
    printf "${RED} --> No Homebrew executable is found${NC}\n"
  fi
}

verify_smcfancontrol_setup() {
  printf "${LIGHT_BLUE}Checking if smcfancontrol installed${NC}\n"
  _smcfancontrol=`brew cask list | grep smcfancontrol | awk '{print $1}'`
  if [[ "$_smcfancontrol" ]]; then
    printf "${GREEN} --> smcfancontrol installed${NC}\n"
  else
    printf "${RED} --> smcfancontrol is not installed${NC}\n"
  fi
}

verify_rbenv_setup() {
  printf "${LIGHT_BLUE}Checking rbenv setup${NC}\n"
  if type -p rbenv; then
    printf "${GREEN} --> rbenv executable in PATH${NC}\n"
    rbenv_version=`rbenv --version | awk '{print $2}'`
    printf "${GREEN} --> rbenv version $rbenv_version is installed${NC}\n"
  else
    printf "${RED} --> No rbenv executable is found${NC}\n"
  fi
}

run_preflight_check_mac() {
  printf "${YELLOW} -->${LIGHT_BLUE} Preflight Checks for Mac OS systems ${YELLOW}<--${NC}\n"
  verify_proxies_setup
  verify_wget_setup
  internet_connection
  deduplicate PATH
  verify_java_setup
  verify_python_setup
  verify_rbenv_setup
  verify_ruby_setup
  verify_git_setup
  verify_vim_setup
  verify_docker_setup
  verify_vagrant_setup
  verify_chef_setup
  verify_homebrew_setup
  verify_smcfancontrol_setup
}

run_preflight_check_linux() {
  printf "${YELLOW} -->${LIGHT_BLUE} Preflight Checks for Linux systems ${YELLOW}<--${NC}\n"
  verify_proxies_setup
  verify_wget_setup
  internet_connection
  deduplicate PATH
  verify_java_setup
  verify_python_setup
  verify_rbenv_setup
  verify_ruby_setup
  verify_git_setup
  verify_vim_setup
  verify_docker_setup
  verify_vagrant_setup
  verify_chef_setup
}

if [ "$(uname)" == "Darwin" ]; then
    # Mac OS X
    run_preflight_check_mac
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # GNU/Linux
    run_preflight_check_linux
fi
