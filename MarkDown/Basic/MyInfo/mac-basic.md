# Mac

## brew 
```bash
# install
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# uninstall 
sudo ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
```

### 参考
[What is the best/safest way to reinstall Homebrew?](https://stackoverflow.com/questions/11038028/what-is-the-best-safest-way-to-reinstall-homebrew)

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

## 常用软件
```bash
$ brew ls
==> Formulae
ansible		gettext		helm		libevent	mosquitto	pkg-config	sqlite		xz
deno		git		ios-deploy	libuv		openjdk@11	python@3.8	tree
fzf		gnu-sed		kubebuilder	libwebsockets	openssl@1.1	qt		unrar
gdbm		go		kubernetes-cli	libyaml		pcre2		readline	wrk

==> Casks
anaconda		iterm2			vagrant			visual-studio-code
docker			java11			vagrant-manager		vmware-fusion
hbuilder		powershell		virtualbox
```
