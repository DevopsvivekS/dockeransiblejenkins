FROM tomcat:8
# Take the war and copy to webapps of tomcat
RUN cp -R /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps
COPY target/*.war /usr/local/tomcat/webapps/dockeransible.war
