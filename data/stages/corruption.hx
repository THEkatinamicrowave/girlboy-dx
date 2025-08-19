//
import flixel.FlxObject;
import Type;
import Sys;

var roomsCentrePoint:FlxPoint;

var moveSpeed:Float = 0.5,
	lerping:Bool = true,
	sideSeparation:Float = 182;

var psmm:Map<FlxSprite, Array<{sprite:FlxSprite, relativePos:FlxPoint}>>; // proportionalSpriteMovementMap

var hitboxL:FlxObject,
	hitboxR:FlxObject;

function postCreate() {
	hitboxL = new FlxObject(roomL.x, roomL.y, roomL.width, roomL.height);
	hitboxR = new FlxObject(roomR.x, roomR.y, roomR.width, roomR.height);
	add(hitboxL);
	add(hitboxR);

	roomsCentrePoint = FlxPoint.get(
		hitboxL.x + (((hitboxR.x + hitboxR.width) - hitboxL.x) / 2),
		((hitboxL.y + (hitboxL.height/2)) + (hitboxR.y + (hitboxR.height/2))) / 2
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

	hitboxL.x = CoolUtil.fpsLerp(hitboxL.x, targetRoomL, lerping ? 0.16 : 1);
	hitboxR.x = CoolUtil.fpsLerp(hitboxR.x, targetRoomR, lerping ? 0.16 : 1);
	
	var t = Sys.time()/2;
	var radius = 32;

	var xL = hitboxL.x + radius * Math.cos(t) / (1 + Math.sin(t) * Math.sin(t));
	var yL = hitboxL.y + radius * Math.cos(t) * Math.sin(t) / (1 + Math.sin(t) * Math.sin(t));

	var tR = t + 0.7; // desync
	var xR = hitboxR.x + radius * Math.cos(tR + Math.PI) / (1 + Math.sin(tR + Math.PI) * Math.sin(tR + Math.PI));
	var yR = hitboxR.y + radius * Math.cos(tR + Math.PI) * Math.sin(tR + Math.PI) / (1 + Math.sin(tR + Math.PI) * Math.sin(tR + Math.PI));

	roomL.setPosition(xL, yL);
	roomR.setPosition(xR, yR);
	
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
		});
	} else {
		lerping = true;
		sideSeparation = e.params[0];
	}
}