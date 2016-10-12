# The output of all these installation steps is noisy. With this utility
# the progress report is nice and concise.
function install {
    echo installing $1
    shift
    apt-get -y install "$@" >/dev/null 2>&1
}

function install_ruby {
  echo updating package information
  apt-add-repository -y ppa:brightbox/ruby-ng >/dev/null 2>&1
  apt-get -y update >/dev/null 2>&1

  install Ruby ruby2.3
  update-alternatives --set ruby /usr/bin/ruby2.3 >/dev/null 2>&1
  update-alternatives --set gem /usr/bin/gem2.3 >/dev/null 2>&1
}

function install_node {
    curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
    install Node nodejs npm
}

# Unused
function install_postgres {
  install PostgreSQL postgresql postgresql-contrib libpq-dev
  sudo -u postgres createuser --superuser vagrant
  sudo -u postgres createdb -O vagrant databasename # TODO use real db name
}

install 'development tools' build-essential

install_ruby

echo installing Bundler
gem install bundler -N >/dev/null 2>&1

install_node
install Git git
install Redis redis-server
install Vim vim

install 'Nokogiri dependencies' libxml2 libxml2-dev libxslt1-dev

echo "Let's go."
