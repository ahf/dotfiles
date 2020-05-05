#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# Alexander Færøy <ahf@0x90.dk>
# PGP: 0x61A208E16E7CB435
#
# This script is used to read passphrases from my modified Qubes aware pass(1)
# and feed them to Offline IMAP.
#

import sys
import subprocess
import threading

class PasswordManager:
    def __init__(self):
        self._lock = threading.Lock()

    def get_password(self, account):
        password = None

        self._lock.acquire()
        try:
            output = subprocess.check_output("qubes-pass %s" % account, shell=True)
            password = output.splitlines()[0].decode('utf-8')
        finally:
            self._lock.release()

        return password

_password_manager = PasswordManager()

def get_password(account):
    return _password_manager.get_password(account)
