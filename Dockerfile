# Simple Docker image for demo
FROM ubuntu:latest

# Add a simple test command
RUN apt-get update && apt-get install -y curl

# Set working directory
WORKDIR /app

# Copy everything into container
COPY . .

# Command to run when the container starts
CMD ["echo", "Hello from Docker container!"]
