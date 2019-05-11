## abci-sandbox-sshd

### Procedure

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

* Run your own SSHD on a GPU host.

```
es $ qrsh -g abci_group -l rt_F=1
gXXXX $ (cd abci-sandbox-sshd; /usr/sbin/sshd -D -f sshd_config)
```

* Connect from your local PC to SSHD@GPU host.

```
clientpc $ ssh gXXXX -p 2222 -l abci_user -o ProxyJump='%r@as.abci.ai,%r@es' -A
```

To make things easier, add the following configuration to .ssh/config on your client PC.

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
