// it is so not worth making a separate event for this thing it only happens once
//
function beatHit(beat:Int) {
	switch (beat) {
		case 256:
			uiBadApple(true);
		case 258:
			uiBadApple(false);
	}
}

function uiBadApple(doit:Bool) {
	camHUD.color = doit ? 0xFF000000 : 0xFFFFFFFF;
}