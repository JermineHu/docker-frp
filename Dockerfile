FROM golang:alpine
MAINTAINER Jermine <Jermine.hu@qq.com>
RUN apk  update && apk add make git upx binutils ca-certificates ;\
     go version ;\
     go env ;\
     go get github.com/fatedier/frp ;\
     cd /go/src/github.com/fatedier/frp ;\
     make ;\
     cd /go/src/github.com/fatedier/frp/bin && strip -s frp* && upx -9 frp*
FROM scratch
MAINTAINER Jermine <Jermine.hu@qq.com>
COPY --from=alpine /lib/ld-musl-x86_64.so.1 /lib/ld-musl-x86_64.so.1
COPY --from=0 /go/src/github.com/fatedier/frp/bin/* /app/
ENV PATH=$PATH:/app
EXPOSE 80 443 6000 7000 7500
