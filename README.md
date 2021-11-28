# Browser in a Docker Container

Dockerfile and supplementary scripts to run a browser in a [Docker](https://www.docker.com) container.


## Purpose

Running a browser in a Docker container separates it completely from other browser windows and the rest of the system. When the browser window (and all windows spawned by it) are closed all traces of the browsing session will be deleted (eventually except for downloads, see below).

**Note that the IP address seen by remote web servers is the same inside and outside of the container, so simultaneous browser sessions in different containers or outside could be assigned to each other. Additionally, tricks like browser fingerprinting may produce the same results inside and outside of a Docker container.**

The container setup and the start script allow to play sound and video.


## Features

* Encapsulated environment of a Docker container
* All cookies and other traces of browsing are safely deleted when the container is removed
	* Removing the container is done automatically when the last window was closed
* You may specify a folder of the host as download folder for the browser
* Sound and video are enabled
* Based on Ubuntu and Firefox


## How to use it

* Install Docker on your system
* Install `xhost` if not already present
* Run `build` to create the Docker image
* Run `start` to run container based on the image, opening a browser window
	* Pass a host folder as argument to `start` to use that as download folder.
	* Pass a second argument as name for the container. If given the container
	  will be persistent, so you have to remove it manually or may restart it
	  later.
	* When a video won't play, try to set _Play DRM-controlled content_ in preferences/General
* Sometimes update the image by running `update`


## Supplementary scripts

For details see comments within these scripts.


### `config`

Contains common configuration settings for the scripts.


### `build`

Build the Docker image passing the configuration settings from `config` as arguments to the Dockerfile. Calls `xhost` to enable X server connections for containers started by current user.


### `update`

Update base image and then rebuild the Docker image to update it.


### `start`

Run a container with the built Docker image. The script sets all options to pass audio and video to the host to enable watching videos with the browser in the container.

When a host folder is passed as argument, that folder will be mounted as download folder for the browser.

When a second argument is passed it will be used as Docker name for the container.

Unless a name (second argument is given) the container is started with option `--rm` so the container becomes removed once the browser (and all windows opened by it) is closed. If the second argument is given you have to remove the container yourself or you may restart it later with `docker restart <name>`.


## Todos

- Firefox does not offer an interface to add and setup plugins by script. Find a way to do it nevertheless and add useful plugins like, for example, _HTTPS everywhere_.
- Find a way to make other Firefox setups by script, for example, _Play DRM-controlled content_.

