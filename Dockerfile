FROM ruby:2.1.5
MAINTAINER thoughtbot <support@thoughtbot.com>

# Install packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        cm-super=0.3.4-9 \
        fonts-inconsolata=001.010-5 \
        fonts-lmodern=2.004.4-5 \
        locales=2.19-18 \
        texlive-fonts-recommended=2014.20141024-2 \
        texlive-latex-extra=2014.20141024-1 \
        texlive-xetex=2014.20141024-2 && \
    rm -rf /var/lib/apt/lists/*

# Set the locale
ENV RUBYOPT "-E utf-8"
ENV LANG en_US.UTF-8
ENV LANGUAGE $LANG
ENV LC_ALL $LANG
RUN echo "$LANG UTF-8" >> /etc/locale.gen && locale-gen

# Install Pandoc
ENV PANDOC_VERSION 1.13.2
ENV PANDOC_PACKAGE pandoc-$PANDOC_VERSION-1-amd64.deb
RUN wget https://github.com/jgm/pandoc/releases/download/$PANDOC_VERSION/$PANDOC_PACKAGE && \
    dpkg -i $PANDOC_PACKAGE && \
    rm $PANDOC_PACKAGE

# Setup Paperback
ENV PAPERBACK_HOME /usr/local/paperback
RUN mkdir -p $PAPERBACK_HOME
WORKDIR $PAPERBACK_HOME
COPY Gemfile* $PAPERBACK_HOME/
RUN bundle install
COPY lib/paperback/assets/fonts /usr/local/share/fonts
RUN fc-cache -fv
COPY . $PAPERBACK_HOME
ENV PATH $PAPERBACK_HOME/exe:$PATH

# Create directory to be mounted as data volume
RUN mkdir -p /src
WORKDIR /src

ENTRYPOINT ["paperback"]
CMD ["help"]
