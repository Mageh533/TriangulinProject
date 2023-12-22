extends PointLight2D

signal noise

@export var battery : float

func _ready():
	battery = 1

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
			emit_signal("noise")
