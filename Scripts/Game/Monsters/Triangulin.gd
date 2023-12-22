extends AnimatedSprite2D

signal triangulinKill
@export var sleepBar = 100
var sleeping = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(sleeping):
		$ProgressBar.value = sleepBar
		sleepBar -= delta * 2
		monsterAnims()
		if sleepBar <= 0 and sleeping:
			sleeping = false
			hide()
			$KillTimer.start()

func _on_caja_de_musica_is_winding(delta):
	if(sleeping):
		sleepBar += delta * 20

func monsterAnims():
	if(sleepBar >= 75):
		play("Fase1")
	elif(sleepBar < 75 and sleepBar >= 50):
		play("Fase2")
	elif(sleepBar < 50 and sleepBar >= 25):
		play("Fase3")
	else:
		play("Fase4")

func _on_kill_timer_timeout():
	emit_signal("triangulinKill")

func _on_flashlight_noise():
	sleepBar -= 5
