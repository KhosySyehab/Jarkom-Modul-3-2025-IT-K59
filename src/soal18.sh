apt update
apt install -y mariadb-server

# secure install (interactive) OR set root pwless for lab
# edit /etc/mysql/mariadb.conf.d/50-server.cnf -> bind-address = 0.0.0.0
sed -i "s/^bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf
systemctl restart mariadb

# create replication user
mysql -u root <<SQL
CREATE USER 'repl'@'%' IDENTIFIED BY 'replpass';
GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%';
FLUSH PRIVILEGES;
FLUSH TABLES WITH READ LOCK;
SHOW MASTER STATUS\G
-- NOTE: copy File & Position from output (e.g. mysql-bin.000001 & position 154)
UNLOCK TABLES;
SQL

apt update
apt install -y mariadb-server
# configure mysql to allow replication:
sed -i "s/^bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf
systemctl restart mariadb

mysql -u root <<SQL
CHANGE MASTER TO
  MASTER_HOST='10.93.1.30',
  MASTER_USER='repl',
  MASTER_PASSWORD='replpass',
  MASTER_LOG_FILE='mysql-bin.000001',   # replace with master's File
  MASTER_LOG_POS=154;                   # replace with master's Position
START SLAVE;
SHOW SLAVE STATUS\G
SQL


CREATE DATABASE test_rep;
USE test_rep;
CREATE TABLE t1 (id INT PRIMARY KEY AUTO_INCREMENT, msg VARCHAR(100));
INSERT INTO t1 (msg) VALUES ('hello');
