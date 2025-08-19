//

var textShit:FunkinText;
var curLine:Int = 0;
var defaultHeader:String = "Friday Night Funkin' Codename Engine: Girlboy.xml DX Mod.\n\n";

var lines:Array<{t:String, w:Float, c:Bool}> = [ // text, waittime, clear
	{t: "Loading assets...", w: 2, c: false},
	{t: "\n\nERROR: corrupted file detected.", w: 0.5, c: false},
	{t: "\nAttempting to fix...", w: 0.1, c: false},
	{t: "\n\nFAILURE: file could not be fixed.", w: 2, c: false},
	{t: "\nAttempting workaround...", w: 5, c: false},
	{t: "\nAwaiting permissions...", w: 9, c: false},
	{t: "\n\nPermission denied.\nForging permissions...", w: 4, c: false},
	{t: "\nPermissions forged!", w: 2.3, c: false},
	{t: "Running...", w: 5, c: true}
];

function create() {
	textShit = new FunkinText(5, 5, FlxG.width - 10, defaultHeader, 24);
	add(textShit);
	runTextLines();
}

function runTextLines() {
	if (curLine >= lines.length) {
		killText();
		return;
	}
	var l = lines[curLine];
	if (l.c) textShit.text = defaultHeader;
	textShit.text += l.t;

	new FlxTimer().start(l.w, ()->{
		curLine++;
		runTextLines();
	});
}

function killText() {
	textShit.text = "";
	new FlxTimer().start(1, ()->{
		PlayState.loadSong("corruption");
		FlxG.switchState(new PlayState());
	});
}