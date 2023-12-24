extends Sprite2D

signal circulinKill
signal hitGlass(damage : int)

@export var circulinChance : float = 0.1
@export var shovelSpeed : float = 2
@export var glassNoise : float = 2
@export var glassDamage : int = 10
var shovelTime = 0
var active = false

func _ready():
	hide()
	shovelTime = shovelSpeed

func _process(delta):
	if active:
		shovelTime -= delta
		if shovelTime <= 0:
			shovelTime = shovelSpeed
			$CirAnims.play("HIT")

func hit():
	emit_signal("hitGlass", glassDamage)

func makeNoise():
	GlobalVariables.tempNoise += glassNoise

func appear():
	show()
	active = true

func dissapear():
	hide()
	active = false

func _on_circulin_timer_timeout():
	randomize()
	if randf_range(0, 1) <= circulinChance:
		appear()

func _on_cristal_broken():
	dissapear()
	await get_tree().create_timer(3).timeout
	emit_signal("circulinKill")
