#!/usr/bin/python
# -*- Mode: Python; coding: utf-8; indent-tabs-mode: nil; tab-width: 4 -*-
### BEGIN LICENSE
# This file is in the public domain
### END LICENSE

import sys
import os.path
import unittest
sys.path.insert(0, os.path.realpath(os.path.join(os.path.dirname(__file__), "..")))

from compensato_gui import AboutCompensatoGuiDialog

class TestExample(unittest.TestCase):
    def setUp(self):
        self.AboutCompensatoGuiDialog_members = [
        'AboutDialog', 'AboutCompensatoGuiDialog', 'gettext', 'logger', 'logging']

    def test_AboutCompensatoGuiDialog_members(self):
        all_members = dir(AboutCompensatoGuiDialog)
        public_members = [x for x in all_members if not x.startswith('_')]
        public_members.sort()
        self.assertEqual(self.AboutCompensatoGuiDialog_members, public_members)

if __name__ == '__main__':    
    unittest.main()
