# unifi_rclone.webdav
<p style="font-size:larger">
Transform your Unifi gateway to a NAS with this simple <a href="http://www.webdav.org">Webdav</a> Server for Unifi Dream Machine (UDM) based on <a href="https://github.com/rclone/rclone">rclone</a>.
</p>
<p>
<ul>
  <li>Configurable port and root path - which can also be configured to your disk (hdd/sdd)</li>
  <li>User/pass management with <a href="https://httpd.apache.org/docs/2.4/programs/htpasswd.html">htpasswd</a></li>
  <li>Secured with https using the certs of the UDM</li>
  <li>Http(s) basic auth additionally hardened to ban users with more than x failed logins</li>
</ul>
</p>
<p>
Easy 3 step <a href="https://github.com/emsi76/unifi_rclone.webdav/blob/main/README.md#installation">installation</a> and <a href="https://github.com/emsi76/unifi_rclone.webdav#configuration">configuration</a> should not take more than some minutes! :-)  
</p>
<p>
  This set of scripts installs rclone as WebDav Server - see <a href="https://rclone.org/commands/rclone_serve_webdav/">rclone serve webdav</a> and set it up as service on your UDM as well as a second service to ban users with more than x failed logins in current hour.
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
  <td><ul><li>Firmware: 4.0.20 (4.0.20)</li><li>Firmware: 4.0.21 (4.0.21)</li></ul></td>
  </tr>
  </table>
</p>
<h2>Installation</h2>
<a href="https://help.ui.com/hc/en-us/articles/204909374-UniFi-Connect-with-Debug-Tools-SSH">SSH into your UDM</a> and enter:</br>
<code>sudo -v ; curl https://raw.githubusercontent.com/emsi76/unifi_rclone.webdav/refs/heads/main/install.sh | sudo bash</code>

<h2>Configuration</h2>
2-Step quick config:<br/>&nbsp;<br/>
<ol>
  <li>
    Environment parameters
    <p>
      there are 4 config items under 'rclone_webdav.env' with following defaults:<br/>
      <code>
      # Defining the Port of the Webdav Server
      RCLONE_WEBDAV_PORT= 55007
      # Defining the root folder of the WebDav Server
      RCLONE_WEBDAV_ROOT_PATH= /data/rclone/root
      # Defining the path of the log file
      RCLONE_WEBDAV_LOG_PATH=/data/rclone/log.txt
      # Defining the number of max failed logins of a user from htpasswd before he will be banned
      RCLONE_WEBDAV_FAILED_LIMIT=10
      </code>
    </p>
    <p>You can set the path to your disk (ssd/hdd) as RCLONE_WEBDAV_ROOT_PATH if you have a corresponding storage.
    <p>
      To make your changes effective just run the installation commmand again (see <a href="#installation">installation</a> above)!
    </p>
  </li>
  <li>
    User Management
    <p>
      Basic user managment can be done via htpasswd file in '/data/rclone' folder.
      Default  WebDav user is 'webdav' with default password 'webdav'.
      Please generate your own user/pass to add via e.g. with :<br/>
      <a href="https://www.web2generators.com/apache-tools/htpasswd-generator">web2generators htpasswd-generator</a> or <a href="https://htpasswdgenerator.de">htpasswd generator</a>
    </p>
  </li>
</ol> 
Don't forget to add a firewall rule, if you want to access the webdav server from WAN.

<h2>Update</h2>
Same as Installation (existing config, htpasswd and root folder won't be touched, remove then manually if you want fresh one).
  
<h2>Use (tested WebDav Clients)</h2>
Connect with your preferred WebDav Client via https to the url/ip of your UDM using the configured port (defaults: 55007).
Depending on the ssl certs you are using on your UDM you will have to trust the cert.<br/>
Following clients were successfully tested:
<p>
  <table border=1 cellspacing=10>
  <tr>
    <th>Client Type</th>
    <th>Client</th>
    <th>Version(s)</th>
  </tr>
  <tr>
    <td>Browser</td>
    <td><a href="https://www.apple.com/safari/">Safari</a></td>
    <td>MacOS 18.0.1</td>
  </tr>
  <tr>
    <td>Browser</td>
    <td><a href="https://www.microsoft.com/en-us/edge/download?form=MA13FJ">Edge</a></td>
    <td>MacOS 130.0.2849.52</td>
  </tr>
  <tr>
    <td>App</td>
    <td><a href="https://www.enpass.io">Enpass</a></td>
    <td>MacOS / iOS 6.11.4</td>
  </tr> 
  <tr>
    <td>App</td>
    <td><a href="https://subsembly.com/banking4.html">Banking4</a></td>
    <td>MacOS / iOS 8.62</td>
  </tr> 
  <tr>
    <td>App</td>
    <td><a href="https://www.photosync-app.com/">PhotoSync</a></td>
    <td>iOS 4.9.1</td>
  </tr> 
  </table>
</p>

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
<h2>Tips</h2>
<ul>
  <li>
    Find out the path to your added disk (hdd/sdd) with <b>df -h</b> and check the one with corresponding size:<br/>&nbsp;<br/>
    <img width="50%" height="50%" src="https://github.com/user-attachments/assets/891ed8da-3e4d-43a5-932c-85de825ccb80">
    <br/>In this case: /dev/md3 mounted as /volume1 with 1,7 TB available size.
  </li>
</ul>
<h2>Thanks</h2>
<ul>
<li>to <a href="ui.com">Unifi</a> for the great hardware/firmware accessible via ssh/bash</li>
<li>to <a href="https://github.com/rclone/rclone">rclone</a> for the webdav server software which this utility is based on</li>
<li>to <a href="https://glennr.nl/s/unifi-lets-encrypt">Glenn R. unifi-lets-encrypt</a> making it even possible to run the webdav server with http<b>s</b> and let's encrypt certs of UDM</li>
<li>to <a href="https://github.com/fail2ban/fail2ban">fail2ban</a> for the idea of hardening http basic auth by tailing the log file to ban</li>
</ul>
