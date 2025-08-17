//
var doingIt:Bool = false;
var angleMult:Int = 1;

function onEvent(_e:EventGameEvent) {
    if (_e.event.name != "Cool Strumlines") return;
    doingIt = _e.event.params[0];
}

function postUpdate(elapsed:Float)
    camHUD.angle = CoolUtil.fpsLerp(camHUD.angle, 0, 0.1);

function beatHit(beat:Int)
    if (doingIt && beat % camZoomingInterval == 0) {
        angleMult = 0 - angleMult;
        camHUD.angle = 5*angleMult;
    }