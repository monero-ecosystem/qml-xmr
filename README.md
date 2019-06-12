qml-xmr
==============

A lightweight QML scene that resembles the Monero GUI. Solves the problem of having to wait on 10 second compiles. 

### What is it not?

This is not a replacement of the Monero GUI. It is meant to make individual screens or components.

### Project layout

Included in this repository are:

- Folder `qml-xmr` contains a simple Qt/QML program that you should put into `/usr/local/bin/` after compiling
- Folder `app` contains an example Qt application that uses a Monero component.

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

#### Installation

```
cd qml-xmr
cmake . -DCMAKE_PREFIX_PATH=/home/dsc/Qt5.9/5.9.7/gcc_64.
make
sudo make install
```

If cmake cannot find your Qt installation, or it finds the wrong version use (replace path):

Compiled binary will be found at `/usr/local/bin/qml-xmr`.

#### Monero-GUI

Folder `monero-gui` is the submodule that includes the Monero GUI. In `app/` there are several 
symlinks pointing to this submodule.

Update it regularly, or alternatively symlink it to your own local version of the Monero-GUI.

```
git submodule init
git submodule update
```

## Development workflow

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

### Tip

`app/monero-gui.qml` is the entry point of the application, you shouldn't need to edit it. It includes `Mock.qml` automatically.
