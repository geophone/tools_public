--- .basrc tweak
```bash
echo 'Defaults:$USER timestamp_type=global' \
    | sudo tee /etc/sudoers.d/tsp-pipeline >/dev/null

sudo chmod 0440 /etc/sudoers.d/tsp-pipeline

sudo visudo -cf /etc/sudoers.d/tsp-pipeline
```
