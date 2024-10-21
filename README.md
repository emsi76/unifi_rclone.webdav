# unifi_rclone.webdav
<p>
Simple <a href="http://www.webdav.org">Webdav</a> Server for Unifi Dream Machine (UDM) based on <a href="https://github.com/rclone/rclone">[rclone]</a>.<br/>
Configurable port and root path and secured with <a href="https://httpd.apache.org/docs/2.4/programs/htpasswd.html">[htpasswd]</a> for user/pass management as well as https using the certs of the UDM.<br/>
Easy inbstallation and configuration should not take more than some minutes! :-)  
</p>
<p>
  This set of scripts installs rclone as WebDav Server - see <a href="https://rclone.org/commands/rclone_serve_webdav/">[rclone serve webdav]</a>, and set it up as service on your UDM.
</p>
<h2>Important Notes</h2>
<p>
  <ul>
  <li>Applying changes in UnifiOS of your Unifi Dream Machines (UDM) may lead to loss of warranty.</li>
  <li>No liability for damage or malfunctions of your Dream Machine caused by the installation of this utility.</li>
  <li>Operating a WebDav Server on your UDM and so letting users uploading (big) files can cause the disk storage to run out of space with corresponding consequences for the stability of the entire system.</li>
  <li>The default installation creates a 'webdav' WebDav user with default password 'webdav'. Be aware to change the users/passwords under the htpasswd file especially before opening ports of your firewall.</li>
  <li>Upgrading your Dream Machine firmware typically requires to install again.</li>
  <li>WebDav data under the root folder currently is persitent after reboot or even firmware update. But future upgrades could lead to data loss depending on what unifi is changing in the UnifiOS (for critical WebDav data: please backup root folder before update).</li>
  </ul>
</p>
<p>
<b>*** Use it at your own risk! ***</b>
</p>
<p>
Successfully tested on (only one device so far due to lack of hardware):
</p>
<p>
  <table border=1 cellspacing=10>
  <tr>
  <td>Family: UniFi Dream Machine (UDM)</td>
  <td>Model: UniFi Dream Machine Pro (UDM-Pro)</td>
  <td>Firmware: 4.0.21 (4.0.21)</td>
  </tr>
  </table>
</p>
<h2>Installation</h2>
SSH into your UDM and enter:</br>
<code>sudo -v ; curl https://raw.githubusercontent.com/emsi76/unifi_rclone.webdav/refs/heads/main/install.sh | sudo bash</code>

<h2>Configuration</h2>
2-Step quick config:<br/>&nbsp;<br/>
<ol>
  <li>
    Environment parameters
    <p>
      there are 3 config items under 'rclone_webdav.env' with following defaults:<br/>
      <code>
      # Defining the Port of the Webdav Server
      RCLONE_WEBDAV_PORT= 55007
      # Defining the root folder of the WebDav Server
      RCLONE_WEBDAV_ROOT_PATH= /data/rclone/root
      # Defining the path of the log file
      RCLONE_WEBDAV_LOG_PATH=/data/rclone/log.txt
      </code>
    </p>
    <p>
      To make your changes effective just run the installation commmand again (see above)!
    </p>
  </li>
  <li>
    User Management
    <p>
      Basic user managment can be done via htpasswd file in '/data/rclone' folder.
      Default  WebDav user is 'webdav' with default password 'webdav'.
      Please generate your own user/pass to add via e.g.:<br/>
      <a href="https://htpasswdgenerator.de">htpasswd generator</a>
    </p>
  </li>
</ol> 
Don't forget to add a firewall rule, if you want to access the webdav server from WAN.

<h2>Update</h2>
Same as Installation (existing config, htpasswd and root folder won't be touched, remove then manually if you want fresh one).
  
<h2>Use (WebDav Client)</h2>
Connect with your preferred WebDav Client via https to the url/ip of your UDM using the configured port (defaults: 55007).
Depending on the ssl certs you are using on your UDM you will have to trust the cert.

<h2>Uninstallation</h2>
currently manual uninstall only<br/>
<code>
# Disable rclone_webdav.service from running at boot
sudo systemctl disable rclone_webdav.service
sudo systemctl daemon-reload
# Delete any rclone_webdav.service related data
rm -rf /data/rclone
rm -f /etc/systemd/system/rclone_webdav.*
</code>

If you defined an own WebDav root folder, then also remove.
<h2>Thanks</h2>
<ul>
<li>to <a href="ui.com">Unifi</a> for the great hardware/firmware accessible via ssh/bash</li>
<li>to <a href="https://github.com/rclone/rclone">rclone</a> for the webdav server software which this utility is based on</li>
<li>to <a href="https://github.com/alxwolf/ubios-cert">ubios-cert</a> making it even possible to run the webdav server with https and let's encrypt certs</li>
</ul>
