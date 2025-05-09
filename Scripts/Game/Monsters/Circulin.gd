extends Sprite2D

signal circulinKill
signal hitGlass(damage : int)

@export var circulinChance : float = 0.1
@export var shovelSpeed : float = 2
@export var glassNoise : float = 2
@export var glassDamage : int = 10
var shovelTime = 0
var active = false
var shocked = false

func _ready():
	hide()
	shovelTime = shovelSpeed

func _process(delta):
	shocked = false
	if active:
		shovelTime -= delta
		if shovelTime <= 0:
			shovelTime = shovelSpeed
			$CirAnims.play("HIT")

func hit():
	if shocked:
		$ShockEffect.restart()
		dissapear()
		$Shock.play()
	else:
		emit_signal("hitGlass", glassDamage)
		$GlassHit.play()

func makeNoise():
	GlobalVariables.tempNoise += glassNoise

func appear():
	shocked = false
	show()
	$CirAnims.play("Fade")
	active = true

func dissapear():
	$CirAnims.play_backwards("Fade")
	active = false
	await $CirAnims.animation_finished
	hide()

func _on_circulin_timer_timeout():
	if !active:
		randomize()
		if randf_range(0, 1) <= circulinChance:
			appear()

func _on_cristal_broken():
	dissapear()
	await get_tree().create_timer(3).timeout
	emit_signal("circulinKill")

func _on_ventana_shocking():
	if !shocked:
		shocked = true

func _on_ventana_alarm_active():
	if active:
		dissapear()

func _on_difficulty_timer_timeout():
	circulinChance += 0.1
