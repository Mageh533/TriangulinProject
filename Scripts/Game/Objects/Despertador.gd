extends Sprite2D

@export var alarmNoise : float = 5
@export var alarmChance : float = 0.5
@export var startTime : float = 0

var timeText = "12:00"
var active = false
var blinked = false

func _ready():
	GlobalVariables.time = startTime

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	processTime()
	if active:
		if $Time.modulate.a > 0 and !blinked:
			$Time.modulate.a -= delta * 2
		elif $Time.modulate.a < 1 and blinked:
			$Time.modulate.a += delta * 2
		else:
			blinked = !blinked
	else:
		$Time.modulate.a = 1

# Time display
func processTime():
	if(GlobalVariables.time < 60 and GlobalVariables.time > 0):
		timeText = "12:" + str(int(fmod(GlobalVariables.time, 60))).pad_zeros(2)
		$AM.text = "AM"
	else:
		timeText = str(int(GlobalVariables.time / 60)).pad_zeros(2) + ":" + str(int(fmod(GlobalVariables.time, 60))).pad_zeros(2)
	$Time.text = timeText

func activateAlarm():
	if !active:
		active = true
		GlobalVariables.permNoise += alarmNoise
		$AlarmSFX.play()

func _on_apagar_pressed():
	if active:
		active = false
		GlobalVariables.permNoise -= alarmNoise
		$AlarmSFX.stop()

func _on_alarm_timeout():
	randomize()
	if randf_range(0, 1) <= alarmChance:
		activateAlarm()

func _on_difficulty_timer_timeout():
	alarmChance += 0.1

func _on_alarm_sfx_finished():
	$AlarmSFX.play()
