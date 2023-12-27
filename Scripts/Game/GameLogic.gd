extends Node2D

signal gameStart

@export var hoverMod : Color
@export var normalMod : Color

var gameActive = true
var movingLeft = false
var movingRight = false

var hintShown = false
var gameStarted = false

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	$POV/UILayer/UI.show()
	$POV/UILayer/UI/Note.hide()
	$POV/UILayer/UI/WinAnims.hide()
	$POV/UILayer/UI/DeathAnims.hide()
	$POV/UILayer/UI/LoseAnims.hide()
	$Mosters/Triangulin/ProgressBar.modulate.a = 0
	$Darkness.show()
	$POV/UILayer/UI/LeftGuide.modulate.a = 0
	$POV/UILayer/UI/RightGuide.modulate.a = 0
	await get_tree().create_timer(1).timeout
	get_tree().create_tween().tween_property($POV/UILayer/UI/Hint, "modulate:a", 1, 2)
	await get_tree().create_timer(3).timeout
	get_tree().create_tween().tween_property($POV/UILayer/UI/Hint, "modulate:a", 0, 2)

func _on_read_pressed():
	$POV/UILayer/UI/Note.modulate.a = 0
	$POV/UILayer/UI/Note.show()
	get_tree().create_tween().tween_property($POV/UILayer/UI/Note, "modulate:a", 1, 0.5)

func _on_close_pressed():
	var tween = get_tree().create_tween()
	tween.tween_property($POV/UILayer/UI/Note, "modulate:a", 0, 0.5)
	await tween.finished
	$POV/UILayer/UI/Note.queue_free()
	$Interactable/Note_GameStart.queue_free()
	startGame()

func startGame():
	$DifficultyTimer.start()
	$Interactable/Radios/RadioTimer.start()
	$Mosters/Circulin/CirculinTimer.start()
	$Mosters/Rectangulin/RectangulinTimer.start()
	gameStarted = true
	get_tree().create_tween().tween_property($POV/UILayer/UI/LeftGuide, "modulate:a", 1, 2)
	get_tree().create_tween().tween_property($POV/UILayer/UI/RightGuide, "modulate:a", 1, 2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(gameActive and gameStarted):
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
	$POV/UILayer/UI/Inventory.hide()

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

func _on_rectangulin_rectangulin_kill():
	gameActive = false
	$POV/UILayer/UI.show()
	$POV/UILayer/UI/DeathAnims.show()
	$UIAnims.play("RectangulinKill")

func returnToMenu():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func secretScene():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/SecretScene.tscn")

func _on_puerta_door_disable():
	$UIAnims.play("DoorButtonPushed")

func _on_blink_timeout():
	if $Interactable/Despertador/Time.modulate.a == 0:
		get_tree().create_tween().tween_property($Interactable/Despertador/Time, "modulate:a", 1, 0.2)
	else:
		get_tree().create_tween().tween_property($Interactable/Despertador/Time, "modulate:a", 0, 0.2)

func _on_ventana_window_disable():
	$UIAnims.play("WindowButtonPushed")

func stopLogic():
	get_tree().paused = true

func _on_difficulty_timer_timeout():
	randomize()
	var rand = randi_range(0, 2)
	if rand == 1:
		$Static/Pasos.play()
	elif rand == 2:
		$Static/Pasos2.play()

# Hover anims
func _on_read_mouse_entered():
	$Interactable/Note_GameStart.modulate = hoverMod

func _on_read_mouse_exited():
	$Interactable/Note_GameStart.modulate = normalMod

func _on_accion_mouse_entered():
	$Interactable/CajaDeMusica.modulate = hoverMod

func _on_accion_mouse_exited():
	$Interactable/CajaDeMusica.modulate = normalMod

func _on_shock_door_mouse_entered():
	$Interactable/Puerta/BotonAzul.modulate = hoverMod
	$Interactable/Ventana/BotonAzul.modulate = hoverMod

func _on_shock_door_mouse_exited():
	$Interactable/Puerta/BotonAzul.modulate = normalMod
	$Interactable/Ventana/BotonAzul.modulate = normalMod

func _on_alert_button_mouse_entered():
	$Interactable/Puerta/BotonRojo.modulate = hoverMod
	$Interactable/Ventana/BotonRojo.modulate = hoverMod

func _on_alert_button_mouse_exited():
	$Interactable/Puerta/BotonRojo.modulate = normalMod
	$Interactable/Ventana/BotonRojo.modulate = normalMod

func _on_apagar_mouse_entered():
	$Interactable/Despertador.modulate = hoverMod

func _on_apagar_mouse_exited():
	$Interactable/Despertador.modulate = normalMod

func _on_apagar_radio_entered():
	$Interactable/Radios.modulate = hoverMod

func _on_apagar_radio_exited():
	$Interactable/Radios.modulate = normalMod
