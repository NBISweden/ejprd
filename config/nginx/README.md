- `nginx.conf` should be copied/linked to `/etc/nginx/sites-available`
- when updated, run
  -  `sudo nginx -t` to verify that the config is ok
  -  `sudo certbot --nginx` if any new domain names (`*.ejprd.nbis.se`) have been added
  -  `sudo /etc/init.d/nginx reload` to load the new configuration

- `overview.html` should be copied to `/var/www/html`
