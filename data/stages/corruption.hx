//
import openfl.geom.Rectangle;

var roomsCenterPoint:FlxPoint;

var shakeIntensity:Float = 0;
var elapsedTimer:Float = 0;
var lerping:Bool = true;
var sideSeparation:Float = 182;

var psmm:Map<FlxSprite, {sprite:FlxSprite, relativePos:FlxPoint, isCharacter:Bool}>; // proportionalSpriteMovementMap

var hitboxL:Rectangle;
var hitboxR:Rectangle;

function postCreate() {
	hitboxL = new Rectangle(roomL.x, roomL.y, roomL.width, roomL.height);
	hitboxR = new Rectangle(roomR.x, roomR.y, roomR.width, roomR.height);

	roomsCenterPoint = FlxPoint.get(
		hitboxL.x + (((hitboxR.x + hitboxR.width) - hitboxL.x) / 2),
		((hitboxL.y + (hitboxL.height/2)) + (hitboxR.y + (hitboxR.height/2))) / 2
	);

	psmm = [
		shatterglass => {
			sprite: roomR,
			relativePos: FlxPoint.get(shatterglass.x - roomR.x, shatterglass.y - roomR.y),
			isCharacter: false
		},
		objects => {
			sprite: roomL,
			relativePos: FlxPoint.get(objects.x - roomL.x, objects.y - roomL.y),
			isCharacter: false
		},
		dad => {
			sprite: roomL,
			relativePos: FlxPoint.get(dad.x - roomL.x, dad.y - roomL.y),
			isCharacter: false
		},
		bf => {
			sprite: roomR,
			relativePos: FlxPoint.get(bf.x - roomR.x, bf.y - roomR.y),
			isCharacter: false
		}
	];
}

function postUpdate(elapsed:Float) {
	var halfSeparation:Float = sideSeparation * 0.5;
	var targetRoomL:Float = roomsCenterPoint.x - halfSeparation - roomL.width;
	var targetRoomR:Float = roomsCenterPoint.x + halfSeparation;

	hitboxL.x = CoolUtil.fpsLerp(hitboxL.x, targetRoomL, lerping ? 0.16 : 1);
	hitboxR.x = CoolUtil.fpsLerp(hitboxR.x, targetRoomR, lerping ? 0.16 : 1);
	
	elapsedTimer += elapsed * (1 / (1 + shakeIntensity * 0.5));
	var t:Float = elapsedTimer / (2 - (0.08 * shakeIntensity));
	var radius:Float = 32 + (3.2 * shakeIntensity);

	var sinT:Float = Math.sin(t);
	var cosT:Float = Math.cos(t);
	var denom:Float = 1 + (sinT * sinT);

	var xL:Float = hitboxL.x + (radius * cosT) / denom;
	var yL:Float = hitboxL.y + (radius * cosT * sinT) / denom;

	// desync
	var sinTR:Float = Math.sin(t + 0.7 + Math.PI);
	var cosTR:Float = Math.cos(t + 0.7 + Math.PI);
	var denomR:Float = 1 + (sinTR * sinTR);

	var xR:Float = hitboxR.x + (radius * cosTR) / denomR;
	var yR:Float = hitboxR.y + (radius * cosTR * sinTR) / denomR;

	var shakeMult:Float = 0.07 * shakeIntensity;
	var randX:Float = FlxG.random.float(-2, 2) * shakeIntensity;
	var randY:Float = FlxG.random.float(-2, 2) * shakeIntensity;
	roomL.setPosition(
		CoolUtil.fpsLerp(roomL.x, xL + randX, shakeMult),
		CoolUtil.fpsLerp(roomL.y, yL + randY, shakeMult)
	);
	roomR.setPosition(
		CoolUtil.fpsLerp(roomR.x, xR + randX, shakeMult),
		CoolUtil.fpsLerp(roomR.y, yR + randY, shakeMult)
	);
	
	for (s => entry in psmm) {
		s.setPosition(
			CoolUtil.fpsLerp(s.x, entry.relativePos.x + entry.sprite.x, entry.isCharacter ? 1 : 0.06 + (0.03 * shakeIntensity)),
			CoolUtil.fpsLerp(s.y, entry.relativePos.y + entry.sprite.y, entry.isCharacter ? 1 : 0.06 + (0.03 * shakeIntensity))
		);
	}
}

function onEvent(_e:EventGameEvent) {
	if (_e.cancelled) return;

	var e = _e.event;
	switch (e.name) {
		case "Corruption Stage Gap Size":
			var p:Array<Dynamic> = e.params;
			var gapSize:Float = p[0];
			var rawTime:Float = p[1];
			var rawEase:String = p[2];
			var rawType:String = p[3];
			
			if (rawEase == "CLASSIC") {
				lerping = true;

				sideSeparation = gapSize;
			} else {
				lerping = false;

				var tweenTime:Float = (rawTime == 0) ? 0.001 : rawTime;
				var tweenEase:FlxEase = CoolUtil.flxeaseFromString(rawEase, rawType);

				var initSeparation:Float = sideSeparation;
				FlxTween.num(initSeparation, gapSize, (Conductor.stepCrochet * 0.001) * tweenTime, {
					ease: tweenEase, onComplete: () -> lerping = true
				}, (v:Float) -> sideSeparation = v);
			}

		case "Corruption Stage Shake Intensity":
			var p:Array<Dynamic> = e.params;
			var intensity:Float = p[0];
			var rawTime:Float = p[1];
			var rawEase:String = p[2];
			var rawType:String = p[3];

			var tweenTime:Float = (rawTime == 0) ? 0.001 : rawTime;
			var tweenEase:FlxEase = CoolUtil.flxeaseFromString(rawEase, rawType);

			var initShake:Float = shakeIntensity;
			FlxTween.num(initShake, intensity, (Conductor.stepCrochet/1000) * tweenTime, { ease: tweenEase }, (v:Float) -> shakeIntensity = v);
	}
}
