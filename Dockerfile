FROM armv7/armhf-debian

#############################
# apt-get dependencies
RUN apt-get update; apt-get install -y git curl wget build-essential python2.7 tmux
RUN ln -s /usr/bin/python2.7 /usr/bin/python

#############################
# Cloud9 IDE
RUN git clone git://github.com/c9/core.git c9sdk
RUN cd c9sdk; ./scripts/install-sdk.sh; ln -s /c9sdk/bin/c9 /usr/bin/c9; ln -s /root/.c9/node/bin/node /usr/bin/node

EXPOSE 8080 8081 8082

# add in some nice Cloud9 default settings
COPY user.settings /root/.c9/
COPY .c9 /home/.c9

# start cloud9 with no authentication by default
# if authentication is desired, set the value of -a, i.e. -a user:pass at docker run
ENTRYPOINT ["/root/.c9/node/bin/node", "c9sdk/server.js", "-w", "/home", "--listen", "0.0.0.0", "-p", "8080"]
CMD ["-a", ":"]
