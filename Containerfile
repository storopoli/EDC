FROM quay.io/toolbx-images/archlinux-toolbox:latest

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="Jose Storopoli <jose@storopoli.io>"

COPY extra-packages /
RUN grep -v '^#' /extra-packages | xargs pacman -Syu --noconfirm
RUN rm /extra-packages
RUN rm -rf /var/cache

RUN   mkdir -p /usr/share/fonts/NerdFontsSymbolsOnly && \
      curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/NerdFontsSymbolsOnly.zip && \
      unzip -d "$HOME/.local/share/fonts/NerdFontsSymbolsOnly" NerdFonts*.zip "*.ttf" && \
      rm NerdFonts*.zip && \
      fc-cache -f -v

RUN   ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \ 
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/transactional-update
