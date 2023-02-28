FROM ruby:3.2.0

ADD . /lsb_image
WORKDIR /lsb_image
RUN bundle install

ENV RAILS_ENV development 
ENV RAILS_SERVE_STATIC_FILES true

EXPOSE 3000
CMD ["bash"]
