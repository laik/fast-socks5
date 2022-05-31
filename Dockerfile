FROM yametech/rust:latest as cargo-build

WORKDIR /usr/src/fast-socks5

ADD . .

# ADD config ${HOME}/.cargo/config

RUN rm -f target/x86_64-unknown-linux-musl/release/deps/fast-socks5*

RUN RUSTFLAGS=-Clinker=musl-gcc cargo build --release --target=x86_64-unknown-linux-musl

FROM alpine:latest

COPY --from=cargo-build /usr/src/fast-socks5/target/x86_64-unknown-linux-musl/release/fast-socks5 /usr/local/bin/fast-socks5

ENTRYPOINT ["/usr/local/bin/fast-socks5"]