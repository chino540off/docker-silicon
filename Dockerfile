FROM alpine

ENV DEPS git cmake make g++ boost-dev

RUN set -ex \
&& apk upgrade \
&& apk update \
&& apk add --update $DEPS \
&& rm -rf /var/cache/apk/* \
&& mkdir -p /tmp \
&& cd /tmp \
&& git clone https://github.com/matt-42/iod.git \
&& mkdir /tmp/iod/build \
&& cd /tmp/iod/build \
&& cmake \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX=/usr \
	.. \
&& make -j 4 install \
&& rm -rf /tmp/iod \
&& mkdir -p /tmp \
&& cd /tmp \
&& git clone https://github.com/matt-42/silicon.git \
&& mkdir /tmp/silicon/build \
&& cd /tmp/silicon/build \
&& cmake \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX=/usr \
	.. \
&& make -j 4 install \
&& rm -rf /tmp/silicon \
&& apk del $DEPS \
&& rm -rf /var/cache/apk/* \
&& echo Done
