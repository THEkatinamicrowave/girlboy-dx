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

var placeholdersongname:FunkinText;

function postCreate() {
    FlxG.mouse.visible = true;
    FlxG.camera.scroll.set(0, -100);

    remove(characterSprites);
    remove(weekSprites);
    for(e in [blackBar, scoreText, weekTitle, weekBG, tracklist]) {
        remove(e);
    }

    sky = new FlxSprite().loadGraphic(Paths.image(path + "sky"));
    sky.scale.set(0.7, 0.7);
    sky.updateHitbox();
    sky.antialiasing = true;
    add(sky);

    bg = new FlxSprite().loadGraphic(Paths.image(path + "selectbg"));
    bg.scale.set(0.7, 0.7);
    bg.updateHitbox();
    bg.antialiasing = true;
    add(bg);

    song1egg = new FlxSprite().loadGraphic(Paths.image(weekpath + "weaponry"));
    song1egg.frames = Paths.getFrames(weekpath + "weaponry");
    song1egg.animation.addByPrefix("idle", "idle");
    song1egg.animation.addByPrefix("high", "high", 24);
    song1egg.animation.addByPrefix("select", "select", 24);
    song1egg.animation.play("idle");
    song1egg.scale.set(0.7, 0.7);
    song1egg.updateHitbox();
    song1egg.antialiasing = true;
    add(song1egg);

    song2building = new FlxSprite().loadGraphic(Paths.image(weekpath + "breadsticks"));
    song2building.frames = Paths.getFrames(weekpath + "breadsticks");
    song2building.animation.addByPrefix("idle", "idle");
    song2building.animation.addByPrefix("high", "high", 24);
    song2building.animation.addByPrefix("select", "select", 24);
    song2building.animation.play("idle");
    song2building.scale.set(0.7, 0.7);
    song2building.updateHitbox();
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
    
    placeholdersongname = new FunkinText(0, 0, FlxG.width, "RAAAH", 48);
    placeholdersongname.alignment = "center";

    changeWeek(0, true);
    changeDifficulty(0, true);
}

function postUpdate(elapsed:Float) {
    sky.setPosition(
        0 - (FlxG.mouse.x - FlxG.width/2)/5,
        -30 - (FlxG.mouse.y - FlxG.height/2)/5
    );
    bg.setPosition(
        -780 - (FlxG.mouse.x - FlxG.width/2)/5,
        -660 - (FlxG.mouse.y - FlxG.height/2)/5
    );
    song1egg.setPosition(
        -220 - (FlxG.mouse.x - FlxG.width/2)/4,
        200 - (FlxG.mouse.y - FlxG.height/2)/4
    );
    song2building.setPosition(
        65 - (FlxG.mouse.x - FlxG.width/2)/6,
        100 - (FlxG.mouse.y - FlxG.height/2)/6
    );
}

function onGoBack(event:CancellableEvent) {
    FlxG.mouse.visible = false;
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

}