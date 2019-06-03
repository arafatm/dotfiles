#!/bin/sh
{
    HEROKU_CLIENT_URL="https://s3.amazonaws.com/assets.heroku.com/heroku-client/heroku-client.tgz"

    echo "This script requires superuser access to install software."
    echo "You will be prompted for your password by sudo."

    # clear any previous sudo permission
    sudo -k

    # run inside sudo
    sudo bash <<SCRIPT

  # download and extract the client tarball
  rm -rf /usr/local/heroku
  mkdir -p /usr/local/heroku
  cd /usr/local/heroku

  if [[ -z "$(which wget)" ]]; then
    curl -s $HEROKU_CLIENT_URL | tar xz
  else
    wget -qO- $HEROKU_CLIENT_URL | tar xz
  fi

  mv heroku-client/* .
  rmdir heroku-client

SCRIPT

    # remind the user to add to $PATH
    if [[ ":$PATH:" != *":/usr/local/heroku/bin:"* ]]; then
	echo "Add the Heroku CLI to your PATH using:"
	echo "$ echo 'PATH=\"/usr/local/heroku/bin:\$PATH\"' >> ~/.profile"
    fi

    echo "Installation complete"
}
