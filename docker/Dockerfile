FROM          taskcluster/ubuntu1204-test-upd:0.1.9.20160329211700

# A lot of this was based on from
# http://hg.mozilla.org/mozilla-central/file/0a25833062a8/testing/docker/desktop-test/Dockerfile

RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
RUN apt-get update -y
RUN apt-get install -y git \
    nodejs \
    && apt-get clean

RUN pip install virtualenvwrapper
RUN pip install mozdownload
RUN pip install pyperclip

# configure git and install tc-vcs
RUN git config --global user.email "nobody@mozilla.com" && \
    git config --global user.name "mozilla"

# Set variable normally configured at login, by the shells parent process, these
# are taken from GNU su manual
ENV           HOME          /home/worker
ENV           SHELL         /bin/bash
ENV           USER          worker
ENV           LOGNAME       worker
ENV           HOSTNAME      taskcluster-worker

### add worker user and setup its workspace
COPY          entrypoint.sh /home/worker/bin/
RUN           chmod 755 /home/worker/bin/*
RUN           chown -R worker:worker /home/worker
USER          worker

### Various useful directories
RUN           mkdir artifacts
RUN           mkdir artifacts/public

### Set up VNC
RUN           mkdir /home/worker/.vnc
RUN           x11vnc -storepasswd 1234 /home/worker/.vnc/passwd

ENTRYPOINT ["/home/worker/bin/entrypoint.sh"]

# Disable Ubuntu update prompt
# http://askubuntu.com/questions/515161/ubuntu-12-04-disable-release-notification-of-14-04-in-update-manager
ADD release-upgrades /etc/update-manager/release-upgrades

# Disable tools with on-login popups that interfere with tests; see bug 1240084 and bug 984944.
ADD jockey-gtk.desktop deja-dup-monitor.desktop /etc/xdg/autostart/

# Disable apport (Ubuntu app crash reporter) to avoid stealing focus from test runs
ADD apport /etc/default/apport

# Disable font antialiasing for now to match releng's setup
ADD fonts.conf /home/worker/.fonts.conf

# In test.sh we accept START_VNC to start a vnc daemon.
# Exposing this port allows it to work.
EXPOSE 5900

# This helps not forgetting setting DISPLAY=:0 when running
# tests outside of test.sh
ENV DISPLAY :0

# Set a default command useful for debugging
CMD ["/bin/bash", "--login"]
