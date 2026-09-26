//
import openfl.geom.Point;

var ogScale:Float = 0.7;
var ogPos:Point;

function postCreate() {
    ogPos = new Point(x, y);
}

function update(elapsed:Float) {
    scaleSkewSprite(CoolUtil.fpsLerp(skew.x, 0, 0.15), CoolUtil.fpsLerp(scale.x, ogScale, 0.15), CoolUtil.fpsLerp(scale.y, ogScale, 0.15));
}

function onPlaySingAnim(event:DirectionAnimEvent) {
    switch (event.direction) {
        default: return;
        case 0: scaleSkewSprite(5, ogScale, ogScale);
        case 1: scaleSkewSprite(0, ogScale * 1.1, ogScale * 0.9);
        case 2: scaleSkewSprite(0, ogScale, ogScale * 1.05);
        case 3: scaleSkewSprite(-5, ogScale, ogScale);
    }
}

function onDance(event:DanceEvent) {
    scaleSkewSprite(0, ogScale * 1.05, ogScale * 0.95);
}

function scaleSkewSprite(skewX:Float, scaleX:Float, scaleY:Float) {
    scale.set(scaleX, scaleY);
    skew.set(skewX, 0);

    if (ogPos != null) setPosition(
        ogPos.x - (ogScale * height * Math.tan(skewX * Math.PI / 180)) / 2,
        ogPos.y + (height * (ogScale - scaleY)) / 2
    );
}
