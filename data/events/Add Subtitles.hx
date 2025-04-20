//
var subtitle:FunkinText;

function postCreate() {
    subtitle = new FunkinText(0, 0, FlxG.width, "", 36, true);
    subtitle.alignment = "center";
    subtitle.borderSize = 2;
    subtitle.cameras = [camHUD];
    subtitle.screenCenter();
    subtitle.y = 200;
    add(subtitle);
}

function onEvent(event:EventGameEvent) {
    if (event.event.name == "Add Subtitles") {
        var params = event.event.params;

        var text = params[0];
        var color = params[1];
        var size = params[2];
        var action = params[3];

        switch (action) {
            case "Clear":
                clearText();
                addText(text);
            case "Add":
                addText(text);
            case "New Line":
                lineBreak();
                addText(text);
        }

        subtitle.color = color;
        subtitle.size = size;
    }
}

function addText(text:String) {
    subtitle.text += (" " + text);
}

function clearText() {
    subtitle.text = "";
}

function lineBreak() {
    subtitle.text += "\n";
}