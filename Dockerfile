# 编译阶段
FROM golang:1.12 as builder

LABEL maintainer="sunnydog0826@gmail.com"
COPY . /build/

WORKDIR /build

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build .

# 运行阶段
FROM alpine

RUN apk update \
    && apk add --no-cache bash git \
    && rm -rf /var/cache/apk/*

# 从编译阶段的中拷贝编译结果到当前镜像中
COPY --from=builder /build/drone-git /bin/


#ADD drone-git /bin/
ENTRYPOINT ["/bin/drone-git"]