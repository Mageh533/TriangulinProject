extends Node2D

@export var time : float

var gameActive = true
var movingLeft = false
var movingRight = false
var timeText = "12:00"

# Called when the node enters the scene tree for the first time.
func _ready():
	$POV/UI.hide()
	$POV/UI/WinAnims.hide()
	$POV/UI/DeathAnims.hide()
	$Mosters/Triangulin/ProgressBar.modulate.a = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(gameActive):
		processCam(delta)
		time += delta
		processTime()
	if(time >= 360 and gameActive):
		gameActive = false
		winGame()

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

# Time display
func processTime():
	if(time < 60):
		timeText = "12:" + str(int(fmod(time, 60))).pad_zeros(2)
	else:
		timeText = str(int(time / 60)).pad_zeros(2) + ":" + str(int(fmod(time, 60))).pad_zeros(2)
	$Static/Despertador/Time.text = timeText

# Win game
func winGame():
	$GameAnims.play("GameWin")

func _on_test_pressed():
	print("Test")

# Game anims
func _on_accion_button_down():
	$GameAnims.play("TriangulinGaugeFadeIn")

func _on_accion_button_up():
	$GameAnims.play("TriangulinGaugeFadeOut")

func _on_triangulin_triangulin_kill():
	gameActive = false
	$POV/UI.show()
	$POV/UI/DeathAnims.show()
	$POV/UI/DeathAnims/Triangulin.show()
	$GameAnims.play("TriangulinKill")
	$POV/UI/DeathAnims/Triangulin/TriangulinSusto.play("default")
	await $GameAnims.anima
