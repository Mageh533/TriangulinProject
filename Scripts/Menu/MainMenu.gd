extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	$MainMenu/UI/Menu.hide()
	$MainMenu/UI/Locale.show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if OS.get_name() == "Web":
		$MainMenu/UI/Menu/Quit.hide()
		$MainMenu/UI/FullScreen.hide()

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


func _on_es_mouse_entered():
	$MainMenu/UI/Locale/Es.modulate.a = 0.5

func _on_es_mouse_exited():
	$MainMenu/UI/Locale/Es.modulate.a = 1

func _on_en_mouse_entered():
	$MainMenu/UI/Locale/En.modulate.a = 0.5

func _on_en_mouse_exited():
	$MainMenu/UI/Locale/En.modulate.a = 1

func _on_full_screen_pressed():
	if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
