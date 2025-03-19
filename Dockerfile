FROM --platform=linux/amd64 debian:bullseye-slim

# Set environment variables
ENV RUNNER_VERSION=2.321.0

# Add build argument for Aliyun mirror option
ARG USE_ALIYUN_MIRROR=true

# Install required packages (with optional Aliyun mirror)
RUN if [ "$USE_ALIYUN_MIRROR" = "true" ]; then \
    sed -i 's|http://deb.debian.org/debian|http://mirrors.aliyun.com/debian|g' /etc/apt/sources.list && \
    sed -i 's|http://security.debian.org/debian-security|http://mirrors.aliyun.com/debian-security|g' /etc/apt/sources.list; \
    fi && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Create runner user and working directory
RUN useradd -m runner && \
    echo "runner ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

WORKDIR /home/runner

# Download and extract GitHub Actions Runner
RUN curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    rm -f ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# Copy entrypoint script and install dependencies
COPY --chown=runner:runner docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh && \
    ./bin/installdependencies.sh

# Switch to runner user
USER runner

ENTRYPOINT ["/docker-entrypoint.sh"]