# --- Build Stage ---
FROM elixir:1.15.4-alpine AS build

# Set working dir
WORKDIR /app

# Install dependencies
RUN apk add --no-cache build-base git nodejs npm openssl bash

# Install Hex + Rebar
RUN mix local.hex --force && mix local.rebar --force

# Copy project files
COPY mix.exs mix.lock ./
COPY config config
COPY lib lib
COPY assets assets

# Get prod dependencies
RUN MIX_ENV=prod mix deps.get --only prod
RUN MIX_ENV=prod mix deps.compile

# Compile project
RUN MIX_ENV=prod mix compile

# Install npm dependencies for assets
RUN npm --prefix assets install --production

# Deploy assets
RUN MIX_ENV=prod mix assets.deploy

# --- Release Stage ---
FROM elixir:1.15.4-alpine AS app

WORKDIR /app

# Install runtime dependencies
RUN apk add --no-cache openssl bash nodejs

# Copy release from build stage
COPY --from=build /app/_build/prod/rel/upward ./

# Expose Phoenix default port
EXPOSE 4000

# Start the release
CMD ["bin/upward", "start"]
