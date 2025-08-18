//
import Type;

var roomsCentrePoint:FlxPoint;

var moveSpeed:Float = 0.5,
	sideSeparation:Float = 182;

var psmm:Map<FlxSprite, Array<{sprite:FlxSprite, relativePos:FlxPoint}>>; // proportionalSpriteMovementMap

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

	roomL.x = CoolUtil.fpsLerp(roomL.x, targetRoomL, 0.16);
	roomR.x = CoolUtil.fpsLerp(roomR.x, targetRoomR, 0.16);

	for (s in psmm.keys()) {
		for (entry in psmm[s]) {
			var isCharacter:Bool = Type.getClassName(Type.getClass(s)) == "funkin.game.Character";
			s.x = CoolUtil.fpsLerp(s.x, entry.relativePos.x + entry.sprite.x, isCharacter ? 1 : 0.06);
			s.y = CoolUtil.fpsLerp(s.y, entry.relativePos.y + entry.sprite.y, isCharacter ? 1 : 0.06);
		}
	}
}