extends ColorRect

signal broken

@export var health = 100

func _process(delta):
	$DebugHealth.text = str(health)

func _on_circulin_hit_glass(damage):
	health -= damage
	if health <= 0:
		emit_signal("broken")
