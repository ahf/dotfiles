#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# Alexander Færøy <ahf@0x90.dk>
# PGP: 0x61A208E16E7CB435
#
# This script is used to read passphrases from pass(1) and feed them to
# Offline IMAP.
#
# A main-function is provided for debugging purposes.
#

import sys
import subprocess

def get_password(account):
    output = subprocess.check_output("pass %s" % account, shell=True)
    return output.splitlines()[0].decode('utf-8')

def main(argv):
    if len(argv) > 1:
        print("Password: '%s'", get_password(argv[1]))

if __name__ == '__main__':
    main(sys.argv)
