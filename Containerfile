FROM quay.io/toolbx-images/alpine-toolbox:edge

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="<jose@storopoli.io>"

# Julia has no apk
# Taken from https://hub.docker.com/_/julia/
ENV JULIA_PATH=/opt/julia
ENV JULIA_GPG=3673DF529D9049477F76B37566E3C7DC03D6E495
ENV JULIA_VERSION=1.8.5
RUN /bin/sh -c set -eux; apk add --no-cache --virtual .fetch-deps gnupg; arch="$(apk --print-arch)"; url='https://julialang-s3.julialang.org/bin/musl/x64/1.8/julia-1.8.5-musl-x86_64.tar.gz'; wget -O julia.tar.gz.asc "$url.asc"; wget -O julia.tar.gz "$url"; export GNUPGHOME="$(mktemp -d)"; gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$JULIA_GPG"; gpg --batch --verify julia.tar.gz.asc julia.tar.gz; command -v gpgconf > /dev/null && gpgconf --kill all; rm -rf "$GNUPGHOME" julia.tar.gz.asc; mkdir "$JULIA_PATH"; tar -xzf julia.tar.gz -C "$JULIA_PATH" --strip-components 1; rm julia.tar.gz; apk del --no-network .fetch-deps
RUN ln -s $JULIA_PATH/bin/julia /usr/local/bin/julia

COPY extra-packages /
RUN apk update && \
    apk upgrade && \
    grep -v '^#' /extra-packages | xargs apk add --no-cache
RUN rm /extra-packages

RUN   ln -fs /bin/sh /usr/bin/sh && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \ 
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/transactional-update
