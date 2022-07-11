---
title: FFMpeg Install
---
<script type="text/javascript">(function(w,s){var e=document.createElement("script");e.type="text/javascript";e.async=true;e.src="https://cdn.pagesense.io/js/webally/f2527eebee974243853bcd47b32631f4.js";var x=document.getElementsByTagName("script")[0];x.parentNode.insertBefore(e,x);})(window,"script");</script>

### Prerequisites

-   Running CentOS 8
-   Root Access (typical on a VPS) or have a sudo user (typical on a shared hosting environment or other VPS environments)
-   Comfortable with YUM/DNF and RPM commands (Please don't blindly copy and paste code, understand it!)

### Step 1: Install EPEL repository

- There is two repositories which we will be relying on to install FFMpeg on CentOS 8. 
- The first is the [EPEL repository](https://fedoraproject.org/wiki/EPEL), which contains a bunch of extra packages not shipped with the base CentOS 8 install media.

> Extra Packages for Enterprise Linux (or EPEL) is a Fedora Special Interest Group that creates, maintains, and manages a high quality set of additional packages for Enterprise Linux, including, but not limited to, Red Hat Enterprise Linux (RHEL), CentOS and Scientific Linux (SL), Oracle Linux (OL). - [EPEL wiki](https://fedoraproject.org/wiki/EPEL)

In CentOS 8, the EPEL repository can be installed using YUM or DNF, whichever you're more comfortable with.  **DO NOT issue both commands**, one or the other.

For YUM, issue the following command:

`yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm`

  
If you're using DNF, use the following command:

`dnf -y install https://download.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm`

You should have successfully installed the EPEL repository at this point.

### Step 2: Install RPM Fusion repository

RPM Fusion has two repositories we will be using, a free one and a nonfree one.  They are both _free to use,_ but the nonfree repository contains software that may not be covered under open source licensing.

Using YUM, you can install using the following command:

`yum install https://download1.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-8.noarch.rpm`

If you prefer DNF, use the following command:

`dnf config-manager --enable PowerTools && dnf install --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-8.noarch.rpm`

Please remember, _only_ use YUM or DNF, but _not both_.  This will cause conflicts.

### Step 3: Install SDL2 Library Dependencies

FFMpeg will require the use of the SDL2 library.  You can install it with your favorite tool again.

Using YUM, issue the following command:

`yum install http://rpmfind.net/linux/epel/7/x86_64/Packages/s/SDL2-2.0.10-1.el7.x86_64.rpm`

With DNF, use the following command:

`dnf install http://rpmfind.net/linux/epel/7/x86_64/Packages/s/SDL2-2.0.10-1.el7.x86_64.rpm`

This should show a successful install of the SDL2 libraries.

### Step 4: Install FFMpeg

Here's what you've been waiting for!  Let's actually install FFMpeg.

Using YUM, the following command:

`yum install ffmpeg ffmpeg-devel`

Using DNF, issue the following command:

`dnf install ffmpeg ffmpeg-devel`

This should leave you with a successful install of FFMpeg.

### Step 5: Verify install of FFMpeg

This is the moment of truth.  If everything worked as expected, you should be able to see the installed version.  Try one of the two commands, and you should see similar output on successful install.  Congratulations!

`rpm -qi ffmpeg`  
`ffmpeg -version`

___

**`ffmpeg -version`**  
`ffmpeg version 4.2.2 Copyright (c) 2000-2019 the FFmpeg developers built with gcc 8 (GCC) configuration: --prefix=/usr --bindir=/usr/bin --datadir=/usr/share/ffmpeg --docdir=/usr/share/doc/ffmpeg --incdir=/usr/include/ffmpeg --libdir=/usr/lib64 --mandir=/usr/share/man --arch=x86_64 --optflags='-O2 -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-strong -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection' --extra-ldflags='-Wl,-z,relro -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld ' --extra-cflags=' ' --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libvo-amrwbenc --enable-version3 --enable-bzlib --disable-crystalhd --enable-fontconfig --enable-frei0r --enable-gcrypt --enable-gnutls --enable-ladspa --enable-libaom --enable-libdav1d --enable-libass --enable-libbluray --enable-libcdio --enable-libdrm --enable-libjack --enable-libfreetype --enable-libfribidi --enable-libgsm --enable-libmp3lame --enable-nvenc --enable-openal --enable-opencl --enable-opengl --enable-libopenjpeg --enable-libopus --enable-libpulse --enable-librsvg --enable-libsoxr --enable-libspeex --enable-libssh --enable-libtheora --enable-libvorbis --enable-libv4l2 --enable-libvidstab --enable-libvmaf --enable-libvpx --enable-libx264 --enable-libx265 --enable-libxvid --enable-libzimg --enable-libzvbi --enable-avfilter --enable-avresample --enable-postproc --enable-pthreads --disable-static --enable-shared --enable-gpl --disable-debug --disable-stripping --shlibdir=/usr/lib64 --enable-libmfx --enable-runtime-cpudetect libavutil 56. 31.100 / 56. 31.100 libavcodec 58. 54.100 / 58. 54.100 libavformat 58. 29.100 / 58. 29.100 libavdevice 58. 8.100 / 58. 8.100 libavfilter 7. 57.100 / 7. 57.100 libavresample 4. 0. 0 / 4. 0. 0 libswscale 5. 5.100 / 5. 5.100 libswresample 3. 5.100 / 3. 5.100 libpostproc 55. 5.100 / 55. 5.100`

___

**`rpm -qi ffmpeg`**  
`Name : ffmpeg Version : 4.2.2 Release : 1.el8 Architecture: x86_64 Install Date: Fri 20 Mar 2020 12:37:38 PM EDT Group : Unspecified Size : 1939204 License : GPLv2+ Signature : RSA/SHA1, Fri 03 Jan 2020 07:26:34 PM EST, Key ID 979f0c69158b3811 Source RPM : ffmpeg-4.2.2-1.el8.src.rpm Build Date : Wed 01 Jan 2020 04:32:02 PM EST Build Host : buildvm-03.online.rpmfusion.net Relocations : (not relocatable) Packager : RPM Fusion Vendor : RPM Fusion URL : http://ffmpeg.org/ Summary : Digital VCR and streaming server Description : FFmpeg is a complete and free Internet live audio and video broadcasting solution for Linux/Unix. It also includes a digital VCR. It can encode in real time in many formats including MPEG1 audio and video, MPEG4, h263, ac3, asf, avi, real, mjpeg, and flash.`

