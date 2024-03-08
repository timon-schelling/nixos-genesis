FROM fedora AS download
WORKDIR /tmp
ARG SLACK_DOWLNOAD_URL=https://downloads.slack-edge.com/releases/linux/4.36.140/prod/x64/slack-desktop-4.36.140-amd64.deb
RUN curl -L -o slack.deb $SLACK_DOWLNOAD_URL


FROM ubuntu
WORKDIR /tmp

COPY --from=download /tmp/slack.deb /tmp/slack.deb
RUN apt update
RUN apt install -y /tmp/slack.deb
RUN apt install -y firefox
RUN apt install -y pipewire pipewire-audio-client-libraries alsa-utils wireplumber

COPY xdg-open /usr/bin/xdg-open
RUN chmod +x /usr/bin/xdg-open

COPY entrypoint /entrypoint
RUN chmod +x /entrypoint
ENTRYPOINT ["/entrypoint"]
