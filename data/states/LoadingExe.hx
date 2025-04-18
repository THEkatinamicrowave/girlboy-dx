// Main loading state for the Girlboy DX mod.

var loadingText: FunkinText; // Text object for displaying loading messages.

function create() {
    // Initialize the loading text display.
    loadingText = new FunkinText(5, 5, FlxG.width - 10, "Friday Night Funkin' Codename Engine: Girlboy.xml DX Mod.", 24);
    add(loadingText);

    // Sequentially display loading messages with delays.
    displayLoadingSequence();
}

/**
 * Displays the sequence of loading messages with delays.
 */
function displayLoadingSequence() {
    addGoof("\nLoading assets...", 0, () -> {
        addGoof("\n\nERROR: corrupted file detected.", 2, () -> {
            addGoof("\nAttempting to fix...", 0.5, () -> {
                addGoof("\n\nFAILURE: file could not be fixed.", 0.1, () -> {
                    addGoof("\nAttempting workaround...", 2, () -> {
                        addGoof("\nAwaiting permissions...", 5, () -> {
                            addGoof("\n\nPermissions forged!", 9, () -> {
                                addGoof("\n\n\nRunning...", 0.1, () -> {
                                    addGoof("\n", 6, killText);
                                });
                            });
                        });
                    });
                });
            });
        });
    });
}

function addGoof(text: String, wait: Float, doafter: Void -> Void) {
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