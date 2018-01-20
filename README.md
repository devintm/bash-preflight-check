# Preflight-check bash script

## Bash script to check if my workstation has everything I need for development:
- [x] Currently checks for:
  - [x] HTTP and HTTPS proxies presence and whether or not they working
  - [x] Internet connectivity
  - [x] Java presence
  - [x] Python presence
  - [x] Ruby presence
  - [x] Vim presence
  - [x] Git presence
  - [x] Docker presence
  - [x] Vagrant presence
  - [x] Homebrew presence
  - [x] rbenv presence
  - [x] wget presence
  - [x] Maven presence
  - [x] Bundler presence
  - [x] Miniconda presence
  - [x] iTerm2 presence
  - [x] gem presence
  - [x] Ruby-on-Rails presence
  - [x] Adshell presence
- [x] Removes duplicates from PATH variable
- [-] Different checks, depending on OS:
  - [x] Mac OS
  - [x] GNU/Linux
  - [ ] Red Hat/Centos
- [-] Downloads missing components:
  - [x] Mac OS
  - [ ] GNU/Linux
  - [ ] Red Hat/Centos

## Some improvements could be made in the future and extra functionality could be added
- [ ] Think about project structure, as at the moment it is not well build
- [ ] Erase duplicated code as much as possible

## To run the script, execute command
  `git clone https://github.com/MikhailMS/preflight-check preflight-check && cd preflight-check && . preflight-check.sh`
## To get an update once downloaded, execute command, when in `preflight-check` folder
  `git pull`

## Tested on MacOs 10.13.2 High Sierra, Centos 7
