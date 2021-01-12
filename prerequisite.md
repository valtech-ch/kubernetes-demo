# Prerequisites

- Install Docker
- Install Docker Compose
- Install Node.js, NPM, Yarn

## Installation Manual for Windows

### Install WSL2

- Follow the steps to install [WSL2](https://docs.microsoft.com/en-us/windows/wsl/install-win10) on Windows
- Get the Ubuntu distro from the app store

### Install Docker https://docs.docker.com/get-docker/

- Open the Ubuntu Shell and enter

```console
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce
sudo service docker start
```

- Verify docker is up and running

```console
docker run hello-world
```

Note: under WSL you need to start docker service after a reboot manually.

### Install Docker Compose https://docs.docker.com/compose/install/

```console
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

- Verify docker compose is available

```console
docker-compose --version
```

### Install Node.js & NPM https://nodejs.org/en/

```console
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install nodejs
node -v 
```

- Verify node is installed with version > 14

```console
node -v 
```

- install yarn package manager

```console
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn
```

- Verify yarn is installed with version > 1.22

```console
yarn -v 
```
