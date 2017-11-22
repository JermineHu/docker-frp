FROM alpine:edge
MAINTAINER Jermine <Jermine.hu@qq.com>
ENV PATH=$PATH:/root/bin
RUN apk add --no-cache --virtual .build-deps make  go=1.9.2-r1 git gcc musl-dev binutils ;\
     go version ;\
     go env ;\
     go get github.com/fatedier/frp ;\
 #   go get github.com/Masterminds/glide;\
 #    cd /root/go/src/github.com/Masterminds/glide ;\
 #    make build ;\
 #    make install ;\
    cd /root/go/src/github.com/fatedier/frp ;\
	make ;\
    mv bin /root/ ;\
	rm -r /var/cache/apk ; \
	rm -r /usr/share/man ; \
	rm -rf /root/go ;\
    rm /root/bin/frpc ;\
    apk del .build-deps
WORKDIR /root/bin
EXPOSE 80 443 6000 7000 7500
ENTRYPOINT [ "frps" ]
