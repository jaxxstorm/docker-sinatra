FROM base

MAINTAINER tcnksm "https://github.com/tcnksm"

# Install packages for building ruby
RUN apt-get update
RUN apt-get install -y --force-yes build-essential curl git
RUN apt-get install -y --force-yes zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev
RUN apt-get clean

# Install rbenv and ruby-build
RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN ./root/.rbenv/plugins/ruby-build/install.sh
RUN echo 'eval "$(rbenv init -)"' >> /etc/bash.bashrc

# Install ruby 2.0.0-p353
ENV PATH /root/.rbenv/bin:$PATH
ENV CONFIGURE_OPTS --disable-install-doc
RUN rbenv install 2.0.0-p353
RUN rbnev global 2.0.0-p353

# Install Bundler 
RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc
RUN eval "$(rbenv init -)"; gem install bundler

# Set defaults for excuting container
CMD /bin/bash


