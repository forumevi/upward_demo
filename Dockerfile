# --- build stage ---
FROM hexpm/elixir:1.15.4-erlang-26.3-alpine as build
WORKDIR /app
RUN apk add --no-cache build-base git nodejs npm openssl
COPY . .
RUN mix local.hex --force && mix local.rebar --force
RUN mix deps.get --only prod
RUN npm --prefix assets install --production
RUN mix assets.deploy
RUN MIX_ENV=prod mix release

# --- runtime ---
FROM alpine:3.18
RUN apk add --no-cache openssl
WORKDIR /app
COPY --from=build /app/_build/prod/rel/upward /app
ENV HOME=/app
EXPOSE 4000
CMD ["/app/bin/upward", "start"]
