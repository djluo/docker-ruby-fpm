# vim:set et ts=2 sw=2 syntax=dockerfile:

FROM       docker.xlands-inc.com/baoyu/ruby
MAINTAINER djluo <dj.luo@baoyugame.com>

RUN export http_proxy="http://172.17.42.1:8080/" \
    && export DEBIAN_FRONTEND=noninteractive     \
    && build="libmysqlclient-dev \
              patch zlib1g-dev make binutils \
              cpp cpp gcc libc-dev-bin libc6-dev \
              libgmp10 libgomp1 libitm1  \
              libmpfr4 libquadmath0 libruby \
              libyaml-0-2 linux-libc-dev manpages manpages-dev ruby-dev" \
    && apt-get update \
    && apt-get install -y $build \
    && unset http_proxy \
    && gem install fpm  \
    && apt-get clean \
    && unset http_proxy DEBIAN_FRONTEND \
    && rm -rf /usr/share/locale \
    && rm -rf /usr/share/man    \
    && rm -rf /usr/share/doc    \
    && rm -rf /usr/share/info   \
    && find /var/lib/apt -type f -exec rm -fv {} \;

CMD ["/bin/bash", "-l"]
