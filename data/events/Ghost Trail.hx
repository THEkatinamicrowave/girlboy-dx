var dadTog:Bool = false;
var bfTog:Bool = false;
var gfTog:Bool = false;

function onEvent(event:EventGameEvent) {
    if (event.event.name == "Ghost Trail") {
        var params = event.event.params;

        dadTog = params[0];
        bfTog = params[1];
        gfTog = params[2];
    }
}

function onNoteHit(event:NoteHitEvent) {
    var _charName:String = event.character.curCharacter;
    var _charSprite = event.character.sprite;
    var _charID:Int = event.note.strumLine.data.type;
    var _animDir:Int = event.direction;
    var _animMap:Array<String> = ["singLEFT", "singDOWN", "singUP", "singRIGHT"];
    var _chartPos:Character = switch (_charID) {
        case 0:
            dad;
        case 1:
            boyfriend;
        case 2:
            gf;
    }
    var _togToCheck = switch(_chartPos) {
        case dad:
            dadTog;
        case boyfriend:
            bfTog;
        case gf:
            gfTog;
    }
    var _xmldata = event.character.xml;

    var _animName:String;
    var _animXOff:Int;
    var _animYOff:Int;

    for (node in _xmldata.elements()) {
        var name = node.get("name"); // Get the "name" attribute
        if (name == _animMap[_animDir]) {
            _animXOff = Std.parseInt(node.get("x"));
            _animYOff = Std.parseInt(node.get("y"));
            _animName = Std.string(node.get("anim"));
        }
    }
    
    if (_togToCheck) {
        var _ghostTrail = new FunkinSprite().loadGraphic(Paths.image("characters/" + _charSprite), true);
        _ghostTrail.frames = Paths.getFrames("characters/" + _charSprite);
        _ghostTrail.animation.addByPrefix("idle", _animName, 1, true);
        _ghostTrail.animation.play("idle");
        _ghostTrail.color = _chartPos.iconColor;
        _ghostTrail.alpha = 0.5;
        _ghostTrail.x = _chartPos.x - _chartPos.offset.x - _animXOff; _ghostTrail.y = _chartPos.y - _chartPos.offset.y - _animYOff;
        insert(members.indexOf(_chartPos), _ghostTrail);

        FlxTween.tween(_ghostTrail, { alpha: 0 }, 0.7, { onComplete: () -> _ghostTrail.destroy() });
    }
}
