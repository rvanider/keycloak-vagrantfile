#!/bin/sh

# This script downloads and installs Keycloak.
# Use the VERSION environment variable below to define the version to be used.

VERSION=1.4.0.Final

DOWNLOAD_URL=http://downloads.jboss.org/keycloak/${VERSION}/keycloak-${VERSION}.tar.gz

# Install Java
echo "Installing Java 7 JDK ..."
yum -y -q install java-1.7.0-openjdk-devel

# Install Keycloak
if [ -f "/vagrant/downloads/keycloak-${VERSION}.tar.gz" ];
then
    echo "Installing Keycloak from /vagrant/downloads/keycloak-${VERSION} ..."
else
    echo "Downloading Keycloak ${VERSION} ..."
    mkdir -p /vagrant/downloads
    wget -q -O /vagrant/downloads/keycloak-${VERSION}.tar.gz "${DOWNLOAD_URL}"
    if [ $? != 0 ];
    then
        echo "FATAL: Failed to download Keycloak from ${DOWNLOAD_URL}"	
        exit 1
    fi

    echo "Installing Keycloak ..."
fi

tar xfz /vagrant/downloads/keycloak-${VERSION}.tar.gz -C /opt
rm -f /opt/keycloak
ln -s /opt/keycloak-${VERSION} /opt/keycloak

cp -f /vagrant/wildfly.conf /etc/default/wildfly.conf

rm -f /etc/init.d/keycloak
ln -s /opt/keycloak/bin/init.d/wildfly-init-redhat.sh /etc/init.d/keycloak
/sbin/chkconfig --add keycloak

source /etc/default/wildfly.conf
mkdir -p /var/log/wildfly
chown -R ${JBOSS_USER} /var/log/wildfly /opt/keycloak-${VERSION}

# Start Keycloak
echo "Starting Keycloak ..."

/sbin/service keycloak start

echo "Opening port 8080 on iptables ..."
iptables -I INPUT 3 -p tcp -m state --state NEW -m tcp --dport 8080 -j ACCEPT
iptables-save > /etc/sysconfig/iptables

