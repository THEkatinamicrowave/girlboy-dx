//
import flixel.FlxObject;
import Type;

var roomsCentrePoint:FlxPoint;

var moveSpeed:Float = 0.5,
	lerping:Bool = true,
	sideSeparation:Float = 182;

var psmm:Map<FlxObject, Array<{sprite:FlxSprite, relativePos:FlxPoint}>>; // proportionalSpriteMovementMap

function postCreate() {
	roomsCentrePoint = FlxPoint.get(
		roomL.x + (((roomR.x + roomR.width) - roomL.x) / 2),
		((roomL.y + (roomL.height/2)) + (roomR.y + (roomR.height/2))) / 2
	);

	psmm = [
		shatterglass => [{sprite: roomR, relativePos: FlxPoint.get(shatterglass.x - roomR.x, shatterglass.y - roomR.y)}],
		objects => [{sprite: roomL, relativePos: FlxPoint.get(objects.x - roomL.x, objects.y - roomL.y)}],
		dad => [{sprite: roomL, relativePos: FlxPoint.get(dad.x - roomL.x, dad.y - roomL.y)}],
		bf => [{sprite: roomR, relativePos: FlxPoint.get(bf.x - roomR.x, bf.y - roomR.y)}]
	];
}

function postUpdate(elapsed:Float) {
	var halfSeparation = sideSeparation / 2;
	var targetRoomL = roomsCentrePoint.x - halfSeparation - roomL.width;
	var targetRoomR = roomsCentrePoint.x + halfSeparation;

	trace("halfSeparation", halfSeparation);
	trace("targetRoomL", targetRoomL);
	trace("targetRoomR", targetRoomR);

	roomL.x = CoolUtil.fpsLerp(roomL.x, targetRoomL, lerping ? 0.16 : 1);
	roomR.x = CoolUtil.fpsLerp(roomR.x, targetRoomR, lerping ? 0.16 : 1);

	trace("roomL.x", roomL.x);
	trace("roomR.x", roomR.x);
	
	for (s=>arr in psmm) {
		for (entry in arr) {
			var isCharacter = Type.getClass(s) == Character;
			s.x = CoolUtil.fpsLerp(s.x, entry.relativePos.x + entry.sprite.x, isCharacter ? 1 : 0.06);
			s.y = CoolUtil.fpsLerp(s.y, entry.relativePos.y + entry.sprite.y, isCharacter ? 1 : 0.06);
		}
	}
}

function onEvent(_e:EventGameEvent) {
	var e = _e.event;
	if (e.name != "Corruption Stage Gap Size") return;
	
	var p = e.params;
	var s = p[0];
	var tt = p[1] == 0 ? 0.001 : p[1];

	FlxTween.cancelTweensOf(sideSeparation);
	
	var isTween = p[2] != "CLASSIC";
	if (isTween) {
		lerping = false;
		var initialVal = sideSeparation;
		var te = CoolUtil.flxeaseFromString(p[2], p[3]);

		FlxTween.num(initialVal, s, (Conductor.stepCrochet/1000) * tt, { ease: te, onComplete: ()->{
			lerping = true;
		}}, (v:Float)->{
			sideSeparation = v;
			trace("sideSeparation", sideSeparation);
		});
	} else {
		lerping = true;
		sideSeparation = e.params[0];
	}
}