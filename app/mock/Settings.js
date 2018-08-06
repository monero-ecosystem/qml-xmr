var wizardFlows = {
    "createWallet": ["e"]
}

function getPage(name){
    if(pages.hasOwnProperty(name)){
        return pages[name];
    } else {
        throw 'lulz';
    }
}

function createComponent(fn) {
    var component = Qt.createComponent(fn);
    if(!component.isReady){
        console.log(component.errorString());
    }

    return component.createObject({});
}

var defaultState = "wizardTest"