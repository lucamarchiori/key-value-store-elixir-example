# Dockerfile

# Use official Elixir image with OTP and Hex
FROM elixir:1.18

# Install Hex + Rebar (Elixir package managers/tools)
RUN mix local.hex --force && \
    mix local.rebar --force

# Set working directory
WORKDIR /app

# Copy mix files
COPY mix.exs ./

# Install dependencies
RUN mix deps.get

# Copy source files
COPY . .

# Compile the project
RUN mix compile

# Default command
CMD ["iex", "-S", "mix"]
