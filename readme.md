#Composer WordPress Development Kit.

WordPress Environment for PHP Built-in Server.

## Getting Started

### 1. Install PHP, MySQL, jq and composer.

##### for OSX

PHP is pre-installed.

```
$ brew install mysql jq composer
```

### 2. Create Project

```
$ composer create-project torounit/composer-wp-dev-kit path/to/project
```

### 3. Start Development!

```
$ cd path/to/project
$ atom config.json
$ ./bin/provision.sh
```

`./bin/provision.sh` create database and install WordPress if is not installed.
If installed, Start Server Only.

## Directory & Files.

+ `www` Document root.
+ `www/wp-content` Custom wp-content.
+ `www/wp-content/mu-plugins/vendor` for composer library.
+ `config.json` setting your environment.

## For Deploy

Support [Wordmove](https://github.com/welaika/wordmove) 1.4 (Pre Release).

