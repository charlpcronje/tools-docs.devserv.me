---
title: 3 handy command-line internet speed tests
---
<script type="text/javascript">(function(w,s){var e=document.createElement("script");e.type="text/javascript";e.async=true;e.src="https://cdn.pagesense.io/js/webally/f2527eebee974243853bcd47b32631f4.js";var x=document.getElementsByTagName("script")[0];x.parentNode.insertBefore(e,x);})(window,"script");</script>

## Speedtest

- Speedtest is an old favorite. It's implemented in Python, packaged in Apt, and also available with pip. You can use it as a command-line tool or within a Python script.

Install it with:

```sh
sudo apt install speedtest-cli
or

sudo pip3 install speedtest-cli
```

Then run it with the command speedtest:

```sh
speedtest
Retrieving speedtest.net configuration...
Testing from CenturyLink (65.128.194.58)...
Retrieving speedtest.net server list...
Selecting best server based on ping...
Hosted by CenturyLink (Cambridge, UK) [20.49 km]: 31.566 ms
Testing download speed................................................................................
Download: 68.62 Mbit/s
Testing upload speed......................................................................................................
Upload: 10.93 Mbit/s
```

This gives you your download and upload Internet speeds. It's fast and scriptable, so you can run it regularly and save the output to a file or database for a record of your network speed over time.

## Fast

Fast is a service provided by Netflix. Its web interface is located at Fast.com, and it has a command-line interface available through npm:

```sh
npm install --global fast-cli
````

Both the website and `command-line` utility provide the same basic interface: it's a simple-as-possible speed test:

```sh
fast

# 82 Mbps ↓
```

The command returns your Internet download speed. To get your upload speed, use the -u flag:

```sh
fast -u

# 80 Mbps ↓ / 8.2 Mbps ↑
```

## iPerf

iPerf is a great way to test your LAN speed (rather than your Internet speed, as the two previous tools do). Debian, Raspbian, and Ubuntu users can install it with apt:

```sh
sudo apt install iperf
```

It's also available for Mac and Windows.

Once it's installed, you need two machines on the same network to use it (both must have iPerf installed). Designate one as the server.

Obtain the IP address of the server machine:

```sh
ip addr show | grep inet.*brd
```

Your local IP address (assuming an IPv4 local network) starts with either 192.168 or 10. Take note of the IP address so you can use it on the other machine (the one designated as the client).

Start iperf on the server:

```sh
iperf -s
```

This waits for incoming connections from clients. Designate another machine as a client and run this command, substituting the IP address of your server machine for the sample one here:

```sh
iperf -c 192.168.1.2
iperf.png
iPerf
```

It only takes a few seconds to do a test, and it returns the transfer size and calculated bandwidth. I ran a few tests from my PC and my laptop, using my home server as the server machine. I recently put in Cat6 Ethernet around my house, so I get up to 1Gbps speeds from my wired connections but much lower speeds on WiFi connections.

```sh
iperf2.png
iPerf
```

­You may notice where it recorded 16Gbps. That was me using the server to test itself, so it's just testing how fast it can write to its own disk. The server has hard disk drives, which are only 16Gbps, but my desktop PC gets 46Gbps, and my (newer) laptop gets over 60Gbps, as they have solid-state drives.

```sh
iperf3.png
iPerf
```