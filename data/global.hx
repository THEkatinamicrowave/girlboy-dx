//
import funkin.menus.StoryMenuState;

function preStateSwitch() {
    if (Std.isOfType(FlxG.game._requestedState, FreeplayState))
        FlxG.game._requestedState = new StoryMenuState();
}