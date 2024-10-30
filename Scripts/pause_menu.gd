extends Control
var paused = false
@onready var pause_menu = $MarginContainer
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("Pause"):
		PauseMenu()
		
func PauseMenu():
	if paused:
		pause_menu.hide()
		get_tree().paused = false
	else:
		pause_menu.show()
		get_tree().paused = true
	paused = !paused

func _on_resume_pressed() -> void:
	PauseMenu()
	

func _on_quit_pressed() -> void:
	get_tree().quit
