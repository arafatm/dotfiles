# Manage my dotfiles.

## Clone && Setup

- Make sure you have ssh keys (deploy key for kodi)
```bash
mkdir $HOME/code && cd $HOME/code
git clone --depth 1 git@github.com:arafatm/dotfiles 
cd dotfiles && bash setup.dotfiles.sh # setup.ubuntu.sh if on ubuntu
```

`crontab -e` # and copy text below to auto bkp specific folders
```
MAILTO=""
0 * * * * $HOME/.bkps.git.cron >> $HOME/tmp/cron.log 2>&1
```
