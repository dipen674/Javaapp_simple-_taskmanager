FROM tomcat:11.0-jdk17

# Copy and make wait-for-it.sh executable
COPY wait-for-it.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wait-for-it.sh

# Copy the WAR file
COPY target/taskmanager-webapp.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
