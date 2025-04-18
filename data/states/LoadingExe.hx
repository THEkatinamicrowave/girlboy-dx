//
var loadingText:FunkinText;

function create() {
    loadingText = new FunkinText(5, 5, FlxG.width - 10, "Friday Night Funkin' Codename Engine: Girlboy.xml DX Mod.", 24);
    add(loadingText);

    displayLoadingSequence();
}

function displayLoadingSequence() {
    addGoof("\nLoading assets...", 0, () -> {
        addGoof("\n\nERROR: corrupted file detected.", 2, () -> {
            addGoof("\nAttempting to fix...", 0.5, () -> {
                addGoof("\n\nFAILURE: file could not be fixed.", 0.1, () -> {
                    addGoof("\nAttempting workaround...", 2, () -> {
                        addGoof("\nAwaiting permissions...", 5, () -> {
                            addGoof("\n\nPermission denied.\nForging permissions...", 9, () -> {
                                addGoof("\nPermissions forged!", 4, () -> {
                                    addGoof("\n\nRunning...", 2.3, () -> {
                                        addGoof("\n", 3, killText);
                                    });
                                });
                            });
                        });
                    });
                });
            });
        });
    });
}

function addGoof(text:String, wait:Float, doafter:Void -> Void) {
    if (wait == 0) {
        loadingText.text += text;
        doafter();
    } else {
        new FlxTimer().start(wait, () -> {
            loadingText.text += text;
            doafter();
        });
    }
}

function killText() {
    loadingText.text = "";

    new FlxTimer().start(1, () -> {
        PlayState.loadSong("corruption");
        FlxG.switchState(new PlayState());
    });
}