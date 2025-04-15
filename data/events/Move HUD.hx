//
function onEvent(event:EventGameEvent) {
    if (event.event.name == "Move HUD") {
        var params = event.event.params;

        var off = params[0];
        var dur = params[1];
        var tEase = params[2];
        var tDir = params[3];

        moveHUD(off, dur, (tEase != "linear") ? tEase + tDir : tEase);
    }
}

function moveHUD(moveOffscreen:Bool, duration:Float, tweenEase:String) {
    var movePixels = moveOffscreen ? -400 : 400;
    if (downscroll) movePixels = -movePixels;

    for(e in [healthBar, healthBarBG, iconP1, iconP2, scoreTxt, missesTxt, accuracyTxt]) {
        if (duration == 0) {
            e.y += movePixels;
        } else {
            FlxTween.tween(e, { y: e.y + movePixels }, (Conductor.stepeCrochet / 1000) * duration, { ease: Reflect.field(FlxEase, tweenEase) });
        }
    }
}