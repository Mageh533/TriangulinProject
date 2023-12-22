extends AnimatedSprite2D

@export var sleepBar = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ProgressBar.value = sleepBar
	sleepBar -= delta * 2
	monsterAnims()
	if sleepBar <= 0:
		killPlayer()

func _on_caja_de_musica_is_winding(delta):
	sleepBar += delta * 20

func killPlayer():
	pass

func monsterAnims():
	if(sleepBar >= 75):
		play("Fase1")
	elif(sleepBar < 75 and sleepBar >= 50):
		play("Fase2")
	elif(sleepBar < 50 and sleepBar >= 25):
		play("Fase3")
	else:
		play("Fase4")
