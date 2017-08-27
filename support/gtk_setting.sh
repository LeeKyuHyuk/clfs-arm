#!/bin/bash
gdk-pixbuf-query-loaders --update-cache
gtk-query-immodules-2.0 --update-cache
gtk-query-immodules-3.0 --update-cache
glib-compile-schemas /usr/share/glib-2.0/schemas
