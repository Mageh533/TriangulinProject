extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	$MainMenu/UI/Menu.hide()
	$MainMenu/UI/Locale.show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if OS.get_name() == "Web":
		$MainMenu/UI/Menu/Quit.hide()

func _on_es_pressed():
	TranslationServer.set_locale("es")
	$MainMenu/UI/Locale.hide()
	$MainMenu/UI/Menu.show()
	menuEffects()

func _on_en_pressed():
	TranslationServer.set_locale("en")
	$MainMenu/UI/Locale.hide()
	$MainMenu/UI/Menu.show()
	menuEffects()

func menuEffects():
	$MenuAnims.play("MenuStart")
	$MainMenu/Music.play()

func _on_quit_pressed():
	get_tree().quit()
