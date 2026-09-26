//SCRIPT BY: Microkat
// ALSO BY WUFF BUT WHO GAF
//ALSO THIS IS JUST MODIFIED FROM THE BNW HUD SCRIPT LOL!!!
import funkin.game.PlayState.ComboRating;
import flixel.text.FlxTextBorderStyle;
import flixel.ui.FlxBar;
import flixel.ui.FlxBar.FlxBarFillDirection;
import flixel.group.FlxTypedGroup;

public var ratingTimer = new FlxTimer();
public var rating:FlxSprite;

public var combo:Int;
public var comboNumGroup:FlxTypedGroup<FlxSprite>;

public var healthLerp:Float;

function create():Void {
	comboGroup.visible = false;
}

function postCreate():Void {
	for (icon in [iconP1, iconP2]) {
		icon.bump = null;
		icon.updateBump = null;
		icon.y += camHUD.downscroll ? 15 : -15;
	}

	rating = new FlxSprite(600, 525);
	rating.alpha = 0;
	rating.camera = camHUD;
	add(rating);
	
	combo = 0;

	comboNumGroup = new FlxTypedGroup();
	comboNumGroup.camera = camHUD;
	add(comboNumGroup);
}

function postUpdate(elapsed:Float):Void {
	healthLerp = FlxMath.lerp(healthLerp, health, 0.1);
	healthBar.value = healthLerp;
}

function beatHit(curBeat:Int) {
	for (icon in [iconP1, iconP2]) {
		FlxTween.cancelTweensOf(icon);

		icon.scale.set(1.2, 0.8);
		FlxTween.tween(icon, {'scale.x': 1, 'scale.y': 1}, (Conductor.crochet * 0.001) * 0.75, {ease: FlxEase.quadOut});
	}
}

function onPlayerHit(event:NoteHitEvent) {
	if (event.note.isSustainNote) return;
	if (ratingTimer.active == true) {
		ratingTimer.cancel();
	}

	rating.loadGraphic(Paths.image('game/score/' + event.rating));
	rating.scale.set(0.5, 0.5);
	rating.updateHitbox();
	rating.screenCenter();
	rating.x += 330;
	rating.y -= 100;
	rating.alpha = 0.8;
	FlxTween.cancelTweensOf(rating);
	FlxTween.tween(rating, {'scale.x': 0.45, 'scale.y': 0.45}, 0.2, {ease: FlxEase.quadIn});
	
	combo += 1;

	for (member in comboNumGroup.members) {
		FlxTween.cancelTweensOf(member);
		member.destroy();
		member = null;
	}
	comboNumGroup.clear();

	var comboScore:Array<Int> = [];
	var separatedScore:String = Std.string(combo);
	for (i in 0...separatedScore.length) {
		var numScore:FunkinSprite = new FunkinSprite(0, rating.y + (camHUD.downscroll ? -30 : 70));
		numScore.loadSprite(Paths.image('game/score/num' + separatedScore.charAt(i)));
		numScore.scale.set(0.45, 0.45);
		numScore.updateHitbox();
		numScore.screenCenter(FlxAxes.X);
		numScore.x += (12 + (i * 36) - (separatedScore.length * 20)) + 330;
		numScore.alpha = 0.8;
		comboNumGroup.add(numScore);
	}
	
	ratingTimer.start(1.0, ()->{ 
		FlxTween.tween(rating, {'scale.x': 0, 'scale.y': 0, alpha: 0}, 0.25, {ease: FlxEase.quadOut});

		for (num in comboNumGroup.members) {
			FlxTween.tween(num, {'scale.x': 0, 'scale.y': 0, alpha: 0}, 0.25, {ease: FlxEase.quadOut});
		}
	});
}

function onPlayerMiss(event:NoteMissEvent) {
	combo = 0;
}
