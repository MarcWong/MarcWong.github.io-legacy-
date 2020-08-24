---
layout: post
title:  "[备忘] Laravel+Mysql配置"
date:   2017-10-01
excerpt: "Laravel+Mysql配置备忘"
tags: "Laravel, Mysql"
---

# 1.laravel安装

``` bash
composer install
sudo chmod -R 777 storage
sudo chmod -R 777 bootstrap
composer  dump-autoload
```

``` bash
php artisan key:generate
php artisan migrate:refresh //先创建好db，用来第一次建数据库表的，这个命令会清空数据表
```


# 2.mysql 2002错误解决办法

``` bash
unset TMPDIR
bash mysql_install_db --verbose --user=root
--basedir="$(brew --prefix mysql)"--datadir=/usr/local/var/mysql --tmpdir=/tmp
```

``` bash
sudo brew services start mysql
sudo chown -R _mysql /usr/local/var/mysql
sudo chmod -R o+rwx /usr/local/var/mysql
```