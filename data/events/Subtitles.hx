//
import flixel.text.FlxText.FlxTextBorderStyle;
var subtitles:FunkinText;

function postCreate() {
	subtitles = new FunkinText(FlxG.width / 5, FlxG.height / 3, FlxG.width * 3/5, "", 36);
	subtitles.alignment = "center";
	subtitles.cameras = [camHUD];
	add(subtitles);
}

function onEvent(_e:EventGameEvent) {
	var e = _e.event;
	if (e.name != "Subtitles") return;
	var p = e.params;
	
	var co = p[0];
	var ctr = p[1];
	var t = p[2];
	var as = p[3];
	var f = p[4];
	var s = p[5];
	var c = p[6];
	var tf = p[7];
	var da = p[8];

	setSubs(co, ctr, (as ? " " : "") + t, f, s, c, tf, da);
}

function setSubs(clearOld:Bool, charsToDel:Int, textToAdd:String, newFont:String, newSize:Int, color:Int, timeToFade:Float, doAnim:Bool) {
	FlxTween.cancelTweensOf(subtitles);
	subtitles.alpha = 1;
	
	if (charsToDel > 0 && subtitles.text.length >= charsToDel)
		subtitles.text = subtitles.text.substr(0, subtitles.text.length - charsToDel);

	if (clearOld) subtitles.text = "";
	if (doAnim) subtitles.scale.set(1.4, 1.4);

	subtitles.text += textToAdd;
	subtitles.setFormat(Paths.font(newFont), newSize, color);
	subtitles.setBorderStyle(FlxTextBorderStyle.OUTLINE, 0xFF000000, newSize / 12);

	if (timeToFade != 0) new FlxTimer().start((Conductor.stepCrochet/1000) * timeToFade, ()->FlxTween.tween(subtitles, {alpha: 0}, 0.5));
}

function postUpdate(elapsed:Float)
	subtitles.scale.set(
		CoolUtil.fpsLerp(subtitles.scale.x, 1, 0.3),
		CoolUtil.fpsLerp(subtitles.scale.y, 1, 0.3)
	);