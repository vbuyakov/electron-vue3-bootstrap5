# Use Node.js LTS
FROM node:22-slim AS builder

# Set non-interactive frontend to avoid prompts
ENV DEBIAN_FRONTEND=noninteractive

# Log start of build
RUN echo "🚀 Starting build process for ARM64"

# Create a script for apt-get installs to better utilize Docker cache
RUN echo "📦 Setting up apt-get dependencies..." && \
    apt-get update && \
    mkdir -p /usr/share/man/man1 && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install system dependencies in smaller chunks
RUN echo "📦 Updating package lists..." && \
    apt-get update && \
    \
    echo "📦 Installing basic build tools..." && \
    apt-get install -y --no-install-recommends \
    build-essential \
    clang \
    curl \
    git \
    python3 \
    python3-dbusmock \
    dpkg \
    fakeroot \
    zip \
    unzip \
    bison \
    gperf \
    rpm && \
    \
    echo "📦 Installing cross-compilation tools..." && \
    apt-get install -y --no-install-recommends \
    gcc-aarch64-linux-gnu \
    g++-aarch64-linux-gnu \
    libc6-dev-arm64-cross \
    linux-libc-dev-arm64-cross && \
    \
    echo "📦 Installing GUI and system libraries..." && \
    apt-get install -y --no-install-recommends \
    libgtk-3-dev \
    libnotify-dev \
    libasound2-dev \
    libcap-dev \
    libcups2-dev \
    libxtst-dev \
    libxss1 \
    libnss3-dev \
    libdbus-1-dev && \
    \
    echo "📦 Installing Java..." && \
    apt-get install -y --no-install-recommends \
    openjdk-17-jre && \
    \
    echo "📦 Cleaning up..." && \
    rm -rf /var/lib/apt/lists/* && \
    echo "✅ Dependencies installed successfully"

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install Node.js dependencies with cache
RUN echo "📦 Installing Node.js dependencies..." && \
    npm config set cache /tmp/npm-cache --global && \
    npm ci --prefer-offline --cache /tmp/npm-cache && \
    echo "✅ Node.js dependencies installed successfully"

# Copy the rest of the application
COPY . .

# Set environment variables for ARM64 build
ENV npm_config_arch=arm64
ENV npm_config_target_arch=arm64

# Create output directory
RUN mkdir -p /app/out && chmod -R 777 /app/out

# Create build script
RUN echo '#!/bin/sh\n\
echo "🔨 Building application for ARM64..."\n\
npm run make-arm64\n\
echo "🎉 Application built successfully!"\n\
' > /app/build.sh && chmod +x /app/build.sh

# Set the entrypoint
ENTRYPOINT ["/app/build.sh"]
