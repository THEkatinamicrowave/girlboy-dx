//
var topBar:FunkinSprite,
	bottomBar:FunkinSprite;

function postCreate() {
	topBar = new FunkinSprite(-FlxG.width, -FlxG.height).makeSolid(3 * FlxG.width, FlxG.height, 0xFF000000);
	bottomBar = new FunkinSprite(-FlxG.width, FlxG.height).makeSolid(3 * FlxG.width, FlxG.height, 0xFF000000);

	for (e in [topBar, bottomBar]) e.cameras = [camHUD];
}

function onEvent(_e:EventGameEvent) {
	var e = _e.event;
	if (e.name != "Cinematic Bars") return;

	var p = e.params,
		t = p[0],
		d = p[1] == 0 ? 0.001 : p[1],
		o = p[2],
		tt = p[3],
		td = p[4];

	moveBars(t, d, o, CoolUtil.flxeaseFromString(tt, td));
}

function moveBars(thickness:Int, duration:Float, overlapping:Bool, tweenEase:FlxEase) {
	for (e in [topBar, bottomBar]) {
		remove(e);
		if (overlapping) add(e); else insert(0, e);
	}

	FlxTween.tween(topBar, { y: -FlxG.height + thickness/2 }, (Conductor.stepCrochet/1000) * duration, { ease: tweenEase });
	FlxTween.tween(bottomBar, { y: FlxG.height - thickness/2 }, (Conductor.stepCrochet/1000) * duration, { ease: tweenEase });
}