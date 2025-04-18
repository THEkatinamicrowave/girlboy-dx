//
function postCreate(event:TransitionCreationEvent) {
    transitionTween.cancel();
    finish();
}