//
function postCreate() {
    for (sl in strumLines.members) for (c in sl.characters) {
        c.scripts.importScript('data/scripts/CamFollow');
    }
}