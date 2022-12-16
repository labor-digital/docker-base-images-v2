set_permissions(){
		chown -R www-data.www-data /var/www
		chmod -R u=rX,g=rX,o-rwx /var/www/html
		chmod -R u=rwX,g=rwX,o-rwx /var/www/html_data /var/www/logs
		source /opt/permissions.sh
		echo "Permissions were updated"
}