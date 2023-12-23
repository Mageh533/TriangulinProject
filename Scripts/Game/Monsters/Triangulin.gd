extends AnimatedSprite2D

signal triangulinKill
@export var sleepBar = 100
var sleeping = true

var particleAmounts = 8

# Called when the node enters the scene tree for the first time.
func _ready():
	$ParticulasMimir.amount = particleAmounts
	$ParticulasMimir.restart()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(sleeping):
		$ProgressBar.value = sleepBar
		sleepBar -= (delta * GlobalVariables.noise) + (delta * 1)
		monsterAnims()
		if sleepBar <= 0 and sleeping:
			sleeping = false
			hide()
			$KillTimer.start()

func _on_caja_de_musica_is_winding(delta):
	if(sleeping and sleepBar < 100):
		sleepBar += delta * 20

func monsterAnims():
	if(sleepBar >= 75):
		play("Fase1")
		particleAmounts = 8
	elif(sleepBar < 75 and sleepBar >= 50):
		play("Fase2")
		particleAmounts = 6
	elif(sleepBar < 50 and sleepBar >= 25):
		play("Fase3")
		particleAmounts = 3
	else:
		play("Fase4")
		particleAmounts = 0

func _on_kill_timer_timeout():
	emit_signal("triangulinKill")

func _on_particle_timer_timeout():
	if particleAmounts > 0:
		$ParticulasMimir.amount = particleAmounts
		$ParticulasMimir.restart()
