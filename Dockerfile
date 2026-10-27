FROM debian:bookworm-slim AS build

RUN apt-get update \
    && apt-get install -y --no-install-recommends gcc g++ make \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src
COPY Makefile LZSS.C ./
RUN make build/LZSS

FROM debian:bookworm-slim

COPY --from=build /src/build/LZSS /usr/local/bin/lzss
WORKDIR /data
ENTRYPOINT ["lzss"]
