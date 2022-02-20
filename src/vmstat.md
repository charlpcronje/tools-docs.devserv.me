# VmStat

Linux VmStat command is used to display statistics of virtual memory, kernel threads, disks, system processes, I/O blocks, interrupts, CPU activity, and much more.

## Install VmStat

By default vmstat command is not available under Linux systems you need to install a package called sysstat (a powerful monitoring tool) that includes a vmstat program.

```sh
sudo yum install sysstat      [On Older CentOS/RHEL & Fedora]
sudo dnf install sysstat      [On CentOS/RHEL/Fedora/Rocky Linux & AlmaLinux]
sudo apt-get install sysstat  [On Debian/Ubuntu & Mint]
sudo pacman -S sysstat        [On Arch Linux]
```

The common usage of vmstat command format is.

```sh
# vmstat

procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 1  0  43008 275212   1152 561208    4   16   100   105   65  113  0  1 96  3  0
```
