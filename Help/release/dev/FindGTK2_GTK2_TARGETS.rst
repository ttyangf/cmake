FindGTK2_GTK2_TARGETS
---------------------

* The `GTK2_LIBRARIES` variable created by the :module:`FindGTK2` module
  now contains the targets instead of the paths to the libraries if
  `GTK2_USE_IMPORTED_TARGETS` is enabled. Moreover it adds a new
  `GTK2_TARGETS` variable  containing all the targets imported.
