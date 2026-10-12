FROM alpine:3.19

LABEL version="2.5.0" \
      author="Foxcorn Lab (Vineeth Kumar), upstream Nikto by Chris Sullo (https://github.com/sullo/nikto)" \
      docker_build="docker build -t foxcornlab/thc-nikto:2.5.0 ." \
      docker_run_basic="docker run --rm foxcornlab/thc-nikto:2.5.0 -h http://www.example.com" \
      docker_run_advanced="docker run --rm -v $(pwd):/tmp foxcornlab/thc-nikto:2.5.0 -h http://www.example.com -o /tmp/out.json"

RUN echo 'Installing packages for valdenikto.'
RUN apk add --update --no-cache --virtual .build-deps \
     perl \
     perl-net-ssleay

RUN echo 'Creating the valdenikto group.' \
  && addgroup valdenikto \
  && echo 'Creating the valdenikto user.' \
  && adduser -G valdenikto -g "valdenikto user" -s /bin/sh -HD valdenikto

ENV  PATH=${PATH}:/opt/valdenikto
USER valdenikto

COPY --chown=valdenikto:valdenikto ["program/", "/opt/valdenikto"]
ENTRYPOINT ["valdenikto.pl"]
