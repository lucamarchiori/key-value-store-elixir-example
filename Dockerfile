# Stage 1: Build the release
FROM elixir:1.18 AS build

WORKDIR /app

# Install hex and rebar
RUN mix local.hex --force && mix local.rebar --force

# Cache deps
COPY mix.exs ./
RUN mix deps.get

# Copy source files
COPY . .

# Compile and build release
RUN MIX_ENV=prod mix release

# Stage 2: Minimal runtime image
FROM debian:bookworm-slim AS app

RUN apt-get update && apt-get install -y libssl-dev && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy release from build stage
COPY --from=build /app/_build/prod/rel/k_v_store ./

ENV HOME=/app
ENV MIX_ENV=prod
ENV REPLACE_OS_VARS=true

# Default command to run release in foreground
CMD ["/app/bin/k_v_store", "start"]
