# Ice Coder

## Awesome Features

- ICEcoder comes packed with a load of features, some you'd expect and some new things you've likely not seen before.
- It's always evolving so ensure you check back to grab the latest version.

## Installation

### Composer

Composer typically installs packages into the vendor dir, but of course ICEcoder is an app you want to see in the browser and not just a library. So you'll need to not only require the package but also move it into your wwwroot (document root) dir afterwards.

Below is the recommended items to add into your `composer.json` file to achieve this automatically.

```json
{
  "require": {
    "icecoder/icecoder": "*"
  },
  "scripts" : {
    "post-autoload-dump": [
      "cp -r vendor/icecoder/icecoder ICEcoder"
    ]
  },
  "minimum-stability": "dev",
  "prefer-stable": true
}
```

Now if you run:

```sh
composer install
```

...it will download ICEcoder and after installations are complete, move it to the root of your project.

You'll need to ensure both the ICEcoder dir and the wwwroot dir have permissions to read, write and execute. This can be done by changing permissions (using chmod), but it it safer and so better, to use chown

```sh
chown -R www-data.www-data /var/www/html
```

This will recursively set the www-data user as both the owner and group users for files on the `/var/www/html` dir (which ICEcoder dir is of course inside of, at say `/var/www/html/ICEcoder`).

Now you can visit `yoursite.com/ICEcoder` to view ICEcoder, sign in and start coding!

Tip: If using ICEcoder locally, you can use:

```sh
php -S localhost:8080
```

...to get PHP to start a simple web server. You can then visit `localhost:8080/ICEcoder`

## docker

Save the content below as a Dockerfile.

```sh
FROM php:7.4.10-apache

MAINTAINER ICEcoder <info@icecoder.net>

ENV DEBIAN_FRONTEND noninteractive

RUN a2enmod rewrite
RUN a2enmod ssl
RUN service apache2 restart

RUN apt-get update && \
apt-get install unzip -y && \
apt-get clean all && \
curl -o /icecoder.zip 'https://downloads.icecoder.net/ICEcoder-8.1.zip' && \
unzip -q /icecoder.zip -d /tmp/ && \
cp -r /tmp/ICE* /var/www/html/icecoder && \
echo "<!DOCTYPE html>\n<html>\n<head>\n<title>Welcome to your new site</title>\n</head>\n<body style=\"text-align: center; font-family: monospace\">\n<h1>Welcome!</h1>\n<p>Head to ICEcoder at <a href=\"/icecoder\">localhost:8080/icecoder</a> to create a password and start coding!</p>\n</body>\n</html>" > /var/www/html/index.php && \
chown -R www-data.www-data /var/www/html && \
chmod 755 /var/www/html && \
rm -rf /icecoder.zip /tmp/ICE*
```

Build using:

```sh
docker build -t icecoder/docker .
```

Then run using:

```sh
docker run -p 8080:80 icecoder/docker
```

Then you can visit `http://localhost:8080` to see the index.php welcome page.

Go to `http://localhost:8080/icecoder` to see ICEcoder, create a password and begin coding!

### Notes

This is a single container, which incudes PHP 7.4.10, Apache, ICEcoder and a test index.php page. It doesn't include MySQL or any additional services, as those should be ran in a seperate docker container.

This container is ideal for local development and you would need to do more for a production ready Docker container, such as TLS and more.

#### Via Zip

Unzip the file into your wwwroot (document root) dir for your website (this is typically `/var/www/html/`).

#### Via git clone

Clone the repo into your wwwroot (document root) dir for your website (this is typically `/var/www/html/`) via:

```sh
git clone git@github.com:icecoder/icecoder /var/www/html/icecoder
```

...then...

You'll need to ensure both the ICEcoder dir and the wwwroot dir have permissions to read, write and execute. This can be done by changing permissions (using chmod), but it it safer and so better, to use chown:

```sh
chown -R www-data.www-data /var/www/html
```

This will recursively set the www-data user as both the owner and group users for files on the `/var/www/html` dir (which ICEcoder dir is of course inside of, at say `/var/www/html/ICEcoder`).

Now you can visit `yoursite.com/ICEcoder` to view ICEcoder, sign in and start coding!

Tip: If using ICEcoder locally, you can use:

```sh
php -S localhost:8080
```

File type: ZIP

