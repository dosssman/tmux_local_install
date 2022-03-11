## Install libevent dep

1. Run the `tmux_local_install.sh`. The main thing to configure is `$LOCAL_DIR`.

2. Add `$LOCAL_DIR/bin` to the `PATH` env. variable

```bash
export PATH=$LOCAL_DIR/bin:$PATH
```

3. Add `$LOCAL_DIR/lib` to the `LD_LIBRARY_PATH` env. variable

```bash
export LD_LIBRARY_PATH=$LOCAL_DIR/lib:$LD_LIBRARY_PATH
```

