FROM rust as build
WORKDIR /build
COPY ./Cargo.lock ./Cargo.lock
COPY ./Cargo.toml ./Cargo.toml
COPY ./src ./src
RUN cargo build --release

FROM node:lts
RUN npm install -g asar

COPY --from=build /build/target/release/patch /usr/local/bin/patch
RUN chmod +x /usr/local/bin/patch

COPY . /app
WORKDIR /app
RUN chmod +x /app/entrypoint
ENTRYPOINT [ "/app/entrypoint" ]
