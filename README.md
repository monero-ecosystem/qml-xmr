qml-xmr
==============

### What is this?

A lightweight QML scene you can easily reload. Solves the problem of having to wait on monero-gui compiles to see your latest QML/JS changes. Components from the monero-gui repository are available to you via a submodule. Best used as a component prototyping tool.

### What is it not?

This is not a replacement of the Monero GUI. As previously mentioned, it was meant to make individual screens or components.

### Project layout

Included in this repository are:

- The folder `qml-xmr` contains a simple Qt/QML program that you should put into `/usr/local/bin/` after compiling
- The folder `app` contains an example Qt application that uses a Monero component.

### Requirements:

- Sublime Text 3 or any other IDE
- Qt 5.9 or higher
- CMake >= 3.10

```
qmake --version
QMake version 3.0
Using Qt version 5.9.7 in /home/dsc/Qt5.9/5.9.7/gcc_64/lib
```

Make sure to correctly set your environment. Consult `qtchooser -print-env`

### Installation

Either use cmake or qmake to compile the program.

#### cmake

```
cd qml-xmr
cmake .
make
sudo make install
```

If cmake cannot find your Qt installation, or it finds the wrong version use (replace path):

```sh
cd qml-xmr
cmake . -DCMAKE_PREFIX_PATH=/home/dsc/Qt5.9/5.9.7/gcc_64
make
sudo make install
```

#### qmake

```
cd qml-xmr
qmake
sudo make
```

Compiled binary will be found at `/usr/local/bin/qml-xmr`.

Update the `monero-gui` submodule:

```
git submodule init
git submodule update
```

## How to use

The recommended way is to use the Sublime Text 3 to edit `app/Mock.qml`. Launch Sublime Text 3 and make a new build system:

1. Open Sublime Text 3
2. File->Open Folder
3. Select the `app/` folder
4. In the sidebar open `Mock.qml`
2. Go to `Tools->Build System->New Build System`
3. Paste the following:

```javascript
{
    "shell_cmd": "qml-xmr $file_path/monero-gui.qml"
}
```

4. Save the file as `qml-xmr.sublime-build`
5. Go to `Tools->Build System` and select `qml-xmr`

Modify `Mock.qml` as you please. Press `CTRL-B` to run the application.

### Tips

- `app/monero-gui.qml` is the entry point of the application, you shouldn't need to edit it. It includes `Mock.qml` automatically.
- Update the submodule `monero-gui` regularly
