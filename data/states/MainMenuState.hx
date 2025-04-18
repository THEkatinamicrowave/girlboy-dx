//
import funkin.backend.MusicBeatTransition;

var codestring:String = "";

function postCreate() {
	codestring = "";
}

function postUpdate(elapsed:Float) {
    var keyMap = ["G", "I", "R", "L", "B", "O", "Y", "E", "X"];
    for (key in keyMap) {
        if (FlxG.keys.justPressed[key]) {
            codestring += key;
        }
    }

	if (codestring.toLowerCase() == "girlboyexe") {
		persistentUpdate = false;
		FlxG.sound.music.stop();

		MusicBeatTransition.script = "data/scripts/broken";
		FlxG.switchState(new ModState("LoadingExe"));
	}

	if (FlxG.keys.justPressed.ANY) {
		trace(codestring);
	}
}
