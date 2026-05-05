# ── Stage 1: Builder ──────────────────────────────────────────────────────────
FROM node:20-alpine AS builder
WORKDIR /build

COPY app/package*.json ./
RUN npm ci --silent

COPY app/ .
RUN npm run build

# ── Stage 2: Runner ───────────────────────────────────────────────────────────
FROM nginx:1.27-alpine AS runner

RUN rm /etc/nginx/conf.d/default.conf
COPY config/nginx.conf /etc/nginx/conf.d/app.conf
COPY --from=builder /build/dist /usr/share/nginx/html

EXPOSE 80
HEALTHCHECK --interval=30s --timeout=3s CMD wget -qO- http://localhost/ || exit 1
CMD ["nginx", "-g", "daemon off;"]
