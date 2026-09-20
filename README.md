# .basrc tweak
```bash
echo 'Defaults:$USER timestamp_type=global' \
    | sudo tee /etc/sudoers.d/tsp-pipeline >/dev/null

sudo chmod 0440 /etc/sudoers.d/tsp-pipeline

sudo visudo -cf /etc/sudoers.d/tsp-pipeline
```

# Dockerfile
A dockerfile to run llama-server inside so that there isn't permissions issues from mcp tooling or otherwise

Build with 
```bash
docker build . -t llama-gb10
```
Run with
```bash
docker run --rm -it \
    --gpus all \
    --network host \
    --ipc host \
    -v "$HOME/.cache/huggingface/hub/:/models:ro" \
    llama-gb10
```

Test with
```
nvidia-smi

llama-server \
    --rpc 10.50.0.2:50052 \
    --list-devices
```
