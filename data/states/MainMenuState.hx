//
var codestring:String = "";

function postCreate() codestring = "";

function postUpdate(elapsed:Float) {
    trace(codestring);
    if (FlxG.keys.justPressed.R) codestring += "R";
    if (FlxG.keys.justPressed.U) codestring += "U";
    if (FlxG.keys.justPressed.N) codestring += "N";
    if (FlxG.keys.justPressed.K) codestring += "K";
    if (FlxG.keys.justPressed.I) codestring += "I";
    if (FlxG.keys.justPressed.L) codestring += "L";
    if (FlxG.keys.justPressed.P) codestring += "P";
    if (FlxG.keys.justPressed.G) codestring += "G";
    if (FlxG.keys.justPressed.M) codestring += "M";
    if (FlxG.keys.justPressed.PERIOD) codestring += ".";
    if (FlxG.keys.justPressed.E) codestring += "E";
    if (FlxG.keys.justPressed.X) codestring += "X";

    if (codestring.toLowerCase() == "runkillprgm.exe") {
		persistentUpdate = false;
		FlxG.sound.music.stop();

		FlxG.switchState(new ModState("LoadingExe"));
	}
}
