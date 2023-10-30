FROM --platform=${BUILDPLATFORM:-linux/amd64} golang:1.21-alpine as builder

ARG VERSION=v1.7.2
ARG TARGETPLATFORM=linux/arm64
ARG BUILDPLATFORM=linux/arm64

RUN printf "I am running on ${BUILDPLATFORM}, building for ${TARGETPLATFORM}\n$(uname -a)\n"
RUN apk --update --no-cache add build-base git
RUN rm -rf /tmp/* /var/cache/apk/*
RUN git -c advice.detachedHead=false clone --branch ${VERSION} https://github.com/slackhq/nebula /go/src/github.com/slackhq/nebula
RUN cd /go/src/github.com/slackhq/nebula \
    && make BUILD_NUMBER="${VERSION#v}" build/$(echo ${TARGETPLATFORM} | sed -e "s/\/v/-/g" -e "s/\//-/g")/nebula \
    && make BUILD_NUMBER="${VERSION#v}" build/$(echo ${TARGETPLATFORM} | sed -e "s/\/v/-/g" -e "s/\//-/g")/nebula-cert \
    && mkdir -p /go/build/${TARGETPLATFORM} \
    && mv /go/src/github.com/slackhq/nebula/build/$(echo ${TARGETPLATFORM} | sed -e "s/\/v/-/g" -e "s/\//-/g")/nebula /go/build/${TARGETPLATFORM}/ \
    && mv /go/src/github.com/slackhq/nebula/build/$(echo ${TARGETPLATFORM} | sed -e "s/\/v/-/g" -e "s/\//-/g")/nebula-cert /go/build/${TARGETPLATFORM}/

# TODO testing
# RUN cd /go/src/github.com/slackhq/nebula && go mod download golang.org/x/net
# RUN cd /go/src/github.com/slackhq/nebula && VERSION=v1.7.2 make BUILD_NUMBER="${VERSION#v}" build/$(echo ${TARGETPLATFORM:-linux/arm64} | sed -e "s/\/v/-/g" -e "s/\//-/g")/nebula

FROM --platform=${TARGETPLATFORM} alpine:latest

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
ARG TARGETPLATFORM

LABEL maintainer="benhunter" \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.url="https://github.com/benhunter/nebula" \
      org.opencontainers.image.source="https://github.com/benhunter/nebula" \
      org.opencontainers.image.version=$VERSION \
      org.opencontainers.image.revision=$VCS_REF \
      org.opencontainers.image.vendor="benhunter" \
      org.opencontainers.image.title="nebula" \
      org.opencontainers.image.description="Nebula is a scalable overlay networking tool with a focus on performance, simplicity and security" \
      org.opencontainers.image.licenses="MIT"

COPY --from=builder /go/build/${TARGETPLATFORM}/nebula /usr/local/bin/nebula
COPY --from=builder /go/build/${TARGETPLATFORM}/nebula-cert /usr/local/bin/nebula-cert
RUN nebula -version
RUN nebula-cert -version

VOLUME ["/config"]

ENTRYPOINT [ "/usr/local/bin/nebula" ]
CMD ["-config", "/config/config.yaml"]