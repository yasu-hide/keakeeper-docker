<span style="font-size: 300%; color: red;">実験用</span>

# keakeeper-docker
Kea DHCP & KeaKeeper

ISC-DHCP後継の[Kea DHCP](https://www.isc.org/kea/)と、(株)デージーネットが無償公開しているWebインターフェース [KeaKeeper](https://www.designet.co.jp/info/?id=213)をDockerイメージにしました。

## 使い方
0. リポジトリをクローンする
1. ビルドする
2. セットアップスクリプトを実行する
3. Enjoy!

### 0. リポジトリをクローンする
```bash
$ git clone https://github.com/yasu-hide/keakeeper-docker.git
```

### 1. ビルドする
```bash
$ cd keakeeper-docker
$ docker-compose build
```

### 2. セットアップスクリプトを実行する
```bash
$ ./setup.sh
```
<details>
<summary>実行中の様子</summary>

```
Creating network "keakeeper_default" with the default driver
Creating volume "keakeeper_kea-config" with default driver
Creating volume "keakeeper_kea-data" with default driver
Creating keakeeper_mariadb_1 ... done
Create database kea
Checking if there is a database initialized already. Please ignore errors.
Verifying create permissions for keauser
MySQL Version is:
Initializing database using script /usr/share/kea/scripts/mysql/dhcpdb_create.mysql
mysql returned status code 0
Database version reported after initialization: 9.1
```
- 途中で `mysql_secure_installation` が実行されるので対話する
```
NOTE: RUNNING ALL PARTS OF THIS SCRIPT IS RECOMMENDED FOR ALL MariaDB
      SERVERS IN PRODUCTION USE!  PLEASE READ EACH STEP CAREFULLY!

In order to log into MariaDB to secure it, we'll need the current
password for the root user. If you've just installed MariaDB, and
haven't set the root password yet, you should just press enter here.

Enter current password for root (enter for none):
OK, successfully used password, moving on...

Setting the root password or using the unix_socket ensures that nobody
can log into the MariaDB root user without the proper authorisation.

You already have your root account protected, so you can safely answer 'n'.

Switch to unix_socket authentication [Y/n] n
 ... skipping.

You already have your root account protected, so you can safely answer 'n'.

Change the root password? [Y/n] n
 ... skipping.

By default, a MariaDB installation has an anonymous user, allowing anyone
to log into MariaDB without having to have a user account created for
them.  This is intended only for testing, and to make the installation
go a bit smoother.  You should remove them before moving into a
production environment.

Remove anonymous users? [Y/n]
 ... Success!

Normally, root should only be allowed to connect from 'localhost'.  This
ensures that someone cannot guess at the root password from the network.

Disallow root login remotely? [Y/n]
 ... Success!

By default, MariaDB comes with a database named 'test' that anyone can
access.  This is also intended only for testing, and should be removed
before moving into a production environment.

Remove test database and access to it? [Y/n]
 - Dropping test database...
 ... Success!
 - Removing privileges on test database...
 ... Success!

Reloading the privilege tables will ensure that all changes made so far
will take effect immediately.

Reload privilege tables now? [Y/n]
 ... Success!

Cleaning up...

All done!  If you've completed all of the above steps, your MariaDB
installation should now be secure.

Thanks for using MariaDB!
Stopping keakeeper_mariadb_1 ... done
Removing keakeeper_mariadb_1 ... done
Removing network keakeeper_default
Creating network "keakeeper_default" with the default driver
Creating keakeeper_mariadb_1 ... done
Creating keakeeper_keactrlagent_1 ... done
Creating keakeeper_keadhcp6_1     ... done
Creating keakeeper_keadhcp4_1     ... done
Creating keakeeper_keaphpfpm_1    ... done
Creating keakeeper_keahttpd_1     ... done
Stopping keakeeper_keahttpd_1     ... done
Stopping keakeeper_keaphpfpm_1    ... done
Stopping keakeeper_keadhcp4_1     ... done
Stopping keakeeper_keadhcp6_1     ... done
Stopping keakeeper_keactrlagent_1 ... done
Stopping keakeeper_mariadb_1      ... done
Removing keakeeper_keahttpd_1     ... done
Removing keakeeper_keaphpfpm_1    ... done
Removing keakeeper_keadhcp4_1     ... done
Removing keakeeper_keadhcp6_1     ... done
Removing keakeeper_keactrlagent_1 ... done
Removing keakeeper_mariadb_1      ... done
Removing network keakeeper_default
Creating network "keakeeper_default" with the default driver
Creating keakeeper_mariadb_1 ... done
Creating keakeeper_keactrlagent_1 ... done
Creating keakeeper_keadhcp6_1     ... done
Creating keakeeper_keadhcp4_1     ... done
Creating keakeeper_keaphpfpm_1    ... done
Creating keakeeper_keahttpd_1     ... done
```

</details>

### 3. Enjoy!
![image](https://user-images.githubusercontent.com/5038337/87440437-f042ed00-c62c-11ea-8bdd-c2aa30420e38.png)
