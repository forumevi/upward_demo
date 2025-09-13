# --- build stage ---
FROM elixir:1.15.4-alpine as build

WORKDIR /app

# Gerekli paketler
RUN apk add --no-cache build-base git nodejs npm openssl

COPY . .

RUN mix local.hex --force && mix local.rebar --force

# Prod dependencies
RUN mix deps.get --only prod
RUN mix deps.compile

# Assets
RUN npm --prefix assets install --production
RUN mix assets.deploy

# Release
RUN MIX_ENV=prod mix release

# --- runtime stage ---
FROM alpine:3.18

RUN apk add --no-cache openssl

WORKDIR /app

COPY --from=build /app/_build/prod/rel/upward /app

ENV HOME=/app
EXPOSE 4000

CMD ["/app/bin/upward", "start"]
