# Manage my dotfiles.

```
git clone git@github.com:arafatm/dotfiles.git $HOME/dotfiles
bash $HOME/dotfiles/setup.dotfiles.sh
source $HOME/.bashrc
```

`crontab -e` # and copy text below to auto bkp specific folders
```
MAILTO=""
0 * * * * $HOME/.bkps.git.cron >> $HOME/tmp/cron.log 2>&1
```
