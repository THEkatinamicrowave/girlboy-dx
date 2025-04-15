//
var camMove_event:FlxPoint;

function postCreate() {
    camZooming = true;
    camMove_event = null;
}

function onEvent(event:EventGameEvent) {
    if (event.event.name == "Zoom Event") {
        var params = event.event.params;

        var pos:String = params[0];
        var zAmt:Float = params[1];
        var dur:Float = params[2];
        var tEase:String = params[3];
        var tDir:String = params[4];
        var reset:Bool = params[5];

        var posArray:Array<String> = pos.split(",");

        changeZoomFactor(Std.parseFloat(posArray[0]), Std.parseFloat(posArray[1]), zAmt, dur, (tEase != "linear") ? tEase + tDir : tEase, reset);
    }
}

function changeZoomFactor(camFocusX:Float, camFocusY:Float, zoom:Float, duration:Float, tweenEase:String, resetZoomAndPos:Bool) {
    var ogZoom:Float = defaultCamZoom;

    if (resetZoomAndPos) {
        camMove_event = null;
        if (duration != 0) {
            FlxTween.num(ogZoom, Std.parseFloat(stage.stageXML.get("zoom")), (Conductor.stepCrochet / 1000) * duration, { ease: Reflect.field(FlxEase, tweenEase) }, function(val:Float) {
                defaultCamZoom = val;
                camGame.zoom = val;
            });
        } else {
            defaultCamZoom = Std.parseFloat(stage.stageXML.get("zoom"));
            camGame.zoom = zoom;
        }
    } else {
        camMove_event = FlxPoint.get(camFocusX, camFocusY);
        if (duration != 0) {
            FlxTween.num(ogZoom, zoom, (Conductor.stepCrochet / 1000) * duration, { ease: Reflect.field(FlxEase, tweenEase) }, function(val:Float) {
                defaultCamZoom = val;
                camGame.zoom = val;
            });
        } else {
            defaultCamZoom = zoom;
            camGame.zoom = zoom;
        }
    }
}

function onCameraMove(event:CamMoveEvent) {
    if (camMove_event != null) {
        event.position.x = camMove_event.x;
        event.position.y = camMove_event.y;
    }
}