.PHONY: setup dev up down clean test

setup:
	cd app && npm install

dev:
	cd app && npm run dev

test:
	cd app && npm test

up:
	docker build -t dockerized-service ./app
	docker stop dockerized-service 2>/dev/null || true
	docker rm   dockerized-service 2>/dev/null || true
	docker run -d \
		--name dockerized-service \
		--restart always \
		-p 3000:3000 \
		--env-file app/.env \
		dockerized-service
	@echo "✅ App rodando em http://localhost:3000"

down:
	docker stop dockerized-service 2>/dev/null || true
	docker rm   dockerized-service 2>/dev/null || true

clean:
	docker stop dockerized-service 2>/dev/null || true
	docker rm   dockerized-service 2>/dev/null || true
	docker rmi  dockerized-service 2>/dev/null || true
	rm -rf app/node_modules app/coverage
