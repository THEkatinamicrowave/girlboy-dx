//
import flixel.FlxObject;
import Type;
import Sys;

var roomsCentrePoint:FlxPoint;

var shakeIntensity:Float = 0,
	elapsedTimer:Float = 0,
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
	
	elapsedTimer += elapsed * (1 / (1 + shakeIntensity * 0.5));
	var t = elapsedTimer / (2 - (0.08 * shakeIntensity));
	var radius = 32 + (3.2*shakeIntensity);

	var xL = hitboxL.x + radius * Math.cos(t) / (1 + Math.sin(t) * Math.sin(t));
	var yL = hitboxL.y + radius * Math.cos(t) * Math.sin(t) / (1 + Math.sin(t) * Math.sin(t));

	var tR = t + 0.7; // desync
	var xR = hitboxR.x + radius * Math.cos(tR + Math.PI) / (1 + Math.sin(tR + Math.PI) * Math.sin(tR + Math.PI));
	var yR = hitboxR.y + radius * Math.cos(tR + Math.PI) * Math.sin(tR + Math.PI) / (1 + Math.sin(tR + Math.PI) * Math.sin(tR + Math.PI));

	roomL.setPosition(xL, yL);
	roomR.setPosition(xR, yR);

	roomL.x = CoolUtil.fpsLerp(roomL.x, xL + FlxG.random.float(-2, 2)*shakeIntensity, 0.07*shakeIntensity);
	roomL.y = CoolUtil.fpsLerp(roomL.y, yL + FlxG.random.float(-2, 2)*shakeIntensity, 0.07*shakeIntensity);
	
	roomR.x = CoolUtil.fpsLerp(roomR.x, xR + FlxG.random.float(-2, 2)*shakeIntensity, 0.07*shakeIntensity);
	roomR.y = CoolUtil.fpsLerp(roomR.y, yR + FlxG.random.float(-2, 2)*shakeIntensity, 0.07*shakeIntensity);
	
	for (s=>arr in psmm) {
		for (entry in arr) {
			var isCharacter = Type.getClass(s) == Character;
			s.x = CoolUtil.fpsLerp(s.x, entry.relativePos.x + entry.sprite.x, isCharacter ? 1 : 0.06 + 0.03*shakeIntensity);
			s.y = CoolUtil.fpsLerp(s.y, entry.relativePos.y + entry.sprite.y, isCharacter ? 1 : 0.06 + 0.03*shakeIntensity);
		}
	}
}

function onEvent(_e:EventGameEvent) {
	var e = _e.event;
	switch e.name {
		case "Corruption Stage Gap Size":
			var p = e.params;
			var s = p[0];
			var tt = p[1] == 0 ? 0.001 : p[1];
			
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
		case "Corruption Stage Shake Intensity":
			var p = e.params;
			var i = p[0];
			var tt = p[1] == 0 ? 0.001 : p[1];
			var te = CoolUtil.flxeaseFromString(p[2], p[3]);

			var initialVal = shakeIntensity;
			FlxTween.num(initialVal, i, (Conductor.stepCrochet/1000) * tt, { ease: te }, (v:Float)->{
				shakeIntensity = v;
			});
	}
}