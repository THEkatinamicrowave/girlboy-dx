//
var screenBox:FunkinSprite;

var startAlpha:Bool;
var startColor:FlxColor;
var startOlapping:Bool;

function postCreate() {
    screenBox = new FunkinSprite(-FlxG.width, -FlxG.height).makeSolid(3*FlxG.width, 3*FlxG.height, 0xFFFFFFFF);
    screenBox.cameras = [camHUD];

    if (SONG.meta.customValues != null) {
        screenBox.alpha = (SONG.meta.customValues.startAlpha != null) ? SONG.meta.customValues.startAlpha : 0;
        screenBox.color = (SONG.meta.customValues.startColor != null) ? SONG.meta.customValues.startColor : 0xFF000000;

        if (SONG.meta.customValues.startOlapping != null && SONG.meta.customValues.startOlapping == "true")
            add(screenBox);
        else 
            insert(0, screenBox);
    }
}

function onEvent(_e:EventGameEvent) {
    var e = _e.event;
    if (e.name == "Fade Screen") {
        var p = e.params;

        var a = p[0];
        var c = p[1];
        var d = p[2] == 0 ? 0.001 : p[2];
        var o = p[3];
        var te = p[4];
        var td = p[5];

        fadeScreen(a, c, d, o, CoolUtil.flxeaseFromString(te, td));
    }
}

function fadeScreen(alpha:Float, color:FlxColor, duration:Float, overlapping:Bool, tweenEase:FlxEase) {
    var firstColor:FlxColor = screenBox.color;
    var firstAlpha:Float = screenBox.alpha;

    remove(screenBox);
    if (overlapping) add(screenBox); else insert(0, screenBox);

    FlxTween.color(screenBox, (Conductor.stepCrochet/1000) * duration, firstColor, color, { ease: tweenEase });
    FlxTween.num(firstAlpha, alpha, (Conductor.stepCrochet/1000) * duration, { ease: tweenEase }, (v:Float) -> {
        screenBox.alpha = v;
    });
}