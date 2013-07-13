# -*- Mode: Python; coding: utf-8; indent-tabs-mode: nil; tab-width: 4 -*-
### BEGIN LICENSE
# This file is in the public domain
### END LICENSE

from locale import gettext as _

from gi.repository import Gtk, WebKit # pylint: disable=E0611
import logging
logger = logging.getLogger('compensato_gui')

from compensato_gui_lib import Window
from compensato_gui.AboutCompensatoGuiDialog import AboutCompensatoGuiDialog
from compensato_gui.PreferencesCompensatoGuiDialog import PreferencesCompensatoGuiDialog

# See compensato_gui_lib.Window.py for more details about how this class works
class CompensatoGuiWindow(Window):
    __gtype_name__ = "CompensatoGuiWindow"
    
    def finish_initializing(self, builder): # pylint: disable=E1002
        """Set up the main window"""
        super(CompensatoGuiWindow, self).finish_initializing(builder)

        self.AboutDialog = AboutCompensatoGuiDialog
        self.PreferencesDialog = PreferencesCompensatoGuiDialog

        # Code for other initialization actions should be added here.

        self.compensato_gui_window = self.builder.get_object("compensato_gui_window")
        self.compensato_gui_window.maximize()

        self.scrolledwindow = self.builder.get_object("scrolledwindow")	    
        self.webview = WebKit.WebView()

        self.scrolledwindow.add(self.webview)
        self.webview.show()

        self.webview.open("http://localhost:3000")

