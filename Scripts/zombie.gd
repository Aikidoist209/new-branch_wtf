extends CharacterBody2D

const speed = 30.0
@onready var anim : AnimatedSprite2D = $AnimatedSprite2D
@onready var health = $HealthBar
@onready var Hitbox = $HitBox/DamageBox
var dead: bool
var taking_damage = false
var area = Global.playerDamageZone
var damage = Global.playerDamageAmount
var HealthValue = 3
func _ready():
	health.value = health.max_value
	dead = false
func _on_hit_box_area_entered(area: Area2D) -> void:
	if dead == false:
		if area == Global.PlayerHitBox:
			Global.PlayerHealth.value -= 1
	if area == Global.playerDamageZone:
		health.value -= 1
		HealthValue -= 1
	
func _process(_delta):
	if dead == false:
		if HealthValue == 0:
			anim.play("Death")
			dead = true
			Death(dead)
		else:
			anim.play("Idle")
			
func Death(_dead):
	if dead == true:
		get_node("HealthBar").hide()
		Hitbox.disabled = true
