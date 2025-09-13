# --- build stage ---
FROM hexpm/elixir:1.15.4-erlang-26.3-alpine-3.18 as build

WORKDIR /app

# Gerekli paketler
RUN apk add --no-cache build-base git nodejs npm openssl

# Proje dosyalarını kopyala
COPY . .

# Hex ve Rebar setup
RUN mix local.hex --force && mix local.rebar --force

# Prod dependencies
RUN mix deps.get --only prod

# Assets kurulumu ve derlemesi
RUN npm --prefix assets install --production
RUN mix assets.deploy

# Prod release oluştur
RUN MIX_ENV=prod mix release

# --- runtime stage ---
FROM alpine:3.18

# OpenSSL ve gerekli temel paketler
RUN apk add --no-cache openssl

WORKDIR /app

# Build stage’den prod release’i kopyala
COPY --from=build /app/_build/prod/rel/upward /app

ENV HOME=/app
EXPOSE 4000

# Uygulamayı başlat
CMD ["/app/bin/upward", "start"]
