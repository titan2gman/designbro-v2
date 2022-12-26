# Configuring the environment

## Install Gems and Cookbooks

```bash
$ bundle install
$ berks install
```

## Create Encrypted Data Bag Secret file

**ATTENTION!** You need to create this file **ONLY** if you don't have it.

```bash
$ openssl rand -base64 512 | tr -d '\r\n' > encrypted_data_bag_secret
```

## Setup Node

When you setting up the server at the first time you need to execute the folowing command:

```bash
$ knife solo bootstrap ubuntu@192.168.33.10
```

> `ubuntu` - Default system user (for example it may be a user `root`).

In all other cases you should execute this command with user `deployer`:

```bash
$ knife solo cook deployer@192.168.33.10
```

> `192.168.33.10` - IP address of Node (in `nodes` directory).  In this case this is the address of the development server.

## Deployment

```bash
knife solo cook deployer@192.168.33.10 -o "'recipe[rg-deploy]'"
```

The option `-o` overrides run-list which defined in Node and runs only recipe `rg-deploy`.

## Edit Data Bags

```bash
$ knife solo data bag edit configs dev
$ knife solo data bag edit configs staging
$ knife solo data bag edit configs production
```

## Show Data Bags

```bash
$ knife solo data bag show configs dev
$ knife solo data bag show configs staging
$ knife solo data bag show configs production
```

# Testing

## Create local test Node

Install Vagrant and VirtualBox

```bash
$ brew cask install vagrant virtualbox
$ vagrant plugin install vagrant-vbguest
```

Go to the `vagrant` directory and start Vagrant:

```bash
$ vagrant up
```

To shutdown or destroy the server, run one of these commands:

```bash
$ vagrant halt
$ vagrant destroy
```
