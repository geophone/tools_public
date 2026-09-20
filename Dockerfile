FROM nvidia/cuda:13.0.0-devel-ubuntu24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    ninja-build \
    git \
    curl \
    ca-certificates \
    libcurl4-openssl-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

RUN git clone --depth=1 https://github.com/ggml-org/llama.cpp.git

WORKDIR /opt/llama.cpp

RUN cmake -S . -B build -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DGGML_CUDA=ON \
    -DGGML_RPC=ON \
    -DGGML_NATIVE=OFF \
    -DCMAKE_CUDA_ARCHITECTURES=121 \
    -DLLAMA_CURL=ON \
    -DLLAMA_BUILD_TESTS=OFF \
    -DCMAKE_EXE_LINKER_FLAGS="-Wl,--allow-shlib-undefined" \
    && cmake --build build \
        --config Release \
        --target llama-server \
        -j"$(nproc)"

ENV PATH="/opt/llama.cpp/build/bin:${PATH}"

WORKDIR /workspace

CMD ["/bin/bash"]
