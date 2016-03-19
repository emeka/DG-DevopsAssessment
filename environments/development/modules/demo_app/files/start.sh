#/bin/sh

export APP_VERSION="0.1" 
export APP_PORT=1234
export DB_NAME=test
export DOCKER_DEMO_MYSQL_SERVICE_HOST=localhost

java -jar ./demo.war &
