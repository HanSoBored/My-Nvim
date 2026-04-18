# Lemonade Clipboard Setup

## Problem
When using SSH from local machine to remote server, clipboard operations (yank/paste) fail because lemonade CLI defaults to connecting to `localhost` instead of the actual local machine running the lemonade server.

## Solution

### 1. Environment Variables (`~/.export`)
```bash
# LEMONADE - Auto-detect SSH client IP
export LEMONADE_HOST=$(echo $SSH_CONNECTION | awk '{print $1}')
export LEMONADE_PORT=2489
```

This automatically sets `LEMONADE_HOST` to your local machine's IP (SSH client).

### 2. Nvim Config (`init.lua`)
```lua
vim.g.clipboard = {
  name = 'lemonade',
  copy = {
    ['+'] = 'lemonade --host ' .. vim.env.LEMONADE_HOST .. ' copy',
    ['*'] = 'lemonade --host ' .. vim.env.LEMONADE_HOST .. ' copy',
  },
  paste = {
    ['+'] = 'lemonade --host ' .. vim.env.LEMONADE_HOST .. ' paste',
    ['*'] = 'lemonade --host ' .. vim.env.LEMONADE_HOST .. ' paste',
  },
  cache_enabled = false,
}
```

**Important:** Must use `--host` flag explicitly. Env var alone is not enough!

### 3. Start Lemonade Server (on local machine)
```bash
lemonade server --host 0.0.0.0 --port 2489
```

## Troubleshooting

### Check connection
```bash
source ~/.export
echo $LEMONADE_HOST  # Should show your local IP (e.g., 192.168.177.31)
lemonade --host $LEMONADE_HOST paste
```

### Test port connectivity
```bash
timeout 2 bash -c 'echo > /dev/tcp/$LEMONADE_HOST/$LEMONADE_PORT' && echo "OK" || echo "Failed"
```

### Common issues
1. **Connection refused** - Lemonade server not running on local machine
2. **Wrong IP** - Check `$SSH_CONNECTION` and `$LEMONADE_HOST`
3. **Firewall** - Port 2489 must be open on local machine

## Network Setup Example
```
Local (laptop):  192.168.177.31  <- runs lemonade server
                      |
                      | SSH
                      v
Remote (server): 10.33.2.194     <- runs nvim + lemonade client
```
