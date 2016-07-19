#Composer WordPress Development Kit.

WordPress Environment for PHP Built-in Server.

## Getting Started

### 1. Install PHP, composer, mariaDB ( or MySQL ) and jq, cURL.

##### for OSX

PHP and cURL are pre-installed.

```
$ brew install composer mariadb jq
```


### 2. Create Project

```
$ composer create-project torounit/composer-wp-dev-kit path/to/project
```

### 3. Start Development!

```
$ cd path/to/project
$ vi local-config.json
$ mysql.server start
$ composer provision
$ bash ./bin/server.sh
```

`./bin/provision.sh` create database and install WordPress if is not installed.
If installed, Start Server Only.

### 4. For Production.

Create and Edit config.php.

```
$ composer create-production-config
$ vi config.php
```

## Directory & Files.

+ `.` Document root.
+ `./wp` WordPress core files.
+ `./wp-content` Custom wp-content.
+ `./wp-content/mu-plugins/vendor` for composer library.
+ `local-config.json` setting your environment.

## Commands

* `composer provision` Provisioning WordPress.
* `./bin/server.sh` Start `wp server` and open browser.
* `composer import-theme-unit-test` Import theme unit test data.
* `composer create-production-config` create config.php

## Other

* Support [Wordmove](https://github.com/welaika/wordmove).

