//
var screenBox:FunkinSprite;
var fadeTween:FlxTween;

function postCreate() {
	screenBox = new FunkinSprite().makeSolid(FlxG.width, FlxG.height, 0xFFFFFFFF);
	screenBox.scrollFactor.set();
	screenBox.zoomFactor = 0;
	screenBox.angleFactor = 0;
	screenBox.camera = camHUD;

	var firstEvent:Dynamic = null;
	for (e in events) {
		if (e.name != "Fade Screen") continue;

		if (firstEvent == null || e.time < firstEvent.time) firstEvent = e;
	}
	if (firstEvent == null) return;

	var p = firstEvent.params;
	screenBox.alpha = p[0];
	screenBox.color = p[2];

	setFadeLayer(p[5]);
}

function onEvent(_e:EventGameEvent) {
	var e = _e.event;
	if (e.name != "Fade Screen" || _e.cancelled) return;

	var p:Array<Dynamic> = e.params;
	var startAlpha:Float = p[0];
	var targetAlpha:Float = p[1];
	var startColor:FlxColor = p[2];
	var targetColor:FlxColor = p[3];
	var rawTime:Float = p[4] == 0 ? 0.001 : p[4];
	var olapsHUD:Bool = p[5];
	var rawEase:String = p[6];
	var rawType:String = p[7];

	var time:Float = rawTime == 0 ? 0.001 : rawTime * (Conductor.stepCrochet * 0.001);
	var ease:FlxEase = CoolUtil.flxeaseFromString(rawEase, rawType);

	fadeScreen(startAlpha, targetAlpha, startColor, targetColor, time, olapsHUD, ease);
}

function fadeScreen(startAlpha:Float, targetAlpha:Float, startColor:FlxColor, targetColor:FlxColor, duration:Float, overlapsHUD:Bool, tweenEase:FlxEase) {
	if (fadeTween != null) fadeTween.cancel();
	setFadeLayer(overlapsHUD);

	screenBox.alpha = startAlpha;
	screenBox.color = startColor;

	fadeTween = FlxTween.num(0, 1, duration, { ease: tweenEase }, (progress:Float) -> {
		screenBox.alpha = startAlpha + (targetAlpha - startAlpha) * progress;
		screenBox.color = FlxColor.interpolate(startColor, targetColor, progress);
	});
}

function setFadeLayer(overlapsHUD:Bool) {
	remove(screenBox);
	if (overlapsHUD) add(screenBox); else insert(0, screenBox);
}
