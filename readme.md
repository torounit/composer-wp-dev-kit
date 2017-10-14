# Composer WordPress Development Kit.

WordPress Environment for PHP Built-in Server.

## Getting Started

### 1. Install PHP, composer, WP-CLI, mariaDB ( or MySQL ) and jq, cURL.

##### for OSX

PHP and cURL are pre-installed.

```
$ brew install composer wp-cli mariadb jq 
```


### 2. Create Project

```
$ composer create-project torounit/composer-wp-dev-kit path/to/project
```

### 3. Start Development!

```
$ cd path/to/project
$ composer create-env
$ vi .env.json
$ mysql.server start
$ composer provision
```

`./bin/provision.sh` create database and install WordPress if is not installed.

#### Start WordPress!

```
$ composer server
```

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
+ `.env.json` setting your environment.

## Commands

* `composer provision` Provisioning WordPress.
* `composer server` Start `wp server` and open browser.
* `composer import-theme-unit-test` Import theme unit test data.
* `composer create-env` create .env.json
* `composer create-production-config` create config.php


