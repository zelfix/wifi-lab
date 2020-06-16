FROM centos:7

RUN yum update -y && yum upgrade && yum install -y freeradius freeradius-ldap

COPY default-site.conf /etc/raddb/sites-available/default 

COPY ldap.conf /etc/raddb/mods-available/ldap
RUN ln -s /etc/raddb/mods-available/ldap /etc/raddb/mods-enabled/ldap

COPY eap.conf /etc/raddb/mods-available/eap

COPY clients.conf /etc/raddb/clients.conf

CMD ["radiusd", "-X" ] 
