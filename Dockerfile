FROM ruby:2.7.1

# 必要なパッケージのインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs

# yarnをインストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y yarn
# Node.jsをインストール
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - && \
apt-get install nodejs
# chromeのインストール
RUN apt-get update && apt-get install -y unzip && \
    CHROME_DRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` && \
    wget -N http://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip -P ~/ && \
    unzip ~/chromedriver_linux64.zip -d ~/ && \
    rm ~/chromedriver_linux64.zip && \
    chown root:root ~/chromedriver && \
    chmod 755 ~/chromedriver && \
    mv ~/chromedriver /usr/bin/chromedriver && \
    sh -c 'wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -' && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && \
    apt-get update && apt-get install -y google-chrome-stable

RUN mkdir /myapp
ENV APP_ROOT /myapp
WORKDIR $APP_ROOT

ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install
ADD . $APP_ROOT

EXPOSE 3000

COPY entrypoint.sh /bin/
RUN chmod +x /bin/entrypoint.sh
# RUN ln -sf /dev/stdout $APP_ROOT/log/production.log

CMD ["/bin/entrypoint.sh"]