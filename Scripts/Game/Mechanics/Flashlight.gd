extends PointLight2D

@export var battery : float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = get_global_mouse_position()
	if battery > 0:
		battery -= delta / 100
		energy = 1 * battery
		texture_scale = 4 * battery + 0.01
	
	if(Input.is_action_pressed("recharge")):
		battery += 0.05 * delta
		if battery > 1:
			battery = 1
		GlobalVariables.tempNoise += delta * 2
	if(Input.is_action_just_pressed("recharge")):
		$Recarga.play()
	if(Input.is_action_just_released("recharge")):
		$Recarga.stop()
