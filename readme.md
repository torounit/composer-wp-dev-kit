#Composer WP Environment.

WordPress Environment for PHP Built-in Server.

## Getting Started

### 1. Install MySQL, jq and composer.

```
$ brew install mysql jq composer
```

### 2. Create Project

```
$ composer create-project torounit/composer-wp path/to/project
```

### 3. Start Development!

```
$ cd path/to/project
$ composer server
```

`composer server` create database and install WordPress if is not installed.
If installed, Start Server Only.

## Directory

+ `www` Document root.
+ `www/wp-content` Custom wp-content.
+ `www/wp-content/mu-plugins/vendor` for composer library.

## For Deploy

Support [Wordmove](https://github.com/welaika/wordmove) 1.4 (Pre Release).

