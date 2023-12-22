extends Sprite2D

signal isWinding(delta)

var windProgress = 0
@export var winding = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(winding):
		windProgress += delta * 100
		emit_signal("isWinding", delta)
	else:
		if(windProgress > 0):
			windProgress -= delta * 50
	
	$Manivela.rotation_degrees = windProgress

func _on_accion_button_down():
	winding = true

func _on_accion_button_up():
	winding = false
