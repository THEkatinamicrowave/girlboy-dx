//
import openfl.geom.ColorTransform;

var backSprite:FunkinSprite;

function postCreate() {
	backSprite = new FunkinSprite().makeSolid(FlxG.width, FlxG.height, 0xFFFFFF);
	backSprite.scrollFactor.set();
	backSprite.zoomFactor = 0;
	backSprite.angleFactor = 0;
	backSprite.alpha = 0;
	insert(0, backSprite);
}

function onEvent(_e:EventGameEvent) {
	var e = _e.event;
	if (_e.cancelled || e.name != "Bad Apple") return;

	var p:Array<Dynamic> = e.params;
	var dadAlpha:Float = p[0];
	var bfAlpha:Float = p[1];
	var gfAlpha:Float = p[2];
	var stageAlpha:Float = p[3];
	var backAlpha:Float = p[4];
	var dadColor:FlxColor = p[5];
	var bfColor:FlxColor = p[6];
	var gfColor:FlxColor = p[7];
	var stageColor:FlxColor = p[8];
	var backColor:FlxColor = p[9];
	var rawTime:Float = p[10];
	var rawEase:String = p[11];
	var rawType:String = p[12];

	var time:Float = (rawTime == 0) ? 0.001 : rawTime * (Conductor.stepCrochet * 0.001);
	var ease = CoolUtil.flxeaseFromString(rawEase, rawType);

	colorSpr(backSprite, backAlpha, backColor, time, ease);
	for (s in stage.stageSprites) colorSpr(s, stageAlpha, stageColor, time, ease);

	if (dad != null) colorSpr(dad, dadAlpha, dadColor, time, easee);
	if (bf != null) colorSpr(bf, bfAlpha, bfColor, time, easee);
	if (gf != null) colorSpr(gf, gfAlpha, gfColor, time, easee);
}

function colorSpr(spr:FunkinSprite, alpha:Float, color:FlxColor, tweenTime:Float, tweenEase:FlxEase) {
	var oldAlpha:Float = 1 - spr.colorTransform.redMultiplier;
	var oldColor:FlxColor = spr.colorTransform.color;

	FlxTween.cancelTweensOf(spr.colorTransform);

	var targetColor = hexToGoob(color, alpha);
	var startColor = hexToGoob(oldColor, oldAlpha);

	FlxTween.tween(spr.colorTransform, {
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
