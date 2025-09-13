# --- build stage ---
FROM elixir:1.15.4-alpine AS build
WORKDIR /app

# Gerekli paketler
RUN apk add --no-cache build-base git nodejs npm openssl

# Proje dosyalarını kopyala
COPY . .

# Hex ve Rebar güncelle
RUN mix local.hex --force && mix local.rebar --force

# Prod-only bağımlılıkları indir ve derle
RUN MIX_ENV=prod mix deps.get --only prod
RUN MIX_ENV=prod mix deps.compile
RUN MIX_ENV=prod mix compile

# Assets için npm kurulumu ve build (Phoenix 1.7+)
RUN npm --prefix assets install --production
RUN npm --prefix assets run build

# Prod release oluştur
RUN MIX_ENV=prod mix release

# --- runtime stage ---
FROM alpine:3.18
RUN apk add --no-cache openssl

WORKDIR /app
COPY --from=build /app/_build/prod/rel/upward /app

ENV HOME=/app
EXPOSE 4000

# Prod server başlat
CMD ["/app/bin/upward", "start"]
