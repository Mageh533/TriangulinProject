extends PointLight2D

@export var battery : float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = get_global_mouse_position()
	if battery > 0:
		battery -= delta / 100
		energy = 1 * battery
		texture_scale = 4 * battery + 0.01
	
	if(Input.is_action_just_pressed("recharge")):
		if battery < 1:
			battery += 0.05
			GlobalVariables.tempNoise += 0.5
			var recargadup = $Recarga.duplicate()
			add_child(recargadup)
			recargadup.play()
			await recargadup.finished
			recargadup.queue_free()
		if battery > 1:
			battery = 1
