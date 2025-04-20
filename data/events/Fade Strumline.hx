//
function onEvent(event:EventGameEvent) {
    if (event.event.name == "Fade Strumline") {
        var params = event.event.params;

        var sl = params[0];
        var alpha = params[1];
        var time = params[2];
        var type = params[3];
        var dir = params[4];

        var td:FlxEase = Reflect.field(FlxEase, (type != "linear") ? type + dir : type);
        if (time == 0) time = 0.001;

        fadeStrumline(sl, alpha, time, td);
    }
}

function fadeStrumline(sl:Int, alpha:Float, time:Float, td:FlxEase) {    
    for (s in strumLines.members[sl].members) {
        FlxTween.tween(s, { alpha: alpha }, (Conductor.stepCrochet / 1000) * time, { ease: td });
    }
    for (s in strumLines.members[sl].notes) {
        FlxTween.tween(s, { alpha: alpha }, (Conductor.stepCrochet / 1000) * time, { ease: td });
    }
}