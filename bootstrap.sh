#!/usr/bin/env bash
#!/

ANDROID_SDK_FILENAME=tools_r25.2.3-linux.zip
ANDROID_SDK=https://dl.google.com/android/repository/$ANDROID_SDK_FILENAME

#sudo apt-get install python-software-properties
sudo add-apt-repository ppa:openjdk-r/ppa
curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
apt-get update && apt-get -y upgrade
apt-get install -y nodejs unzip git openjdk-8-jre ant expect lib32z1 lib32ncurses5 lib32bz2-1.0

curl -O $ANDROID_SDK
mkdir android-sdk-linux/
sudo unzip $ANDROID_SDK_FILENAME -d android-sdk-linux/
sudo chown -R vagrant android-sdk-linux/

echo "ANDROID_HOME=~/android-sdk-linux" >> /home/vagrant/.bashrc
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-i386" >> /home/vagrant/.bashrc
echo "PATH=\$PATH:~/android-sdk-linux/tools:~/android-sdk-linux/platform-tools" >> /home/vagrant/.bashrc

sudo npm install -g ionic cordova

expect -c '
set timeout -1   ;
spawn /home/vagrant/android-sdk-linux/tools/android update sdk -u --all --filter platform-tool,android-22,build-tools-22.0.1
expect {
    "Do you accept the license" { exp_send "y\r" ; exp_continue }
    eof
}
'

#sudo gem install sass
