extends Button

@export var MainScene : PackedScene

func _on_pressed():
	get_tree().change_scene_to_packed(MainScene)
