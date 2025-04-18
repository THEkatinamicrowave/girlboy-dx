//
import funkin.menus.StoryMenuState;

function preStateSwitch() {
    trace(Std.isOfType(FlxG.game._requestedState, FreeplayState));
    if (Std.isOfType(FlxG.game._requestedState, FreeplayState))
        FlxG.game._requestedState = new StoryMenuState();
}