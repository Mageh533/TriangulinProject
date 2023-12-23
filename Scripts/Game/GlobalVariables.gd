extends Node

var noise : float = 0
var permNoise : float = 0 # Permanent noise e.g., radios, alarms, etc
var tempNoise : float = 0 # Temporal noise e.g., flashlight recharge, knocks on the wall.

var time : float = 0

func _process(delta):
	if tempNoise > 0:
		tempNoise -= delta
		if tempNoise < 0:
			tempNoise = 0
	
	if permNoise < 0:
		permNoise = 0
	
	noise = permNoise + tempNoise
	
	
