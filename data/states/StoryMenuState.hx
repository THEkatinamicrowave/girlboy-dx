//SCRIPT BY: Microkat
//
var path:String = "menus/storymenu/";
var shitpath:String = path + "selectshit/";

var sky:FlxSprite;
var bg:FlxSprite;

var arrowl:FlxSprite;
var arrowr:FlxSprite;

var placeholdersongname:FunkinText;

function postCreate() {
    remove(characterSprites);
    remove(weekSprites);
    for(e in [blackBar, scoreText, weekTitle, weekBG, tracklist]) {
        remove(e);
    }

    sky = new FlxSprite().loadGraphic(Paths.image(path + "sky"));
    sky.scale.set(0.7, 0.7);
    sky.updateHitbox();
    sky.antialiasing = true;
    sky.setPosition(0, 70);
    add(sky);

    bg = new FlxSprite().loadGraphic(Paths.image(path + "selectbg"));
    bg.scale.set(0.7, 0.7);
    bg.updateHitbox();
    bg.antialiasing = true;
    bg.setPosition(-780, -560);
    add(bg);

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
    add(placeholdersongname);

    changeWeek(0, true);
}

function onChangeDifficulty(event:MenuChangeEvent) {
    if (arrowl != null) arrowl.x = difficultySprites[weeks[curWeek].difficulties[curDifficulty].toLowerCase()].x - arrowl.width + 50;
    if (arrowr != null) arrowr.x = difficultySprites[weeks[curWeek].difficulties[curDifficulty].toLowerCase()].x + difficultySprites[weeks[curWeek].difficulties[curDifficulty].toLowerCase()].width - 50;

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
	if (placeholdersongname != null) placeholdersongname.text = weeks[event.value].name;
}