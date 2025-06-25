Installation of QT 4.8.7 for Bernese V 5.4 Menu
-----------------------------------------------

The Bernese GNSS Software V5.4 Menu is based on QT 4. We have tested the BSW 5.4
menu with the last QT 4 release, version 4.8.7.

Installation:
-------------
 - Download QT 4.8.7
   e.g. https://download.qt.io/archive/qt/4.8/4.8.7/qt-everywhere-opensource-src-4.8.7.tar.gz
 - Compile QT 4.8.7:
   - extract the downloaded qt evereywhere package
   - go into the unpacked directory
   - run the configure tool including the installation path:
     > ./configure -release -opensource -static -qt-zlib -no-gif -qt-libpng -qt-libmng -qt-libtiff -qt-libjpeg -nomake examples -nomake demos -nomake docs -nomake translations -prefix /to/be/installed/path
   - compile QT
     > make
   - install QT
     > make install

Note that QT 4.8.7 is based on the C++ standard 98. Newer g++ compilers which are
provided by the latest installation are supporting newer standards by default but
support the standard 98. In order to activate the 1998 C++ support the 
corresponding compiler flag needs to be added to the QT installation. 
For this purpose, the compiler options (e.g. mkspecs/linux-g++-64/qmake.conf) 
need to extended by the line:

QMAKE_CXXFLAGS        = $$QMAKE_CFLAGS -std=gnu++98

After this modification QT 4.8.7 can be compiled by g++ up to version 8.


Additional modification for g++ >= 9
------------------------------------
With the release of the compiler version g++ 9 the compiler is behaving for 
specific break statements differently compared to previous versions. This issue
is affecting QT 4.8.7 which will lead to compilation errors. The issue can
fixed by modifying 

src/corelib/global/qglobal.h

according to following bug fix report:

https://github.com/qt/qtbase/commit/c35a3f519007af44c3b364b9af86f6a336f6411b
(accessed July 2022)

Additional modification for g++ >= 11
-------------------------------------
With g++ 11 the comparison of pointer with integer zero is no longer supported.
As this is used in one subroutine in QT 4.8.7, the code needs to be modified:

tools/linguist/linguist/messagemodel.cpp

according to

https://aur.archlinux.org/cgit/aur.git/tree/qt4-gcc11.patch?h=qt4
(accessed July 2022)



