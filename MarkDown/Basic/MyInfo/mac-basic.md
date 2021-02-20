# Mac

## install brew 
```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### Mac opne option of install anywhere<span id="1"></span>
>commond:
>sudo spctl --master-disable


### iTem
```bash
 brew install cmatrix && cmatrix -a -s
```

### install vagrant
```bash
# install homebrew
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ brew update

# install virtualbox and vagrant
$ brew install virtualbox
$ brew install vagrant

# Create a Vagrant File
$ mkdir ~/vms
# mkdir ~/vms/<project-name>
$ mkdir ~/vms/vagrant-centos-7


# init centos vagrant
$ cd ~/vms/vagrant-centos-7
# load a Vagrant box that you want to use. As an example, we’ll load a CentOS 7 file: （need choose options, use virtualbox ）
$ vagrant box add centos/7
# make a vagrant file in current directory. if vagrant box image hasn`t been downloaded before. then it try to download the vagrant box image.
$ vagrant init centos/7

# You can then launch the CentOS 7 virtual machine by entering:
# vm start
$ vagrant up

# enter vagrant 
$ vagrant ssh

# To stop your virtual machine use the command:
$ vagrant halt





```