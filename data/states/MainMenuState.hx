//
import flixel.input.keyboard.FlxKey;

var codeString:String = "";

function postUpdate(elapsed:Float) {
    if (FlxG.keys.firstJustPressed() != -1) {
        var kInt = FlxG.keys.firstJustPressed();
        var k = FlxKey.toStringMap.get(kInt);
        var supportedCharList = [
            "A" => "A",
            "B" => "B",
            "C" => "C",
            "D" => "D",
            "E" => "E",
            "F" => "F",
            "G" => "G",
            "H" => "H",
            "I" => "I",
            "J" => "J",
            "K" => "K",
            "L" => "L",
            "M" => "M",
            "N" => "N",
            "O" => "O",
            "P" => "P",
            "Q" => "Q",
            "R" => "R",
            "S" => "S",
            "T" => "T",
            "U" => "U",
            "V" => "V",
            "W" => "W",
            "X" => "X",
            "Y" => "Y",
            "Z" => "Z",

            "ZERO" => "0",
            "ONE" => "1",
            "TWO" => "2",
            "THREE" => "3",
            "FOUR" => "4",
            "FIVE" => "5",
            "SIX" => "6",
            "SEVEN" => "7",
            "EIGHT" => "8",
            "NINE" => "9",

            "PERIOD" => ".",
            "COMMA" => ",",
            "SEMICOLON" => ";",
            "QUOTE" => "'",
            "SLASH" => "/",
            "MINUS" => "-"
        ];
        if (supportedCharList.exists(k)) codeString += supportedCharList.get(k);
    }

    if (codeString.toLowerCase() == "runkillprgm.exe") {
		persistentUpdate = false;
		FlxG.sound.music.stop();

		FlxG.switchState(new ModState("LoadingExe"));
    }
}