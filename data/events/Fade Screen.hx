//
var screenBox:FunkinSprite;

var startDead:Bool;
var startColor:FlxColor;
var startOlapping:Bool;

function postCreate() {
    screenBox = new FunkinSprite(-FlxG.width, -FlxG.height).makeSolid(3*FlxG.width, 3*FlxG.height, 0xFFFFFFFF);
    screenBox.cameras = [camHUD];

    if (SONG.meta.customValues != null) {
        if (SONG.meta.customValues.startDead != null) {
            screenBox.alpha = (SONG.meta.customValues.startDead == "true") ? 1 : 0;
        } else {
            screenBox.alpha = 0;
        }

        if (SONG.meta.customValues.startColor != null) {
            screenBox.color = SONG.meta.customValues.startColor;
        } else {
            screenBox.color = 0xFF000000;
        }

        if (SONG.meta.customValues.startOlapping != null) {
            if (SONG.meta.customValues.startOlapping == "true")
                add(screenBox);
            else 
                insert(0, screenBox);
        } else {
            insert(0, screenBox);
        }
    }
}

function onEvent(event:EventGameEvent) {
    if (event.event.name == "Fade Screen") {
        var params = event.event.params;

        var tog = params[0];
        var col = params[1];
        var dur = params[2];
        var olaps = params[3];
        var tEase = params[4];
        var tDir = params[5];

        fadeScreen(tog, col, dur, olaps, (tEase != "linear") ? tEase + tDir : tEase);
    }
}

function fadeScreen(toggle:Bool, color:FlxColor, duration:Float, overlapping:Bool, tweenEase:String) {
    var firstColor:FlxColor = screenBox.color;
    var firstAlpha:Float = screenBox.alpha;

    remove(screenBox);
    if (overlapping) add(screenBox); else insert(0, screenBox);

    if (duration != 0) {
        FlxTween.color(screenBox, (Conductor.stepCrochet / 1000) * duration, firstColor, color, { ease: Reflect.field(FlxEase, tweenEase) });
        FlxTween.num(firstAlpha, toggle ? 1 : 0, (Conductor.stepCrochet / 1000) * duration, { ease: Reflect.field(FlxEase, tweenEase) }, function(val:Float) {
            screenBox.alpha = val;
        });
    } else {
        screenBox.alpha = toggle ? 1 : 0;
        screenBox.color = color;
    }
}