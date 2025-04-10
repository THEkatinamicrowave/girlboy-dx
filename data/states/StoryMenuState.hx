//SCRIPT BY: Microkat
//
var path:String = "menus/storymenu/";
var shitpath:String = path + "selectshit/";
var weekpath:String = path + "weeks/";

var sky:FlxSprite;
var bg:FlxSprite;

var song1egg:FlxSprite;
var song2building:FlxSprite;

var arrowl:FlxSprite;
var arrowr:FlxSprite;

function postCreate() {
    FlxG.camera.scroll.set(0, -100);

    remove(characterSprites);
    remove(weekSprites);
    for(e in [blackBar, scoreText, weekTitle, weekBG, tracklist, leftArrow, rightArrow]) {
        remove(e);
    }

    sky = new FlxSprite().loadGraphic(Paths.image(path + "sky"));
    sky.scale.set(0.7, 0.7);
    sky.updateHitbox();
    sky.setPosition(0, -30);
    sky.antialiasing = true;
    add(sky);

    bg = new FlxSprite().loadGraphic(Paths.image(path + "selectbg"));
    bg.scale.set(0.7, 0.7);
    bg.updateHitbox();
    bg.setPosition(-780, -660);
    bg.antialiasing = true;
    add(bg);

    song1egg = new FlxSprite().loadGraphic(Paths.image(weekpath + "weaponry"));
    song1egg.frames = Paths.getFrames(weekpath + "weaponry");
    song1egg.animation.addByPrefix("idle", "idle");
    song1egg.animation.addByPrefix("high", "high", 12);
    song1egg.animation.addByPrefix("select", "select", 24);
    song1egg.animation.play("idle");
    song1egg.scale.set(0.7, 0.7);
    song1egg.updateHitbox();
    song1egg.setPosition(-220, 200);
    song1egg.antialiasing = true;
    add(song1egg);

    song2building = new FlxSprite().loadGraphic(Paths.image(weekpath + "breadsticks"));
    song2building.frames = Paths.getFrames(weekpath + "breadsticks");
    song2building.animation.addByPrefix("idle", "idle");
    song2building.animation.addByPrefix("high", "high", 12);
    song2building.animation.addByPrefix("select", "select", 24);
    song2building.animation.play("idle");
    song2building.scale.set(0.7, 0.7);
    song2building.updateHitbox();
    song2building.setPosition(65, 100);
    song2building.antialiasing = true;
    insert(members.indexOf(bg), song2building);

    arrowl = new FlxSprite().loadGraphic(Paths.image(shitpath + "arrowl"));
	arrowr = new FlxSprite().loadGraphic(Paths.image(shitpath + "arrowr"));

    arrowl.frames = Paths.getFrames(shitpath + "arrowl");
    arrowr.frames = Paths.getFrames(shitpath + "arrowr");

	for(arrow in [arrowl, arrowr]) {
        arrow.scale.set(0.5, 0.5);
        arrow.updateHitbox();
		arrow.animation.addByPrefix('idle', 'idle');
		arrow.animation.addByPrefix('move', 'move', 24, false);
		arrow.animation.play('idle');
		arrow.antialiasing = true;
		add(arrow);
	}

    arrowl.x = difficultySprites[weeks[curWeek].difficulties[curDifficulty].toLowerCase()].x - arrowl.width + 50;
    arrowr.x = difficultySprites[weeks[curWeek].difficulties[curDifficulty].toLowerCase()].x + difficultySprites[weeks[curWeek].difficulties[curDifficulty].toLowerCase()].width - 50;

    arrowl.y = 450;
    arrowr.y = 450;

    changeWeek(0, true);
    changeDifficulty(0, true);
}

function postUpdate(elapsed:Float) {
    switch curWeek {
        case 0:
            sky.setPosition(CoolUtil.fpsLerp(sky.x, 127.2, 0.08), CoolUtil.fpsLerp(sky.y, -80, 0.08));
            bg.setPosition(CoolUtil.fpsLerp(bg.x, -653, 0.08), CoolUtil.fpsLerp(bg.y, -709.6, 0.08));
            song1egg.setPosition(CoolUtil.fpsLerp(song1egg.x, -61, 0.08), CoolUtil.fpsLerp(song1egg.y, 137.5, 0.08));
            song2building.setPosition(CoolUtil.fpsLerp(song2building.x, 171, 0.08), CoolUtil.fpsLerp(song2building.y, 58.3, 0.08));
        case 1:
            sky.setPosition(CoolUtil.fpsLerp(sky.x, 111.6, 0.08), CoolUtil.fpsLerp(sky.y, 49, 0.08));
            bg.setPosition(CoolUtil.fpsLerp(bg.x, -668.4, 0.08), CoolUtil.fpsLerp(bg.y, -581, 0.08));
            song1egg.setPosition(CoolUtil.fpsLerp(song1egg.x, -80.5, 0.08), CoolUtil.fpsLerp(song1egg.y, 298.75, 0.08));
            song2building.setPosition(CoolUtil.fpsLerp(song2building.x, 158, 0.08), CoolUtil.fpsLerp(song2building.y, 165.8, 0.08));
    }
}

function onChangeDifficulty(event:MenuChangeEvent) {
    for (e in difficultySprites) {
        e.y = leftArrow.y;
        e.scrollFactor.y = 1;
    }

    switch event.change {
        default:
            return;
        case -1:
            arrowl.animation.stop();
            arrowl.animation.play("move");
        case 1:
            arrowr.animation.stop();
            arrowr.animation.play("move");
    }
}

function onChangeWeek(event:MenuChangeEvent) {
    if (song1egg != null && song2building != null) {
        switch event.value {
            case 0:
                song1egg.animation.play("high");
                song2building.animation.play("idle");
                
                song1egg.offset.set(92.25, 139);
                song2building.offset.set(43, 57);
            case 1:
                song1egg.animation.play("idle");
                song2building.animation.play("high");
    
                song1egg.offset.set(89, 135);
                song2building.offset.set(49, 65);
        }
    }
}

function onWeekSelect(event:WeekSelectEvent) {
    switch curWeek {
        case 0:
            song1egg.animation.play("select");
            song1egg.offset.set(89, 135);
        case 1:
            song2building.animation.play("select");
            song2building.offset.set(43, 57);
    }
}