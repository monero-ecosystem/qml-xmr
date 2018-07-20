qml-xmr livereload
==============

Development environment for Monero-GUI. 

Included in this repository are:

- `qml-xmr` - a program to launch Monero related `.qml` files. Fork of [qml-livereload](https://github.com/penk/qml-livereload).
- An example Qt application that uses Monero components.

The recommended way is to use the Sublime Text 2 to edit the given `.qml` example, then compile it from SB2 by launching a custom command.

Requirements:

```
qmake --version
QMake version 3.0
Using Qt version 5.7.1 in /usr/lib/x86_64-linux-gnu
```

First compile `qml-xmr`;

> cd qml-xmr
> qmake
> sudo make

It will compile into `/usr/local/bin/qml-xmr`
