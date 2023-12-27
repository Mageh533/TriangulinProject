extends Node3D

func _ready():
	$UI.hide()
	$UI/Label.hide()

func _on_trigger_end_body_entered(body):
	$Light/RedSpotLight4.show()
	await get_tree().create_timer(0.1).timeout
	$Player.queue_free()
	$Ambiente.queue_free()
	$UI.show()
	await get_tree().create_timer(1).timeout
	$UI/Label.show()
	await get_tree().create_timer(5).timeout
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
