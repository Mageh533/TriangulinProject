extends Node2D

signal doorDisable
signal shocking
signal alarmActive

@export var usageTime = 10
@export var shockNoise : float = 0.5
@export var alarmNoise : float = 20
var currentUsage = 0
var activated = false

func _ready():
	currentUsage = usageTime
	$Alert.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$UsageGauge.value = currentUsage
	if activated and currentUsage > 0:
		currentUsage -= delta
		emit_signal("shocking")
		if currentUsage <= 0:
			disableDoor()

func _on_shock_door_pressed():
	if currentUsage > 0:
		if activated:
			$Barrera_Puerta.hide()
			$Barrera_Puerta/Electricidad.stop()
			activated = false
			GlobalVariables.permNoise -= shockNoise
		else:
			$Barrera_Puerta.show()
			$ShockEffect_Puerta.restart()
			$Barrera_Puerta/Electricidad.play()
			activated = true
			GlobalVariables.permNoise += shockNoise

func _on_alert_button_pressed():
	emit_signal("alarmActive")
	$BotonRojo/AlertButton.disabled = true
	$Alert.show()
	$Alarm.play()
	GlobalVariables.permNoise += alarmNoise
	await get_tree().create_timer(3).timeout
	$Alert.hide()
	GlobalVariables.permNoise -= alarmNoise
	$BotonRojo/AlertButton.disabled = false
	$Alarm.stop()

func disableDoor():
	if activated:
		GlobalVariables.permNoise -= shockNoise
		activated = false
		$Barrera_Puerta.hide()
		$BotonAzul/ShockDoor.disabled = true
