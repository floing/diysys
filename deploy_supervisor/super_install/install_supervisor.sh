pip install --user supervisor
mkdir -p ~/.local/etc/supervisor.d
cp supervisord.conf ~/.local/etc/
supervisord -c ~/.local/etc/supervisord.conf 
cp wifi_rec_online.ini ~/.local/etc/supervisor.d/
cd /data/sitereconline/wifi_rec_online/admin && sh stop.sh
supervisorctl  update
