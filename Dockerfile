FROM --platform=arm64 ruby:3.2.2
MAINTAINER thoughtbot <support@thoughtbot.com>

# Install packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        cm-super \
        fonts-inconsolata \
        fonts-lmodern \
        locales \
        texlive-fonts-recommended \
        texlive-latex-extra \
        texlive-xetex && \
    rm -rf /var/lib/apt/lists/*

# Set the locale
ENV LANG en_US.UTF-8
ENV LANGUAGE $LANG
ENV LC_ALL $LANG
RUN echo "$LANG UTF-8" >> /etc/locale.gen && locale-gen

# Install Pandoc
ENV PANDOC_VERSION 3.1.8
ENV PANDOC_PACKAGE pandoc-$PANDOC_VERSION-1-arm64.deb
RUN wget https://github.com/jgm/pandoc/releases/download/$PANDOC_VERSION/$PANDOC_PACKAGE && \
    dpkg -i $PANDOC_PACKAGE && \
    rm $PANDOC_PACKAGE

# Setup Paperback
ENV PAPERBACK_HOME /usr/local/paperback
RUN mkdir -p $PAPERBACK_HOME
WORKDIR $PAPERBACK_HOME
COPY Gemfile* $PAPERBACK_HOME/
RUN bundle config build.ffi --enable-libffi-alloc
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
