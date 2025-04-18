//
var codestring:String = "";

function postCreate() codestring = "";

function postUpdate(elapsed:Float) {
    if (FlxG.keys.justPressed.G) codestring += "G";
    if (FlxG.keys.justPressed.I) codestring += "I";
    if (FlxG.keys.justPressed.R) codestring += "R";
    if (FlxG.keys.justPressed.L) codestring += "L";
    if (FlxG.keys.justPressed.B) codestring += "B";
    if (FlxG.keys.justPressed.O) codestring += "O";
    if (FlxG.keys.justPressed.Y) codestring += "Y";
    if (FlxG.keys.justPressed.E) codestring += "E";
    if (FlxG.keys.justPressed.X) codestring += "X";

	if (codestring.toLowerCase() == "girlboyexe") {
		persistentUpdate = false;
		FlxG.sound.music.stop();

		FlxG.switchState(new ModState("LoadingExe"));
	}
}