File name: [ICEcoder-Desktop-v0.2.zip](https://icecoder.net/download-desktop-zip)

Status: Experimental

#### Setup

Unzip the file into a test environment.

Double click the `ICEcoder.exe` file to view ICEcoder, sign in and start coding!

### Bash

#### Setup Zip

Below is sample shell script to download and unzip from the last stable zip:

```sh
cd /var/www/html
wget https://downloads.icecoder.net/ICEcoder-8.1.zip -O ICEcoder.zip
unzip ICEcoder.zip
rm ICEcoder.zip
mv ICEcoder* ICEcoder
```

You'll need to ensure both the ICEcoder dir and the wwwroot dir have permissions to read, write and execute. This can be done by changing permissions (using chmod), but it it safer and so better, to use chown:

```sh
chown -R www-data.www-data /var/www/html
```

This will recursively set the www-data user as both the owner and group users for files on the /var/www/html dir (which ICEcoder dir is of course inside of, at say /var/www/html/ICEcoder).

Now you can visit `yoursite.com/ICEcoder` to view ICEcoder, sign in and start coding!

Tip: If using ICEcoder locally, you can use:

```sh
php -S localhost:8080
```

...to get PHP to start a simple web server. You can then visit `localhost:8080/ICEcoder`

### GIT

Clone the repo into your wwwroot (document root) dir for your website (this is typically `/var/www/html/`) via:

```sh
git clone git@github.com:icecoder/icecoder /var/www/html/icecoder
```

...then...

You'll need to ensure both the ICEcoder dir and the wwwroot dir have permissions to read, write and execute. This can be done by changing permissions (using chmod), but it it safer and so better, to use chown:

```sh
chown -R www-data.www-data /var/www/html
```

This will recursively set the www-data user as both the owner and group users for files on the `/var/www/html` dir (which ICEcoder dir is of course inside of, at say `/var/www/html/ICEcoder`).

Now you can visit yoursite.com/ICEcoder to view ICEcoder, sign in and start coding!

Tip: If using ICEcoder locally, you can use:

```sh
php -S localhost:8080
```

...to get PHP to start a simple web server. You can then visit `localhost:8080/ICEcoder`

### The Basics

- Context aware code highlighting
- Desktop like file manager
- Document tabs indicate current doc & changes made
- Code folding
- Bracket Matching
- Browser based, can run online or offline
- Use ICEcoder anywhere - wwwroot, iFrame or any sub/dir/path
- Welcome tour on arrival

### Language Support

- HTML, CSS, LESS, JavaScript, CoffeeScript, PHP, Ruby, Python & many more!
- Easy to support over 60 other languages

### Useful Feedback

- Found match & current position counter
- Indicates content type cursor is on
- Colour preview block on CSS colours, ie red, #f00 or RGBA(255,0,0,0.5)
- Live bug reporting system
- Tests requirements and displays issues in page

### Time Savers

- Live editing
- Multiple selections
- Smart tab key system (selected lines are auto-indented)
- Open last files on load
- Code Assist system
- Prettier code on save
- Go to line number as you type in goto line input box, Enter to focus
- Adds end tags as you type and in a context aware way
- Arguments display on functions & classes
- Diff pane with insert, changed and removed lines highlighted
- Autocloses brackets and quotes as you type
- Tabs linked to files so they update and close intelligently
- ESC = Comment/Uncomment line, incl partial lines
- CTRL+click = Jump to a functions declaration
- CTRL+Backspace = Jump back to previously selected tab
- HTML & JavaScript code hinting
- Tag wrappers
- File uploader, plus supports multiple files
- Jump to definition shortcut
- Simultaneous tag editing
- Tool link alerting according to state

### Secure

- Account login to help keep online files secure
- Multi domain config settings
- Restrict files, ban files and restrict by IP
- Multi user, dev and demo modes
- Password encryption with Bcrypt
- Strong password rules (10 chars, uppercase, lowercase, number and special)

### Customisable

- Settings to change behaviour, functionality & style
- Control multiple users and registration
- Plugin manager
- Template based config files
- Add your own custom processes in JS or PHP
- Output whatever you wish to the output pane, such as a result after processing

### Groundbreaking Features

- Find & replace builder to apply to current doc, open docs, files & filenames
- Find by plain text or regex, includes regex format validation
- Highlight word and press CTRL+I to Google search that
- DOM element highlighting with the Pestcide plugin
- Can rename open files (whoaah!)
- CTRL+Enter open current webpage in new tab
- Code Zooming - hold F1 key to "zoom out" all non class or function lines
- Version control system to backup upon save and allows easy restore
- Terminal, database and Git management built in
- Sass and LESS compiling on save plugins
- Intelligently indexes classes & functions routinely every 3 secs
- Git diff highlighting in gutter
- Image viewer with hex & RGB eyedropper
- Alphanumeric tab sorting
- Farbtastic color picker integrated
- Open remote file content
- Plus lots of other great features. The best way to test all of this out is to of course download ICEcoder...

## Tips/Tricks

ICEcoder is easy to pick up the basics of. However, there's so much more to it than basic usage and you can find plenty of hidden gems to make your coding life easier.

Here we've detailed some of our favorites so you may master ICEcoder usage...

### Shortcut magic

- Use `CTRL/Cmd + Alt + left/right` keys to jump between file manager and editor panes
- When focused on the file manager, use the `up/down/left/right` arrow keys to navigate and Enter to open
- `CTRL/Cmd+` to collapse/expand the file manager
- `CTRL+Backspace` to jump back to previous tab

### File trickery

- Drag and drop `files/dirs` from the file manager into the editor to paste in the file path. Plus, `hold CTRL/Cmd` before releasing to paste an absolute path
- Double click an image to display it, hover over it to reveal an h`ex/RGB` eyedropper
- Drag and drop files into dirs, holding CTRL/Cmd before releasing will copy them into that dir
- Rename an open file and the tab name will change, or delete an open file and the tab closes ...no more getting out of sync
- Middle click tabs to close them
- Double click a tab to expand/collapse file manager
- Click the number of backups to bottom left of editor to get to version control and restore old versions
