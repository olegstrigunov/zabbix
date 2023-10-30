zabbix

sudo apt install postgresql postgresql-contrib

wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-4+ubuntu22.04_all.deb
sudo dpkg -i zabbix-release_6.0-4+ubuntu22.04_all.deb
sudo apt update


Установите Zabbix сервер, веб-интерфейс и агент

sudo apt install zabbix-server-pgsql zabbix-frontend-php php8.1-pgsql zabbix-nginx-conf zabbix-sql-scripts zabbix-agent

Установите и запустите сервер базы данных.

Выполните следующие комманды на хосте, где будет распологаться база данных.
sudo -u postgres createuser --pwprompt zabbix
sudo -u postgres createdb -O zabbix zabbix

На хосте Zabbix сервера импортируйте начальную схему и данные. Вам будет предложено ввести недавно созданный пароль.
zcat /usr/share/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix

Отредактируйте файл 
sudo nano /etc/zabbix/zabbix_server.conf
DBPassword=password

Отредактируйте файл /etc/zabbix/nginx.conf раскомментируйте и настройте директивы 'listen' и 'server_name'.
sudo nano /etc/zabbix/nginx.conf
listen 8080;
server_name example.com;

Запустите процессы Zabbix сервера и агента и настройте их запуск при загрузке ОС.
sudo systemctl restart zabbix-server zabbix-agent nginx php8.1-fpm
sudo systemctl enable zabbix-server zabbix-agent nginx php8.1-fpm

