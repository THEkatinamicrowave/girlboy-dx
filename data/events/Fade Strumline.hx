//
function onEvent(_e:EventGameEvent) {
	var e = _e.event;
	if (e.name != "Fade Strumline") return;

	var p = e.params,
		s = p[0],
		a = p[1],
		t = p[2] == 0 ? 0.001 : p[2],
		tt = p[3],
		td = p[4];

	fadeStrumline(s, a, t, CoolUtil.flxeaseFromString(tt, td));
}

function fadeStrumline(strLine:Int, alpha:Float, time:Float, tweenEase:FlxEase) {	
	for (s in strumLines.members[strLine].members)
		FlxTween.tween(s, { alpha: alpha }, (Conductor.stepCrochet/1000) * time, { ease: tweenEase });

	for (s in strumLines.members[strLine].notes)
		FlxTween.tween(s, { alpha: alpha }, (Conductor.stepCrochet/1000) * time, { ease: tweenEase });
}