# unifi_rclone.webdav
Simple Webdav Server for Unifi Dream Machine based on [rclone](https://github.com/rclone/rclone).<br/>
Configurable port and root path and secured with [htpasswd](https://www.google.com/url?sa=t&source=web&rct=j&opi=89978449&url=https://httpd.apache.org/docs/2.4/programs/htpasswd.html&ved=2ahUKEwiSitum4J2JAxWQhf0HHbrRKpMQFnoECAgQAQ&usg=AOvVaw0G0UintjnVsjjMdJHERFxu) for user/pass management.

<h2>Important Notes</h2>
<ul>
<li>Applying changes in UnifiOS of your Unifi Dream Machines (UDM) may lead to loss of warranty.</li>
<li>No liability for damage or malfunctions of your Dream Machine caused by the installation of this utility.</li>
<li>Operating a WebDav Server on your UDM can cause the disk storage to run out of space with corresponding consequences for the stability of the entire system.</li>
<li>The default installation creates a 'webdav' WebDav user with default password 'webdav'. Be aware to change the users/passwords under the htpasswd file especially before opening ports of your firewall.</li>
</ul>
<b>Use it at your own risk!</b>

Successfully tested on UDM Pro v4+ only.

<h2>Installation</h2>
<code>sudo -v ; curl https://raw.githubusercontent.com/emsi76/unifi_rclone.webdav/refs/heads/main/install.sh | sudo bash</code>

<h2>Configuration</h2>

There are 3 config items under 'rclone_webdav.env' with following defaults:

<code>
#Defining the Port of the Webdav Server
RCLONE_WEBDAV_PORT= 55007
#Defining the root folder of the WebDav Server
RCLONE_WEBDAV_ROOT_PATH= /data/rclone/root
#Defining the path of the log file
RCLONE_WEBDAV_LOG_PATH=/data/rclone/log.txt
</code>

Don't forget to add a firewall rule, if you want to access the webdav server from WAN.

<h2>Update</h2>
Same as Installation (config, htpasswd and root folder won't be touched).

<h2>Use (WebDav Client)</h2>
Connect with your preferred WebDav Client to the url/ip of your UDM using the configured port (defaults: 55007)

