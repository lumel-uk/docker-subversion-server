# Simple SVN Controller

This is Yet Another SVN Server, compatible with Synology DSM.

Some people use git; some use svn; some use both.  This exposes svn over the custom svn protocol.


## Update Policy

The image is updated on the following policy:

* Weekly, Sundays at 00:00: The `master` branch will be re-built and tagged `latest`.  This allows for upstream packages to be updated.  
* Ad-hoc: As and when I make changes, I'll push to `dev`.  It'll probably work but it also might break.

For stability, choose `latest`.  For whatever I'm poking, choose `dev` but be aware it's unlikely to be exciting.


## Image Installation

From Docker Hub:

```sh
docker pull lumel/subversion-server
```
From Source:

```sh
git clone https://github.com/lumel-uk/docker-subversion-server.git
cd docker-subversion-server
docker build -t "subversion-server:latest" --rm .
```


## Running the Container

Create a volume to store the svn repos.  You probably already have this somewhere.
Then launch the container using the previously created volumes.

```sh
docker volume create --name svn
docker run -d -p 3690:3690/tcp \
			  -v svn:/svn \
			  --name lumel-subversion \
			  lumel/subversion-server
```

If, like me, you'd rather maintain state in a specific place in the local 
filesystem, do this instead:

```sh
DATA_PATH=/wherever/unifi-controller
mkdir -p $DATA_PATH
docker run -d -p 3690:3690/tcp \
			  -v ${DATA_PATH}:/svn \
			  --name lumel-subversion \
			  lumel/subversion-server
```


## Manual Update

If you'd like to update the package / distro manually, use the following:

```sh
docker exec -it lumel-subversion sh -c 'apt update && apt dist-upgrade'
```


## Author
- Henry Southgate - [Github](https://github.com/lumel-uk/)

Distributed under the GPL 3 license. See ``LICENSE`` for more information.

