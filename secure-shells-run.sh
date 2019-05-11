#!/bin/sh
#$ -l rt_F=4
#$ -l h_rt=24:00:00
#$ -N secure-shells
#$ -cwd

source /etc/profile.d/modules.sh
module load openmpi/2.1.6

mpirun -npernode 1 /usr/bin/hostname
mpirun -npernode 1 /usr/sbin/sshd -D -f $HOME/abci-sandbox-sshd/sshd_config
