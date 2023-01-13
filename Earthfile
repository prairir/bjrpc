
# zig build
zig:
    FROM debian:bookworm

    # can be overridden
    ARG VERSION="0.11.0-dev.1241+0507ced8c"

    # stuff for curl
    RUN apt-get update \
        && apt-get install --yes --no-install-recommends curl=7.* ca-certificates=2021* xz-utils=5.* \
        && rm -rf /var/lib/apt/lists/*

    # download with curl
    RUN curl -o zig.tar.xz -S https://ziglang.org/builds/zig-linux-x86_64-$VERSION.tar.xz  \
        && tar -xf zig.tar.xz \
        && rm -Rf zig.tar.xz \
        && mv zig-linux-x86_64-$VERSION zig

    # save zig folder
    SAVE ARTIFACT zig

os:
    # base operating system for containers
    FROM debian:bookworm

    # copy zig into base os
    COPY +zig/zig /zig

# install deps here
deps:
    FROM +os

    # install cs certs and curl
    RUN apt-get update \
        && apt-get install --yes --no-install-recommends curl=7.* ca-certificates=2021* \
        && rm -rf /var/lib/apt/lists/*

# build code go here
build:
    FROM +deps

    WORKDIR /app

    COPY build.zig .

    COPY --dir src ./

    RUN /zig/zig build

    SAVE ARTIFACT zig-out/bin/bjrpc-server AS LOCAL bjrpc-server
