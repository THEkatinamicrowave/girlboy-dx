//
var curColor:Int = 0;
var colors = [0xFF31A2FD, 0xFF31FD8C, 0xFFFB33F5, 0xFFFD4531, 0xFFFBA633];

var p1shader:FunkinShader;
var p2shader:FunkinShader;
var bgBuildingsShader:FunkinShader;
var fgBuildingsShader:FunkinShader;

function postCreate() {
	p1shader = FunkinShader.fromFile(Paths.fragShader("bullshit"));
	p2shader = FunkinShader.fromFile(Paths.fragShader("bullshit"));
	bgBuildingsShader = FunkinShader.fromFile(Paths.fragShader("bullshit"));
	fgBuildingsShader = FunkinShader.fromFile(Paths.fragShader("bullshit"));

	for (light in [bigFuckinLight, otherFuckinLight]) light.screenCenter();

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
	var angleAmount:Float = (Conductor.stepCrochet * 0.333) * elapsed;
	
	bigFuckinLight.angle += angleAmount;
	otherFuckinLight.angle -= angleAmount;
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
	if (_e.cancelled || e.name != "Start Buildings Goober Event") return;

	var toggle:Bool = e.params[0];

	camZooming = true;

	rooflights.alpha = toggle ? 1 : 0;
	bigFuckinLight.alpha = rooflights.alpha * 0.6;
	otherFuckinLight.alpha = rooflights.alpha * 0.45;
	defaultCamZoom = toggle ? 0.45 : defaultZoom;
	
	dad.useRenderTexture = boyfriend.useRenderTexture = toggle;

	for (shader in [p1shader, p2shader, bgBuildingsShader, fgBuildingsShader]) shader.mixValue = rooflights.alpha;
}
