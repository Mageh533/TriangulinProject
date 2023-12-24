extends Node2D

var gameActive = true
var movingLeft = false
var movingRight = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$POV/UILayer/UI.show()
	$POV/UILayer/UI/WinAnims.hide()
	$POV/UILayer/UI/DeathAnims.hide()
	$POV/UILayer/UI/LoseAnims.hide()
	$Mosters/Triangulin/ProgressBar.modulate.a = 0
	$Darkness.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(gameActive):
		processCam(delta)
		GlobalVariables.time += delta
	if(GlobalVariables.time >= 360 and gameActive):
		gameActive = false
		winGame()
	$POV/UILayer/UI/Inventory/Volume/Ammount.text = str(snapped(GlobalVariables.noise, 0.01)).pad_decimals(2)
	$POV/UILayer/UI/Inventory/Battery/Ammount.text = str(int($Flashlight.battery * 100)) + "%"

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
	if($POV.position.x < $Targets/Left.position.x):
		$POV.position.x = $Targets/Right.position.x
	elif($POV.position.x > $Targets/Right.position.x):
		$POV.position.x = $Targets/Left.position.x

# Win game
func winGame():
	$UIAnims.play("GameWin")

func _on_test_pressed():
	print("Test")

# Game anims
func _on_accion_button_down():
	$UIAnims.play("TriangulinGaugeFade")

func _on_accion_button_up():
	$UIAnims.play_backwards("TriangulinGaugeFade")

func _on_triangulin_triangulin_kill():
	gameActive = false
	$POV/UILayer/UI.show()
	$POV/UILayer/UI/DeathAnims.show()
	$POV/UILayer/UI/DeathAnims/Triangulin.show()
	$UIAnims.play("TriangulinKill")
	$POV/UILayer/UI/DeathAnims/Triangulin/TriangulinSusto.play("default")

func _on_circulin_circulin_kill():
	gameActive = false
	$POV/UILayer/UI.show()
	$POV/UILayer/UI/DeathAnims.show()
	$UIAnims.play("CirculinKill")

func returnToMenu():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func _on_puerta_door_disable():
	$UIAnims.play("DoorButtonPushed")

func _on_blink_timeout():
	if $Interactable/Despertador/Time.modulate.a == 0:
		$UIAnims.play_backwards("AlarmBlink")
	else:
		$UIAnims.play("AlarmBlink")

func _on_ventana_window_disable():
	$UIAnims.play("WindowButtonPushed")
