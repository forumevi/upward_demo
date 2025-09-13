# --- Build Stage ---
FROM elixir:1.15.4-alpine AS build

# OS bağımlılıkları
RUN apk add --no-cache build-base git nodejs npm openssl bash

# Hex ve Rebar güncelleme
RUN mix local.hex --force && mix local.rebar --force

# Çalışma dizini
WORKDIR /app

# Mix dosyalarını kopyala ve deps yükle
COPY mix.exs mix.lock ./
RUN mix deps.get --only prod
RUN mix deps.compile

# Config, lib ve assets dosyalarını kopyala
COPY config config
COPY lib lib
COPY assets assets

# Assets derle
RUN npm --prefix assets install --production
RUN MIX_ENV=prod mix assets.deploy

# Prod release oluştur
RUN MIX_ENV=prod mix release

# --- Runtime Stage ---
FROM alpine:3.18 AS app
RUN apk add --no-cache bash openssl ncurses-libs

WORKDIR /app

# Build stage’den release’i al
COPY --from=build /app/_build/prod/rel/upward ./

# Prod server için entrypoint
ENV MIX_ENV=prod
ENV PORT=4000
EXPOSE 4000

CMD ["bin/upward", "start"]
