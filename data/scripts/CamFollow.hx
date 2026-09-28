// stolen from a different mod I worked on that's very dead
// it's fine tho bc I wrote the original too
//
import openfl.geom.Point;

var diroffset:Point = new Point();

final dir_offs = [ // hscript REALLY doesn't like map declarations for some reason
    0 => [-40, 0],
    1 => [0, 40],
    2 => [0, -40],
    3 => [40, 0]
];

function onPlaySingAnim(e:DirectionAnimEvent) {
    var offset = dir_offs.get(e.direction);
    if (offset == null) return;

    diroffset.setTo(offset[0], offset[1]);
}

function onCameraMove(event:CamMoveEvent) {
    event.position.x += diroffset.x;
    event.position.y += diroffset.y;
}
