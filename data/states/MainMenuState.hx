//
import flixel.input.keyboard.FlxKey;

var codeString:String = "";
final supportedCharList = [
	"A" => "A", "B" => "B", "C" => "C", "D" => "D", "E" => "E", "F" => "F", "G" => "G", "H" => "H", "I" => "I", "J" => "J", "K" => "K", "L" => "L", "M" => "M", "N" => "N", "O" => "O", "P" => "P", "Q" => "Q", "R" => "R", "S" => "S", "T" => "T", "U" => "U", "V" => "V", "W" => "W", "X" => "X", "Y" => "Y", "Z" => "Z",
	"ZERO" => "0", "ONE" => "1", "TWO" => "2", "THREE" => "3", "FOUR" => "4", "FIVE" => "5", "SIX" => "6", "SEVEN" => "7", "EIGHT" => "8", "NINE" => "9",
	"PERIOD" => ".", "COMMA" => ",", "SEMICOLON" => ";", "QUOTE" => "'", "SLASH" => "/", "MINUS" => "-"
];

function postCreate() {
	for (i => item in menuItems.members) {
		item.y = 30 + (i * 160);
	}
}

function postUpdate(elapsed:Float) {
	var kInt = FlxG.keys.firstJustPressed();
	if (kInt == -1) return;

	var keyName = FlxKey.toStringMap.get(kInt);
	if (!supportedCharList.exists(keyName)) return;

	codeString += supportedCharList.get(keyName);

	if (codeString.toLowerCase() == "runkillprgm.exe") {
		persistentUpdate = false;
		FlxG.sound.music.stop();
		FlxG.switchState(new ModState("LoadingExe"));
	}
}

function onSelectItem(event:NameEvent) {
	switch(event.name) {
		case 'wuffstudio':
			selectedSomethin = false;
			menuItems.members[curSelected].visible = true;
			FlxG.openURL('https://discord.gg/BcwAfRcWGj');
	}
}