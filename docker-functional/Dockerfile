FROM          taskcluster/desktop-test:0.1.8.20160218152601

RUN pip install virtualenv virtualenvwrapper mozdownload pyperclip

COPY          setup.sh /home/worker/bin/
RUN           chmod 755 /home/worker/bin/*

# Set up VNC
RUN           mkdir /home/worker/.vnc
RUN           x11vnc -storepasswd 1234 /home/worker/.vnc/passwd
