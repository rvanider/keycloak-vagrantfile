Vagrantfile for Keycloak
========================

This project can be used to start [Keycloak](http://keycloak.jboss.org) on a Vagrant Box. 
The box is based on CentOS 6.6 and the Keycloak version is 1.4.0.Final.

Keycloak is installed using a simple Bash script, [bootstrap.sh](bootstrap.sh). 
The version of Keycloak to be installed is defined at the top of the script 
using the `VERSION` environment variable. The script downloads the release from 
JBoss downloads and stores it under `downloads/` in the project directory.

Getting Started
---------------

Start the Vagrant Box with command `vagrant up`. This will download the necessary files and
after the box is up and running without errors, you can find the Keycloak default install at 
<http://localhost:8080>.

More information on how to manage a Keycloak instance can be found at 
<http://keycloak.jboss.org/docs>.

Exporting Data
--------------

Keycloak has been configured to export all realms and users **at startup** to `exports/` 
under the project directory. The configuration can be found in [wildfly.conf](wildfly.conf).

Please understand that if you want to export the current state of the realms, you will 
need to restart the Keycloak application. You can do this with the command 
`vagrant ssh -c 'sudo service keycloak restart'`.

You can use the Keycloak admin UI to import realms from the exported files. 

More information on how to import/export data can be found in the [User Guide](http://keycloak.github.io/docs/userguide/html/export-import.html).
