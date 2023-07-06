# server_sync
Bash script to automatically check for differences between you and a remote rsync server


## Prerequisites
In your home directory run the following commands, but put in your rsync password in place of the bracketed argument:
```
echo [password] > rsync_pass
chmod 600 rsync_pass
```

At the top of the script, there will be multiple bash variables containing information on your specific paths and your user information. Edit these accordingly. The local and remote paths must end in a `/`. They are:
```
REM_PATH="charger::Media/"          # Path to the remote media folder
LOC_PATH=""                         # Path to your local media folder
REM_USER=""                         # your username for the remote
PASS_FILE=""                        # absolute path to the rsync password
```

## Running the Script

```
./media-sync
```

If you get an error that the host did not resolve, see your friendly neighborhood server owner.