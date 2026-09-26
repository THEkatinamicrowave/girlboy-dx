// it is so not worth making a separate event for this thing it only happens once
//
import funkin.backend.utils.FlxInterpolateColor;
var ci:FlxInterpolateColor;

function create() ci = new FlxInterpolateColor(0xFFFFFF);

function onEvent(_e:EventGameEvent) {
	var e = _e.event;
	if (PlayState.difficulty.toLowerCase() != "dx" || _e.cancelled || e.name != "Bad Apple") return;

	uiBadApple(e.params[3]);
}

function uiBadApple(mix:Float) {
	ci.color = 0xFFFFFF;
	ci.lerpTo(0xFFFFFF, mix);
	camHUD.color = ci.color;
}