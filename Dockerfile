FROM circleci/buildpack-deps AS build

WORKDIR /home/circleci

RUN curl -L -O http://www.javascriptlint.com/download/jsl-0.3.0-src.tar.gz \
    && tar zxvf jsl-0.3.0-src.tar.gz \
    && cd jsl-0.3.0/src/ \
    && make -f Makefile.ref \
    && sudo cp Linux_All_DBG.OBJ/jsl /usr/local/bin/jsl \
    && rm -rf /home/circleci/jsl-0.3.0 \
    && rm -rf /home/circleci/jsl-0.3.0-src.tar.gz

FROM debian:stretch
COPY --from=build /usr/local/bin/jsl /usr/local/bin/jsl

CMD [ "jsl" ]
