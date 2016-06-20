#Composer WordPress Development Kit.

WordPress Environment for PHP Built-in Server.

## Getting Started

### 1. Install PHP, composer, MySQL and jq.

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
$ vi local-config.json
$ ./bin/provision.sh
```

`./bin/provision.sh` create database and install WordPress if is not installed.
If installed, Start Server Only.

### 4. For Production.

Create and Edit config.php.

```
$ cp config-sample.php config.php
$ vi config.php
```

## Directory & Files.

+ `.` Document root.
+ `./wp` WordPress core files.
+ `./wp-content` Custom wp-content.
+ `./wp-content/mu-plugins/vendor` for composer library.
+ `local-config.json` setting your environment.

## For Deploy

Support [Wordmove](https://github.com/welaika/wordmove) 1.4 (Pre Release).

