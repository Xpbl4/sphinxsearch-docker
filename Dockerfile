# Dockerfile for Sphinx SE
# https://hub.docker.com/_/alpine/
FROM alpine:latest

# install dependencies
RUN apk add --no-cache mariadb-connector-c-dev \
    sphinx

# set up and expose directories
RUN mkdir -pv /var/log/sphinx /var/lib/sphinx/data /var/run/sphinx
VOLUME /var/lib/sphinx/data

EXPOSE 9306 9312

# redirect logs to stdout
COPY tests ./tests
RUN	cat ./tests/docset.xml | indexer --config ./tests/sphinx.conf test_index

#    && searchd --stop \
RUN rm -rf /var/lib/sphinx/data/* \
    && ln -sv /dev/stdout /var/log/sphinx/indexer.log \
    && ln -sv /dev/stdout /var/log/sphinx/searchd.log

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["searchd", "--nodetach"]