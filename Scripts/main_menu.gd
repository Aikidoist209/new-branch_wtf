extends Control
@onready var SceneTransitionAnimation = $SceneTransitionAnimation/AnimationPlayer
func _ready() -> void:
	$MainScreen/StartButton.grab_focus()



func _on_start_button_pressed() -> void:
	SceneTransitionAnimation.play("Fade_in")
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/Level1.tscn")


func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Options.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
