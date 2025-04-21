FROM ruby:3.2-slim

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    imagemagick \
    imagemagick-6.q16 \
    python3-venv \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Create a virtual environment for Python packages
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Now install jupyter in the virtual environment
RUN pip install jupyter

WORKDIR /srv/jekyll

COPY Gemfile Gemfile.lock ./
RUN gem install bundler:2.6.6 && bundle install

EXPOSE 4000

CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]