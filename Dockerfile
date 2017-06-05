FROM cannin/r-base:ubuntu-14.04.4_r-3.3.2_java-8

## Define versions required:
ENV VERSION_OPENCPU 1.6

# INSTALL
RUN \
  add-apt-repository -y ppa:opencpu/opencpu-${VERSION_OPENCPU} && \
  apt-get update && \
  apt-get install -y opencpu && \
  apt-get clean autoclean && \
  apt-get autoremove -y && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# INSTALL ADDITIONAL TOOLS
RUN apt-get update
RUN apt-get install -y curl htop wget

# PORTS
EXPOSE 80
EXPOSE 443
EXPOSE 8004

# COMMAND
CMD service opencpu restart && tail -F /var/log/opencpu/apache_access.log
