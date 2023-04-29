# EDC - Everyday Carry for Linux Users

> "A man and his tools make a man and his trade"
>
> -Vita Sackville-West

> "We shape our tools and then the tools shape us"
>
> -Winston Churchill

My personal base image [toolbox](https://github.com/containers/toolbox).
It is used in conjuction with a [dotfile manager](https://dotfiles.github.io/utilities/) and designed to be the companion terminal experience for cloud-native desktops.

- Starts with the latest Arch Linux image from the [Toolbx Community Images](https://github.com/toolbx-images/images)
- Adds some quality of life
  - `zsh` prompt for that <3
  - `nvim` for text editor with LSP configured
  - `ranger` file manager
  - `chezmoi` for dotfile management
  - `btop` for process management
  - `mdp` for slides in your terminal
  - `python3`
  - `julia`
  - `tectonic` for minimal latex tool
  - `yt-dlp` to watch your stuff
  - Some common power tools: `plocate`, `fzf`, `cosign`, `ripgrep`, `detox` and `ffmpeg`
- Host Management QoL
  - These are meant for occasional one off commands, not complex workflows
    - Auto symlink the flatpak, podman, and docker commands
    - Auto symlink rpm-ostree for Fedora
    - Auto symlink transactional-update for openSUSE MicroOS

## How to use

### Create Box

If you use `distrobox`:

    distrobox create -i ghcr.io/storopoli/edc -n dev
    distrobox enter dev

If you use `toolbox`:

    toolbox create -i ghcr.io/storopoli/edc -c dev
    toolbox enter dev

### Pull down your config

Use `chezmoi` to pull down your dotfiles and set up git sync.

### Make your own

Fork and add programs to this this image - over time you'll end up with the perfect CLI for you.
Keeping it as a pet works, though the author recommends leaving all your config in git and routinely pulling a new image.

The user experience is much nicer if you [set your terminal open right in the container](https://distrobox.privatedns.org/useful_tips.html#using-distrobox-as-main-cli) and is the intended experience.

## Verification

These images are signed with sisgstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the following command:

    cosign verify --key cosign.pub ghcr.io/storopoli/edc

If you're forking this repo you should [read the docs](https://docs.github.com/en/actions/security-guides/encrypted-secrets) on keeping secrets in github. You need to [generate a new keypair](https://docs.sigstore.dev/cosign/overview/) with cosign. The public key can be in your public repo (your users need it to check the signatures), and you can paste the private key in Settings -> Secrets -> Actions.

## Finding Good Base Images

Of course you can make this however you want, but start with the [Toolbx Community images](https://github.com/toolbx-images/images).
These are a set of mostly-stock images with packages needed to run as a toolbox/distrobox already installed.

Try to derive your blingbox from those base images so we can all help maintain them over time, you can't have bling without good stock!
