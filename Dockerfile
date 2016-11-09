# Firefox over ssh X11Forwarding

FROM ubuntu:latest

# Set default locale for the environment
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# make sure the package repository is up to date
# and blindly upgrade all packages
RUN apt-get update
RUN apt-get upgrade -y -qq

# install ssh and iceweasel
RUN apt-get install -y openssh-server chromium-browser

# install pulseaudio to forward sound server to local session using paprefs
RUN apt-get install -y pulseaudio

# various utils that aid in getting firefox installed
RUN apt-get install -y curl wget xz-utils bzip2 unzip

# Create user "docker" and set the password to "docker"
RUN useradd -m -d /home/docker docker
RUN echo "docker:docker" | chpasswd

# Prepare ssh config folder
RUN mkdir -p /home/docker/.ssh
RUN mkdir -p /home/docker/.config/chromium
RUN chown -R docker:docker /home/docker
RUN chown -R docker:docker /home/docker/.ssh
RUN chown -R docker:docker /home/docker/.config/chromium

# grab the latest firefox, flash and privacytools.io encouraged plugins

# Create OpenSSH privilege separation directory, enable X11Forwarding
RUN mkdir -p /var/run/sshd
RUN echo X11Forwarding yes >> /etc/ssh/ssh_config

# VOLUME ["/home/docker/.config/chromium"]


# Expose the SSH port
EXPOSE 22

# Start SSH
ENTRYPOINT ["/usr/sbin/sshd",  "-D"]
