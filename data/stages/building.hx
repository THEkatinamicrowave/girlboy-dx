//
var curColor:Int = 0;
var colors = [
	0xFF31A2FD,
	0xFF31FD8C,
	0xFFFB33F5,
	0xFFFD4531,
	0xFFFBA633
];

var p1shader:CustomShader;
var p2shader:CustomShader;

var bgBuildingsShader:CustomShader;
var fgBuildingsShader:CustomShader;

var bigFuckinLight:FlxSprite;
var otherFuckinLight:FlxSprite;

function postCreate() {
    trace("my little goomba:)");

    if (stage.stageName == "building") {
        p1shader = new CustomShader("bullshit");
        p2shader = new CustomShader("bullshit");
        bgBuildingsShader = new CustomShader("bullshit");
        fgBuildingsShader = new CustomShader("bullshit");

        bigFuckinLight = new FlxSprite().loadGraphic(Paths.image("stages/building/dx/coollights"));
        bigFuckinLight.scale.set(Math.sqrt(2) / defaultCamZoom, Math.sqrt(2) / defaultCamZoom);
        bigFuckinLight.updateHitbox();
        bigFuckinLight.alpha = 0.6;
        bigFuckinLight.blend = 0;
        bigFuckinLight.scrollFactor.set();
        bigFuckinLight.screenCenter();
        insert(members.indexOf(bg) + 1, bigFuckinLight);

        otherFuckinLight = new FlxSprite().loadGraphic(Paths.image("stages/building/dx/coollights"));
        otherFuckinLight.scale.set(Math.sqrt(2) / defaultCamZoom, Math.sqrt(2) / defaultCamZoom);
        otherFuckinLight.updateHitbox();
        otherFuckinLight.alpha = 0.45;
        otherFuckinLight.blend = 0;
        otherFuckinLight.scrollFactor.set();
        otherFuckinLight.screenCenter();
        insert(members.indexOf(bigFuckinLight), otherFuckinLight);

        otherFuckinLight.visible = !bigFuckinLight.visible;

        boyfriend.shader = p1shader;
        dad.shader = p2shader;
        buildings.shader = bgBuildingsShader;
        roof.shader = fgBuildingsShader;

        p1shader.maskPos = [3, 6];
        p2shader.maskPos = [-3, 5];
        bgBuildingsShader.maskPos = [0, 10];
        fgBuildingsShader.maskPos = [0, 17];
    }
}

function postUpdate(elapsed:Float) {
    bigFuckinLight.angle += elapsed*Conductor.stepCrochet;
    otherFuckinLight.angle -= elapsed*Conductor.stepCrochet;
}

function beatHit(beat:Int) {
    if (beat % camZoomingInterval == 0) {
        var newColor = FlxG.random.int(0, colors.length-2);
		if (newColor >= curColor) newColor++;
		curColor = newColor;

        for (meat in [bigFuckinLight, otherFuckinLight]) {
            meat.visible = !meat.visible;
		    meat.color = colors[curColor];
        }

        var coolTable = [((colors[curColor] >> 16) & 0xFF) / 255, ((colors[curColor] >> 8) & 0xFF) / 255, (colors[curColor] & 0xFF) / 255];
        for (shader in [p1shader, p2shader, bgBuildingsShader, fgBuildingsShader])
            shader.glowColor = coolTable;
    }
}