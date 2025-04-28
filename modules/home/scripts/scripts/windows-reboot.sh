#! /usr/bin/env bash

set -e

die ()
{
  echo $1
  exit 1
}

# [[ $(id -u) -eq 0 ]] || die "Root access required"

WINDOWS_BOOTNUM=$(efibootmgr | grep 'Windows Boot Manager' | cut -d' ' -f1 | cut -c5-8)

sudo /run/current-system/sw/bin/efibootmgr -n $WINDOWS_BOOTNUM
systemctl reboot
