//
import funkin.backend.shaders.CustomShader;

var dadShader:CustomShader = new CustomShader("badapple");
var bfShader:CustomShader = new CustomShader("badapple");
var stageShader:CustomShader = new CustomShader("badapple");

function postCreate() {
    trace("i might have eateded it :3");

    dad.shader = dadShader;
    boyfriend.shader = bfShader;
    for (a in stage.stageSprites) a.shader = stageShader;

    for (s in [dadShader, bfShader, stageShader]) s.mixValue = 0;
}

function onEvent(event:EventGameEvent) {
    if (event.event.name == "Bad Apple") {
        var params = event.event.params;

        var dadTog = params[0];
        var bfTog = params[1];
        var gfTog = params[2];
        var stageTog = params[3];
        var dadC = params[4];
        var bfC = params[5];
        var gfC = params[6];
        var stageC = params[7];
        var fadeTime = params[8];

        setShaderCol(dadShader, dadTog, dadShader.mixValue, dadC, fadeTime);
        setShaderCol(bfShader, bfTog, bfShader.mixValue, bfC, fadeTime);
        setShaderCol(stageShader, stageTog, stageShader.mixValue, stageC, fadeTime);
    }
}

function setShaderCol(shader, toggle, prevVal, color, time) {
    var coolTable = [((color >> 16) & 0xFF) / 255, ((color >> 8) & 0xFF) / 255, (color & 0xFF) / 255];
    shader.customColor = coolTable;

    if (time == 0) {
        shader.mixValue = toggle ? 1 : 0;
    } else {
        FlxTween.num(prevVal, toggle ? 1 : 0, (Conductor.stepCrochet / 1000) * time, null, function(n:Float) {
            shader.mixValue = n;
        });
    }
}