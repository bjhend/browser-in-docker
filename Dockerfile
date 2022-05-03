#
# Create Docker image running Firefox
#
# Author: Björn Hendriks, 2019
#

ARG baseImage
FROM ${baseImage}

# ARG variables must be defined after FROM except for args used for FROM
ARG userName
ARG uid
ARG groupName
ARG gid

# Avoid blocking the update by interaction (at least tzdata blocks it entirely)
ENV DEBIAN_FRONTEND=noninteractive

# Install Firefox and supplementary tools
RUN apt-get update && \
	apt-get install -y \
		firefox-esr \
		pulseaudio-utils \
		vlc \
		vlc-data \
	&& \
	apt-get clean

# Run Firefox as ordinary user
RUN groupadd --gid ${gid} ${groupName} && \
	useradd --uid ${uid} --gid ${gid} --create-home ${userName}
USER ${userName}

# Configure Pulseaudio client to route sound to host
COPY pulse-client.conf /etc/pulse/client.conf

# Start Firefox
CMD /usr/bin/firefox
