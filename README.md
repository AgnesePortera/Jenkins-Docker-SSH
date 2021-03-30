# README

![Docker](https://img.shields.io/badge/docker-v20.10.5-blue)
![Jenkins](https://img.shields.io/badge/Jenkins-ARM-red)
![GitHub repo size](https://img.shields.io/github/repo-size/AgnesePortera/Jenkins-Docker-SSH)
![GitHub](https://img.shields.io/github/license/AgnesePortera/Jenkins-Docker-SSH?style=plastic)
![GitHub](https://img.shields.io/github/last-commit/AgnesePortera/Jenkins-Docker-SSH)

In a little Raspberry Pi 4 you can start a Jenkins application that comunicates with a SSH server.

Really??

Yes! Using Docker :smile:

The network is composed by two containers:

* **jenkins** with an image from [Docker Hub](https://hub.docker.com/r/jenkins4eval/jenkins) applicable to ARM processor.

* **remote-host** with a CentOS 7 system in which is installed the openssh-server (see the *centos7/Dockerfile* for the implementation).

Both the containers are in the same virtual network called *net* .

![preview config](https://github.com/AgnesePortera/Jenkins-Docker-SSH/blob/master/schema.png)


### How to run the project
After pulling the project locally, create the SSH key inside the *centos7* folder:

`ssh-keygen -f remote-key -m PEM`

Open the file with `cat remote-key` and check that the first line is:

`------BEGIN RSA PRIVATE KEY------`

After that starts Docker-compose:

`docker-compose up`

In this way the first time, the image is builded and after that the two container are running:

`docker ps`

If the two container are not running, please check the status with docker log.
Open the browser in *localhost:8080* and start the JENKINS installation.

## SSH

Copy the SSH private key inside the Jenkins container with the following command:

`docker cp remote-key jenkins:/tmp/remote-key`

Start a bash command in the container and check if the file is present:

`docker exec -it jenkins bash`

Move in *tmp* directory and check with `cat remote-key` if the key is the correct one.

After that start the SSH connection from the Jenkins container to the remote-host:

`ssh -i remote-key remote_user@remote_host`

### Jenkins 
From the Jenkins panel, is it possible to add a Global credential of type *SSH username with private key* with the same key previously generated.
After that it can be added an *SSH remote host* from Dashboard->Manage Jenkins->Configure System, using:

* Hostname = remote_host (that is the container name)
* Port= 22
* Credentials = select the one previously added

Finally check the connection.

Now it is possible to create a JOB that execute shell script on remote host using SSH.
In this case the remote host it's the Docker container itself.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/AgnesePortera/Jenkins-Docker-SSH/.
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the
[code of conduct](https://github.com/AgnesePortera/Jenkins-Docker-SSH/blob/master/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the Notification Bot project's codebases, issue trackers, chat rooms and mailing lists is
expected to follow
the [code of conduct](https://github.com/AgnesePortera/Jenkins-Docker-SSH/blob/master/CODE_OF_CONDUCT.md).

## License

This project is distributed under _MIT_ license.
