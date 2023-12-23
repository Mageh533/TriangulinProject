extends Sprite2D

signal isWinding(delta)

var windProgress = 0
@export var winding = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(winding):
		windProgress += delta * 100
		emit_signal("isWinding", delta)
	else:
		if(windProgress > 0):
			windProgress -= delta * 50
	
	$Manivela.rotation_degrees = windProgress * 2

func _on_accion_button_down():
	winding = true

func _on_accion_button_up():
	winding = false
