# unifi_rclone.webdav
Simple Webdav Server for Unifi Dream Machine based on [RClone](https://github.com/rclone/rclone)

<h2>Important Notes</h2>
<ul>
<li>Applying changes in UnifiOS of your Unifi Dream Machines (UDM) may lead to loss of warranty.</li>
<li>No liability for damage or malfunctions of your Dream Machine caused by the installation of this utility.</li>
<li>Operating a WebDav Server on your UDM can cause the disk storage to run out of space with corresponding consequences for the stability of the entire system.</li>
<li>The default installation creates a 'webdav' WebDav user with default password 'webdav'. Be aware to change the users/passwords under the htpasswd file especially before opening ports of your firewall.</li>
</ul>
Use it at your own risk

Successfully tested on UDM Pro v4+ only.

<h2>Installation</h2>
<code>sudo -v ; curl https://raw.githubusercontent.com/emsi76/unifi_rclone.webdav/refs/heads/main/install.sh | sudo bash</code>

<h2>Configuration</h2>




