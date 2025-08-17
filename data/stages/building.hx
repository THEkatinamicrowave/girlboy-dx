//
var curColor:Int = 0;
var colors = [0xFF31A2FD, 0xFF31FD8C, 0xFFFB33F5, 0xFFFD4531, 0xFFFBA633];

var p1shader:CustomShader;
var p2shader:CustomShader;
var bgBuildingsShader:CustomShader;
var fgBuildingsShader:CustomShader;

var bigFuckinLight:FlxSprite;
var otherFuckinLight:FlxSprite;

function postCreate() {
	if (stage.stageName != "building") return;

	p1shader = new CustomShader("bullshit");
	p2shader = new CustomShader("bullshit");
	bgBuildingsShader = new CustomShader("bullshit");
	fgBuildingsShader = new CustomShader("bullshit");

	bigFuckinLight = new FlxSprite().loadGraphic(Paths.image("stages/building/dx/coollights"));
	insert(members.indexOf(bg) + 1, bigFuckinLight);

	otherFuckinLight = new FlxSprite().loadGraphic(Paths.image("stages/building/dx/coollights"));
	insert(members.indexOf(bigFuckinLight), otherFuckinLight);

	for (light in [bigFuckinLight, otherFuckinLight]) {
		light.updateHitbox();
		light.alpha = light.blend = 0;
		light.scrollFactor.set();
		light.screenCenter();
	}

	otherFuckinLight.visible = !bigFuckinLight.visible;

	boyfriend.shader = p1shader;
	dad.shader = p2shader;
	buildings.shader = bgBuildingsShader;
	roof.shader = fgBuildingsShader;

	p1shader.maskPos = [3, 6];
	p2shader.maskPos = [-3, 5];
	bgBuildingsShader.maskPos = [0, 10];
	fgBuildingsShader.maskPos = [0, 17];

	for (shader in [p1shader, p2shader, bgBuildingsShader, fgBuildingsShader]) shader.mixValue = 0;
}

function postUpdate(elapsed:Float) {
	bigFuckinLight.angle += (Conductor.stepCrochet / 3) * elapsed;
	otherFuckinLight.angle -= (Conductor.stepCrochet / 3) * elapsed;

	for (light in [bigFuckinLight, otherFuckinLight])
		light.scale.set(Math.sqrt(2) / camGame.zoom, Math.sqrt(2) / camGame.zoom); // diagonal square
}

function beatHit(beat:Int) {
	if (beat % camZoomingInterval != 0) return;

	curColor = (curColor + FlxG.random.int(1, colors.length - 1)) % colors.length;

	var newColor = colors[curColor];
	var glowColor = [
		((newColor >> 16) & 0xFF) / 255,
		((newColor >> 8) & 0xFF) / 255,
		(newColor & 0xFF) / 255
	];

	for (meat in [bigFuckinLight, otherFuckinLight]) {
		meat.visible = !meat.visible;
		meat.color = newColor;
	}

	rooflights.color = newColor;
	for (shader in [p1shader, p2shader, bgBuildingsShader, fgBuildingsShader]) shader.glowColor = glowColor;
}

function onEvent(_e:EventGameEvent) {
	var e = _e.event;
	if (e.name != "Start Buildings Goober Event") return;

	var toggle:Bool = e.params[0];

	camZooming = true;

	rooflights.alpha = toggle ? 1 : 0;
	bigFuckinLight.alpha = rooflights.alpha * 0.6;
	otherFuckinLight.alpha = rooflights.alpha * 0.45;
	defaultCamZoom = toggle ? 0.45 : stage.stageXML.get("zoom");

	for (shader in [p1shader, p2shader, bgBuildingsShader, fgBuildingsShader]) shader.mixValue = rooflights.alpha;
}
