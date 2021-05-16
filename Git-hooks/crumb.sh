crumb=$(curl -u "jenkins:1234" -s 'http://jenkins.local:8080/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)')
# curl -u "jenkins:1234" -H "$crumb" -X POST http://jenkins.local:8080/job/job-dsl/build?delay=0sec
curl -u "jenkins:1234" -H "$crumb" -X POST  http://jenkins.local:8080/job/job-dsl/buildWithParameters?MYSQL_HOST=db_host&DATABASE_NAME=testdb
