#!/bin/sh

#qemu-system-x86_64 -M pc -cpu host -accel kvm -smp cores=2,threads=2 -m 512M build/boot_$1
qemu-system-x86_64 build/boot_$1
