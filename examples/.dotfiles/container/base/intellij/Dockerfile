FROM debian AS download
WORKDIR /tmp
RUN apt-get update && apt-get install -y curl
RUN curl -L -o idea.tar.gz https://download-cdn.jetbrains.com/idea/ideaIC-2023.3.4.tar.gz
RUN tar -xzf idea.tar.gz
RUN mv idea-* /opt/idea

FROM debian
COPY --from=download /opt/idea /opt/idea
ENV PATH="/opt/idea/bin:${PATH}"
RUN apt-get update && apt-get install -y default-jdk git podman sudo && apt-get clean
COPY podman /usr/bin/podman
RUN chmod +x /usr/bin/podman && ln -s /usr/bin/podman /usr/bin/docker
ENV DOCKER_HOST=unix:///tmp/podman/podman.sock
RUN echo "ALL ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
COPY entrypoint /entrypoint
RUN chmod +x /entrypoint
ENTRYPOINT ["/entrypoint"]
