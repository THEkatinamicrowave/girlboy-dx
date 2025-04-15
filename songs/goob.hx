//
import flixel.FlxObject;

var dadPos:FlxObject;
var bfPos:FlxObject;
var gfPos:FlxObject;

var dadScale:FlxPoint;
var bfScale:FlxPoint;
var gfScale:FlxPoint;

function postCreate() {
    if (dad != null) {
        dadPos = new FlxObject(dad.x, dad.y);
        dadScale = FlxPoint.get(dad.scale.x, dad.scale.y);
    }

    if (boyfriend != null) {
        bfPos = new FlxObject(boyfriend.x, boyfriend.y);
        bfScale = FlxPoint.get(boyfriend.scale.x, boyfriend.scale.y);
    }

    if (gf != null) {
        gfPos = new FlxObject(gf.x, gf.y);
        gfScale = FlxPoint.get(gf.scale.x, gf.scale.y);
    }

    for (pos in [dadPos, gfPos, bfPos]) if (pos != null) add(pos);
}

function postUpdate(elapsed:Float) {
    if (Conductor.songPosition > 0) {
        for (strum in strumLines.members) {
            var propPos:FlxObject = switch (strum.data.type) {
                case 0: dadPos;
                case 1: bfPos;
                case 2: gfPos;
            };
            var propScale:FlxPoint = switch (strum.data.type) {
                case 0: dadScale;
                case 1: bfScale;
                case 2: gfScale;
            };
    
            for (c in strum.characters) {
                if (c.animation.name == "idle" || c.animation.name == "danceLeft" || c.animation.name == "danceRight") {
                    c.scale.set(propScale.x, propScale.y);
                    c.skew.set(0, 0);

                    c.setPosition(propPos.x, propPos.y);
                } else {
                    c.scale.set(CoolUtil.fpsLerp(c.scale.x, propScale.x, 0.1), CoolUtil.fpsLerp(c.scale.y, propScale.y, 0.1));
                    c.skew.set(CoolUtil.fpsLerp(c.skew.x, 0, 0.1), CoolUtil.fpsLerp(c.skew.y, 0, 0.1));
        
                    c.setPosition(CoolUtil.fpsLerp(c.x, propPos.x, 0.15), CoolUtil.fpsLerp(c.y, propPos.y, 0.15));
                }
            }
        }
    }
}

function onNoteHit(event:NoteHitEvent) {
    var propPos:FlxObject = switch (event.note.strumLine.data.type) {
        case 0: dadPos;
        case 1: bfPos;
        case 2: gfPos;
    };
    var propScale:FlxPoint = switch (event.note.strumLine.data.type) {
        case 0: dadScale;
        case 1: bfScale;
        case 2: gfScale;
    };

    if (!event.note.isSustainNote) {
        switch (event.note.strumID) {
            case 0:
                event.character.skew.set(5, 0);
                event.character.scale.set(propScale.x, propScale.y);
                event.character.setPosition(propPos.x - (propScale.x * event.character.height * Math.tan(Math.PI / 36)) / 2, propPos.y);
            case 1:
                event.character.skew.set(0, 0);
                event.character.scale.set(propScale.x * 1.1, propScale.y * 0.9);
                event.character.setPosition(propPos.x, propPos.y + (propScale.y * event.character.height * 0.05));
            case 2:
                event.character.skew.set(0, 0);
                event.character.scale.set(propScale.x * 0.9, propScale.y * 1.1);
                event.character.setPosition(propPos.x, propPos.y - (propScale.y * event.character.height * 0.05));
            case 3:
                event.character.skew.set(-5, 0);
                event.character.scale.set(propScale.x, propScale.y);
                event.character.setPosition(propPos.x + (propScale.x * event.character.height * Math.tan(Math.PI / 36)) / 2, propPos.y);
        }
    }
}

// function onPlayerMiss(event:NoteMissEvent) {
//     event.character.skew.set((Math.random() * 178) - 89, (Math.random() * 178) - 89);
// }
