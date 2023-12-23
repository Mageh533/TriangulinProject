extends Node2D

signal doorDisable

@export var usageTime = 10
@export var shockNoise : float = 10
@export var alarmNoise : float = 10
var currentUsage = 0
var activated = false

func _ready():
	currentUsage = usageTime

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$UsageGauge.value = currentUsage
	if activated and currentUsage > 0:
		currentUsage -= delta
		if currentUsage <= 0:
			disableDoor()

func _on_shock_door_pressed():
	if currentUsage > 0:
		if activated:
			$Barrera_Puerta.hide()
			activated = false
			GlobalVariables.permNoise -= shockNoise
		else:
			$Barrera_Puerta.show()
			$ShockEffect_Puerta.restart()
			activated = true
			GlobalVariables.permNoise += shockNoise

func disableDoor():
	if activated:
		GlobalVariables.permNoise -= shockNoise
		activated = false
		$Barrera_Puerta.hide()
		$BotonAzul/ShockDoor.disabled = true
