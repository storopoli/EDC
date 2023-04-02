FROM docker.io/library/archlinux:base-devel

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="Jose Storopoli <jose@storopoli.io>"

# install extra packages
COPY extra-packages /
RUN grep -v '^#' /extra-packages | xargs pacman -Syu --needed --noconfirm
RUN rm /extra-packages

# clean up cache
RUN pacman -Scc --noconfirm

# install nerdfonts symbols only
RUN   mkdir -p /usr/share/fonts/NerdFontsSymbolsOnly && \
      curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/NerdFontsSymbolsOnly.zip && \
      unzip -d /usr/share/fonts/NerdFontsSymbolsOnly NerdFonts*.zip "*.ttf" && \
      rm NerdFonts*.zip && \
      fc-cache -f -v

# enable sudo permission for wheel users
RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/toolbox

# enable zsh for storopoli user
RUN echo "storopoli::1000:1000:Jose Storopoli:/var/home/storopoli:/bin/zsh" >> /etc/passwd

# some distrobox links to host binaries
RUN   ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \ 
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/transactional-update
