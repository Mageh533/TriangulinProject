extends Sprite2D

signal isWinding(delta)

var windProgress = 0
var forwardSfxPos : float
@export var winding = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(winding):
		emit_signal("isWinding", delta)
		$Manivela.rotation_degrees = $Forward.get_playback_position() * 100
	else:
		$Manivela.rotation_degrees = forwardSfxPos * 100
		if forwardSfxPos > 0:
			forwardSfxPos -= delta
			if forwardSfxPos <= 0:
				forwardSfxPos = 0
				$Backwards.stop()
				$Stop.play()
	

func _on_accion_button_down():
	winding = true
	$Backwards.stop()
	$Forward.play(forwardSfxPos)

func _on_accion_button_up():
	winding = false
	forwardSfxPos = $Forward.get_playback_position()
	$Forward.stop()
	$Backwards.play()
