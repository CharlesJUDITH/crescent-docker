# Use the official Debian base image
FROM debian:latest

# Install required dependencies
RUN apt-get update && apt-get install -y wget unzip git build-essential

# Download and install GoLang
RUN wget -O go.tar.gz https://golang.org/dl/go1.19.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go.tar.gz && rm go.tar.gz

# Set the Go environment variables
ENV PATH="/usr/local/go/bin:${PATH}"
ENV GOPATH="/go"
ENV GOBIN="/go/bin"

# Create a workspace for Go projects
RUN mkdir -p /go/src /go/bin

RUN git clone https://github.com/crescent-network/crescent.git

RUN cd crescent && git checkout v4.2.0 && make build && cp ./build/crescentd /go/bin/

EXPOSE 26656 \
       26657 \
       1317  \
       9090  \
       8080

CMD /go/bin/crescend start
