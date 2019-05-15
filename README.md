# abci-sandbox-sshd

This package provides helper scripts for running sshd on ABCI compute nodes with user privileges.

## Basic Procedure

* First clone, and generate hostkeys.

```
es $ cd ~
es $ git clone https://github.com/ogawa/abci-sandbox-sshd.git
es $ cd abci-sandbox-sshd
es $ ssh-keygen -f ./ssh_host_rsa_key -N '' -t rsa
es $ ssh-keygen -f ./ssh_host_dsa_key -N '' -t dsa
es $ cp sshd_config.tmpl sshd_config
```

* Update `abci-sandbox-sshd/sshd_config` to use your ABCI ID.

* Copy your SSH pubkey to `abci-sandbox-sshd/authorized_keys`.

* Run your own SSHD on an ABCI compute node.

```
es $ qrsh -g abci_group -l rt_F=1
gXXXX $ (cd abci-sandbox-sshd; /usr/sbin/sshd -D -f sshd_config)
```

* Connect from your local PC to sshd on the compute node.

```
clientpc $ ssh gXXXX -p 2222 -l abci_user -o ProxyJump='%r@as.abci.ai,%r@es' -A
```

To make things easier, add the following configuration to `.ssh/config` on your client PC.

```
Host gXXXX
     HostName gXXXX
     User abci_user
     ProxyJump %r@as.abci.ai,%r@es
     Port 2222
     ForwardAgent yes
```

and then,

```
clientpc $ ssh gXXXX
```

## Dispatching from a batch script

This package includes `secure-shell-run.sh` and `secure-shells-run.sh` that are example of dispatching single or multiple instances of `sshd` from a batch script.

```
es $ qsub -g abci_group abci-sandbox-sshd/secure-shell-run.sh
```

```
es $ qsub -g abci_group abci-sandbox-sshd/secure-shells-run.sh
```

## Known Issues

* These scripts do nothing for keeping environment variables. To do so, store environment variables to a file before kicking sshd, and load them after establishing SSH connections.