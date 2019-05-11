#!/bin/sh
#$ -l rt_F=1
#$ -l h_rt=24:00:00
#$ -N secure-shell
#$ -cwd

/usr/bin/hostname
(cd abci-sandbox-sshd; /usr/sbin/sshd -D -f sshd_config)
