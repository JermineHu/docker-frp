FROM golang
MAINTAINER Jermine <Jermine.hu@qq.com>
RUN apk  update && apk add make git ;\
     go version ;\
     go env ;\
     go get github.com/fatedier/frp ;\
     cd /go/src/github.com/fatedier/frp ;\
     make
FROM scratch
MAINTAINER Jermine <Jermine.hu@qq.com>
COPY --from=0 /go/src/github.com/fatedier/frp/bin/frps /app/frps
ENV PATH=$PATH:/app
EXPOSE 80 443 6000 7000 7500
ENTRYPOINT [ "frps" ]
