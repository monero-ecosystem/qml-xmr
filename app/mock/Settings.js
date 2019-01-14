function createComponent(fn) {
    var component = Qt.createComponent(fn);
    if(!component.isReady){
        console.log(component.errorString());
    }

    return component.createObject({});
}

