# crontab -e
# 00 23 * * * backup.sh

# Ниже, непосредственно, содержимое скрипта.
if [ ! -f /home/$USER/backup ]; then
    mkdir backup
fi

now=$(date +"%m_%d_%Y")
sudo -u postgres -i pg_dump taxi > /home/$USER/backup/$now.sql
exit