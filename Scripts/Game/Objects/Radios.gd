extends Node2D

@export var radioNoise = 5
@export var radioChance = 0.1

var activeRadio = 0

var radioActive = false

func _on_apagar_pressed():
	if radioActive:
		radioActive = false
		GlobalVariables.permNoise -= radioNoise

func turnRadioOn():
	if !radioActive:
		activeRadio = randi_range(1, get_child_count() - 1)
		print(activeRadio)
		for radio in get_children():
			if radio is Sprite2D:
				radio.hide()
		randomize()
		radioActive = true
		for radio in get_children():
			if str(activeRadio) in radio.name:
				radio.show()
		GlobalVariables.permNoise += radioNoise

func _on_radio_timer_timeout():
	randomize()
	if randf_range(0, 1) <= radioChance:
		turnRadioOn()
