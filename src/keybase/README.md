# KeyBase  End to end encryption

## Usage

- [Cli - Command Line](cli.md)
- [Linux Commands](linux.md)

Above are only some of the basic commands, view all the keybase docs at: [KeyBase Book](https://book.keybase.io/)

## Install

- [Install on windows](https://keybase.io/docs/the_app/install_windows)
- [Install Mac](https://keybase.io/docs/the_app/install_macos)
- [Install on IPhone](https://apps.apple.com/us/app/keybase-crypto-for-everyone/id1044461770)
- [Install on Linux](https://keybase.io/docs/the_app/install_linux)
- [Install on Android](https://play.google.com/store/apps/details?id=io.keybase.ossifrage&referrer=undefined)

### Install on Linux

#### Stable Releases

=== Ubuntu, Debian, and friends
64-bit

```sh
curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
sudo apt install ./keybase_amd64.deb
run_keybase
```

32-bit

```sh
curl --remote-name https://prerelease.keybase.io/keybase_i386.deb
sudo apt install ./keybase_i386.deb
run_keybase -g # run without GUI; it is not supported on 32-bit Linux
```

!!!
Note: Installing Keybase will add our package repository, so that your system updates will update the Keybase package too. If you want to prevent that, run sudo touch /etc/default/keybase before installing.
!!!

!!!
Note: if your apt version is below 1.1, you won't be able to install the package using the above instructions. Instead, do
!!!

```
# if you see an error about missing `libappindicator1` from the next
# command, you can ignore it, as the subsequent command corrects it
sudo dpkg -i keybase_amd64.deb
sudo apt-get install -f
```
===

=== Fedora, Red Hat

64-bit

```sh
sudo yum install https://prerelease.keybase.io/keybase_amd64.rpm
run_keybase
```

32-bit

```sh
sudo yum install https://prerelease.keybase.io/keybase_i386.rpm
run_keybase -g # run without GUI; it is not supported on 32-bit Linux
Note: Installing Keybase will add our package repository, so that your system updates will update the Keybase package too. If you want to prevent that, run sudo 
touch /etc/default/keybase before installing.
```
===

=== Arch Linux

```sh
yay -S keybase-bin  # or your preferred AUR install method
run_keybase
```

!!!
Note: the community/keybase, community/kbfs, community/keybase-gui packages also exist, but they don't include the run_keybase script.
!!!
===


=== That's it.**

You now have access to Keybase in your GUI and terminal. You also have access to the new Keybase chat and filesystem.

### are you a programmer? some terminal examples

```sh
keybase prove twitter
keybase id chris
keybase help
```

### KBFS examples

```sh
cat /keybase/public/chris/plan.txt
echo "dirty secret" > /keybase/private/yourname/diary.txt
echo "Dear world, check me out." > /keybase/public/yourname/plan.txt
```
===