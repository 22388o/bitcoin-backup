# Bitcoin Backup (BK)

This script was created to facilitate the backup of wallet.dat on physical devices 
whenever there is a change in the backup file.

### Setup:

```bash
$ chmod +x backup.sh
$ sudo cp ./backup.sh /usr/bin/bk
```

Configure the configuration file in `nano ~/.bk/configs.json`, you must add the path where your Bitcoin Core wallet is, by default you find it in `~/.bitcoin/wallets/wallet.dat`, after that open it your file explorer and check the name of the pendrive and put it in the configuration file.

```json
{
    "device": "Backup",
    "wallet": "/home/tests/.bitcoin/wallets/wallet.dat"
}
```
Running the software:
```bash
$ bk
2022-08-23-10:09:26 Loading configuration file.
2022-08-23-10:09:26 Searching device: Backup.
2022-08-23-10:09:26 Backup device already mounted.
Setting up watches.
Watches established.
```
