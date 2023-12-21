extends Node2D

var movingLeft = false
var movingRight = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	processCam(delta)

# Camera Logic
func _on_move_left_mouse_entered():
	movingLeft = true

func _on_move_left_mouse_exited():
	movingLeft = false

func _on_move_right_mouse_entered():
	movingRight = true

func _on_move_right_mouse_exited():
	movingRight = false

func processCam(delta):
	if(movingLeft):
		$POV.position.x -= 1000 * delta
	elif(movingRight):
		$POV.position.x += 1000 * delta
	
	# Hacky looping effect
	if($POV.position.x < -1680):
		$POV.position.x = $Targets/Right.position.x
	elif($POV.position.x > 2870):
		$POV.position.x = $Targets/Left.position.x
