# Use a base image with Python pre-installed
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Update and install necessary packages
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends gcc libffi-dev musl-dev ffmpeg aria2 python3-pip curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the requirements file into the container
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code into the container
COPY . .

# Expose port 8989 for health check
EXPOSE 8989

# Run a simple HTTP server in the background to pass health checks and the main Python script
CMD python3 -m http.server 8989 & python3 modules/main.py
