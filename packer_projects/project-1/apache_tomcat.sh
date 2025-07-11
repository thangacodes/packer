#!/bin/bash

set -x  # Enable debugging

# Display script execution time
echo "***** Script execution at *****: $(date '+%Y-%m-%d %H:%M:%S')"

# Define required Tomcat version
REQ_TOMCAT_VER="10.1.11"
echo "Required Tomcat Version: ${REQ_TOMCAT_VER}"

# Extract major version
TOMCAT_MAJOR_VER=$(echo "${REQ_TOMCAT_VER}" | cut -d. -f1,2)
echo "Tomcat Major Version: ${TOMCAT_MAJOR_VER}"

# Construct download URL
URL="https://dlcdn.apache.org/tomcat/tomcat-${TOMCAT_MAJOR_VER}/v${REQ_TOMCAT_VER}/bin/apache-tomcat-${REQ_TOMCAT_VER}.tar.gz"
echo "Download URL: ${URL}"

# Configure S3 bucket
S3_BUCKET="s3://gitops-demo-bucket-tf"
echo "S3 Bucket: ${S3_BUCKET}"

# Define artifact name
ARTIFACT="lms.war"
echo "Artifact: ${ARTIFACT}"

# Install Java
echo "**** Setting up Java in Tomcat server ****"
sudo yum install -y java

# Download and extract Tomcat
cd /tmp/ || exit
wget "${URL}"

echo "***** Extracting apache-tomcat-${REQ_TOMCAT_VER}.tar.gz *****"
tar -xf "apache-tomcat-${REQ_TOMCAT_VER}.tar.gz"
mv "apache-tomcat-${REQ_TOMCAT_VER}" "tomcat${TOMCAT_MAJOR_VER}"

# Clean up the downloaded tar.gz file
echo "**** Cleaning up: removing tar.gz file ****"
rm -f "apache-tomcat-${REQ_TOMCAT_VER}.tar.gz"

# Move Tomcat to /opt/
echo "**** Moving Tomcat to /opt/ ****"
cd /opt/ || exit
sudo cp -R "/tmp/tomcat${TOMCAT_MAJOR_VER}" .

# Download WAR file from S3 bucket
cd "/opt/tomcat${TOMCAT_MAJOR_VER}/webapps/" || exit
echo "**** Downloading ${ARTIFACT} from bucket ${S3_BUCKET} ****"
aws s3 cp "${S3_BUCKET}/${ARTIFACT}" .

# Start Tomcat
sh ../bin/startup.sh
sleep 10  # Wait for Tomcat to start

# Log webapps and Tomcat logs
ls -l /opt/tomcat${TOMCAT_MAJOR_VER}/webapps/ > /tmp/webapps_files.txt
cat /opt/tomcat${TOMCAT_MAJOR_VER}/logs/catalina.out > /tmp/tomcat_log.txt

exit 0
