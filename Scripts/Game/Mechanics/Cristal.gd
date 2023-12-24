extends TextureRect

signal broken

@export var health = 100

func _process(_delta):
	if health <= 80 and health > 60:
		$Grietas.show()
		$Grietas.play("Stage1")
	elif health <= 60 and health > 50:
		$Grietas.show()
		$Grietas.play("Stage2")
	elif health <= 50 and health > 40:
		$Grietas.show()
		$Grietas.play("Stage3")
	elif health <= 40 and health > 20:
		$Grietas.show()
		$Grietas.play("Stage4")
	elif health <= 20:
		$Grietas.show()
		$Grietas.play("Stage5")
	else:
		$Grietas.hide()

func _on_circulin_hit_glass(damage):
	health -= damage
	if health <= 0:
		emit_signal("broken")
		self_modulate.a = 0
		$BreakParticles.restart()
	$GlassParticles.restart()
