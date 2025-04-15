//
var topBar:FunkinSprite;
var bottomBar:FunkinSprite;

function postCreate() {
    topBar = new FunkinSprite(-FlxG.width, -FlxG.height).makeSolid(3 * FlxG.width, FlxG.height, 0xFF000000);
    bottomBar = new FunkinSprite(-FlxG.width, FlxG.height).makeSolid(3 * FlxG.width, FlxG.height, 0xFF000000);

    for (e in [topBar, bottomBar]) e.cameras = [camHUD];
}

function onEvent(event:EventGameEvent) {
    if (event.event.name == "Cinematic Bars") {
        var params = event.event.params;

        var px = params[0];
        var dur = params[1];
        var olapped = params[2];
        var tEase = params[3];
        var tDir = params[4];

        moveBars(px, dur, olapped, (tEase != "linear") ? tEase + tDir : tEase);
    }
}

function moveBars(thickness:Int, duration:Float, overlapping:Bool, tweenEase:String) {
    for (e in [topBar, bottomBar]) {
        remove(e);
        if (overlapping) add(e); else insert(0, e);
    }

    FlxTween.tween(topBar, { y: -FlxG.height + thickness/2 }, (Conductor.stepCrochet / 1000) * duration, { ease: Reflect.field(FlxEase, tweenEase) });
    FlxTween.tween(bottomBar, { y: FlxG.height - thickness/2 }, (Conductor.stepCrochet / 1000) * duration, { ease: Reflect.field(FlxEase, tweenEase) });
}