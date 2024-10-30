extends Node2D

@onready var SceneTransitionAnimation = $SceneTransitionAnimation/AnimationPlayer
var entered: bool

func _ready() -> void:
	entered = false
	SceneTransitionAnimation.play("Fade_out")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		SceneTransitionAnimation.play("Fade_in")
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://Scenes/level2.tscn")
