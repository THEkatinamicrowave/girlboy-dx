//
import openfl.geom.ColorTransform;

var stageCover:FlxSprite;

function postCreate() {
	stageCover = new FlxSprite().makeSolid(5*FlxG.width, 5*FlxG.height, FlxColor.WHITE);
	stageCover.alpha = 0;
	stageCover.screenCenter();

	var cs = strumLines.members.length == 2 ? [dad, bf] : [dad, bf, gf];
	var min = Math.POSITIVE_INFINITY;
	for (c in cs) if (members.indexOf(c) < min) min = members.indexOf(c);
	insert(min, stageCover);
}

function onEvent(_e:EventGameEvent) {
	var e = _e.event;
	if (e.name != "Bad Apple") return;

	var p = e.params,
		dadA = p[0],
		bfA = p[1],
		gfA = p[2],
		stageA = p[3],
		dadC = p[4],
		bfC = p[5],
		gfC = p[6],
		stageC = p[7],
		t = (p[8] == 0) ? 0.001 : (Conductor.stepCrochet/1000) * p[8],
		tw = CoolUtil.flxeaseFromString(p[9], p[10]);

	colorStage(stageA, stageC, t, tw);
	if (dad != null) colorChar(dad, dadA, dadC, t, tw);
	if (bf != null) colorChar(bf, bfA, bfC, t, tw);
	if (gf != null) colorChar(gf, gfA, gfC, t, tw);
}

function colorStage(alpha:Float, color:FlxColor, tweenTime:Float, tweenEase:FlxEase) {
	stageCover.color = color;
	FlxTween.cancelTweensOf(stageCover);

	for (s in stage.stageSprites)
		if (members.indexOf(s) > members.indexOf(bf))
			FlxTween.tween(s, { alpha: 1-alpha }, tweenTime, { ease: tweenEase });
	FlxTween.tween(stageCover, { alpha: alpha }, tweenTime, { ease: tweenEase });
}

function colorChar(character:Character, alpha:Float, color:FlxColor, tweenTime:Float, tweenEase:FlxEase) {
	var oldAlpha:Float = 1 - character.colorTransform.redMultiplier;
	var oldColor:FlxColor = character.colorTransform.color;

	FlxTween.cancelTweensOf(character.colorTransform);

	var targetColor = hexToGoob(color, alpha);
	var startColor = hexToGoob(oldColor, oldAlpha);

	FlxTween.tween(character.colorTransform, {
		redMultiplier: 1 - alpha,
		greenMultiplier: 1 - alpha,
		blueMultiplier: 1 - alpha,
		redOffset: Std.int(targetColor[0] * 255),
		greenOffset: Std.int(targetColor[1] * 255),
		blueOffset: Std.int(targetColor[2] * 255)
	}, tweenTime, { ease: tweenEase });
}

function hexToGoob(color:FlxColor, ?alpha:Float = 1):Array<Float> {
	return [
		(((color >> 16) & 0xFF) / 255) * alpha,
		(((color >> 8) & 0xFF) / 255) * alpha,
		((color & 0xFF) / 255) * alpha
	];
}

function getFlxColorFromHex(color:Array<Float>):FlxColor {
	var r = Std.int(color[0] * 255) & 0xFF;
	var g = Std.int(color[1] * 255) & 0xFF;
	var b = Std.int(color[2] * 255) & 0xFF;
	return (r << 16) | (g << 8) | b;
}