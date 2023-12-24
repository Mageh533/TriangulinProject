extends Node2D

signal windowDisable
signal shocking
signal alarmActive

@export var usageTime = 10
@export var shockNoise : float = 0.5
@export var alarmNoise : float = 10
var currentUsage = 0
var activated = false

# Called when the node enters the scene tree for the first time.
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
			disableWindow()

func disableWindow():
	if activated:
		GlobalVariables.permNoise -= shockNoise
		activated = false
		$Barrera_Ventana.hide()
		$BotonAzul/ShockWindow.disabled = true
		emit_signal("windowDisable")


func _on_shock_window_pressed():
	if currentUsage > 0:
		if activated:
			$Barrera_Ventana.hide()
			activated = false
			GlobalVariables.permNoise -= shockNoise
		else:
			$Barrera_Ventana.show()
			$ShockEffect_Ventana.restart()
			activated = true
			GlobalVariables.permNoise += shockNoise

func _on_alert_button_pressed():
	emit_signal("alarmActive")
	$BotonRojo/AlertButton.disabled = true
	$Alert.show()
	GlobalVariables.permNoise += alarmNoise
	await get_tree().create_timer(3).timeout
	$Alert.hide()
	GlobalVariables.permNoise -= alarmNoise
	$BotonRojo/AlertButton.disabled = false
