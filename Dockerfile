FROM thecodingmachine/gotenberg:6.4.4

# Switch to root
USER root

# Install Google Chrome version 111.0.5563.146-1
RUN curl https://dl.google.com/linux/linux_signing_key.pub | apt-key add - &&\
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list &&\
    apt-get update &&\
    apt-get install --no-install-recommends -y --allow-unauthenticated google-chrome-stable=111.0.5563.146-1 &&\
    rm -rf /var/lib/apt/lists/*

# Switch back to gotenberg user
USER gotenberg