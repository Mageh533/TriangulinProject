extends AnimatedSprite2D

signal rectangulinKill

@export var rectangulinChance : float = 0.1
@export var rectangulinNoise : float = 0.5
@export var gunHolsterSpeed : float = 2

var active = false
var shocked = false
var currentHolster : float = 0
var currentStage = 0

func _ready():
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active:
		if currentHolster > 0:
			currentHolster -= delta
			if currentHolster <= 0:
				prepareToShoot()

func appear():
	shocked = false
	show()
	currentStage = 0
	play("normal")
	$RectAnims.play("Appear")
	await $RectAnims.animation_finished
	active = true
	currentHolster = gunHolsterSpeed

func dissapear():
	play("angry")
	active = false
	$RectAnims.play_backwards("Appear")
	await $RectAnims.animation_finished
	hide()

func prepareToShoot():
	currentStage += 1
	if currentStage == 1:
		play("angry")
		GlobalVariables.tempNoise += 0.5
		currentHolster = gunHolsterSpeed
	elif  currentStage == 2:
		play("ready")
		GlobalVariables.tempNoise += 0.5
		currentHolster = gunHolsterSpeed
	else:
		play("shoot")
		await get_tree().create_timer(0.3).timeout
		hide()
		emit_signal("rectangulinKill")

func _on_rectangulin_timer_timeout():
	if !active:
		randomize()
		if randf_range(0, 1) <= rectangulinChance:
			appear()

func _on_puerta_shocking():
	if !shocked and active:
		shocked = true
		dissapear()

func _on_puerta_alarm_active():
	if active:
		dissapear()

func _on_difficulty_timer_timeout():
	rectangulinChance += 0.1
