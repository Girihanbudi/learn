APP_NAME="java-learn"

# Create all environments needed in docker compose
environments:
	cd ./dev && docker-compose -p $(APP_NAME) up -d

# Do a database migration up from orm
migrateup:
	go run cmd/migration/main.go -migration=up

# Seed database with dummy
seeddb:
	go run cmd/seeding/main.go

# Run application
server:
	go run ./cmd/app/main.go

# Create application image
image:
	docker build -t $(APP_NAME)-service .

# Run a container from created image 
container:
	docker run -d -it -p 8081:8081 --name=$(APP_NAME)-service $(APP_NAME)-service

# Generate application image and run the container
rundocker: image container