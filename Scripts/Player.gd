extends CharacterBody2D
class_name Player

const SPEED = 200.0
const JUMP_VELOCITY = -200.0
var attack_type: String
var current_attack: bool
var weapon_equip: bool
@onready var camera = $Camera2D
@onready var PlayerHitBox = $HitBoxDetection
@onready var anim : AnimatedSprite2D = $AnimatedSprite2D
@onready var stamina = $Camera2D/Control/StaminaBar
@onready var health = $Camera2D/Control/HealthBar
@onready var DamageAreaPistol = $PistolDamageArea
var can_regen = false
var can_sprint = true

func  _ready():
	weapon_equip = false
	current_attack = false
	stamina.value = stamina.max_value
	health.value = health.max_value
	
func _physics_process(delta: float) -> void:
	Global.playerDamageZone = DamageAreaPistol
	Global.PlayerHitBox = PlayerHitBox 
	Global.PlayerHealth = health
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("MoveLeft", "MoveRight")
	if direction: 
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	# Sprint binding button
	if Input.is_action_pressed("Sprint"):
		if can_sprint == true:
			velocity.x *= 2
	#Attack zone
	#if weapon_equip and !current_attack:
		#if Input.is_action_just_pressed("Attack"):
			#current_attack = true
			#if Input.is_action_just_pressed("Attack") and is_on_floor():
				#attack_type = "simple"
	move_and_slide()
	handle_animation(direction)
	
func handle_animation(_direction):
	#flip sprite
	if velocity.x < 0:
		anim.flip_h = true
		DamageAreaPistol.scale.x = -1
	else:
		if velocity.x > 0:
			anim.flip_h = false
			DamageAreaPistol.scale.x = 1
		else:
			pass
	
	#plays animations basic
	if current_attack == false:
		if abs(velocity.x) > 2:
			anim.play("PistolWalking")
		else:
			anim.play("PistolIdleStatic")
func set_damage():
	var current_damage_to_deal: int
	current_damage_to_deal = 1
	Global.playerDamageAmount = current_damage_to_deal
	

	
	
func _process(_delta):
	#pistol damage shot
	if Input.is_action_just_pressed("Attack"):
		
		if current_attack == false:
			var damagezone = DamageAreaPistol.get_node("DamageZone")
			var wait_time: float
			
			current_attack = true
			
			get_node("PistolGunShot").play()
			anim.play("PistolFiring")
			#get_node("MuzzleLight").show()  < Muzzle Light Flash if needed
			if current_attack == true:
				wait_time = 0.1
				damagezone.disabled = false
				await get_tree().create_timer(wait_time).timeout
				damagezone.disabled = true
				#get_node("MuzzleLight").hide()  < Muzzle Light Flash if needed
				wait_time = 0.4
				
				await get_tree().create_timer(wait_time).timeout
				current_attack = false
				
				
				
	#Sprint stamina value
	if Input.is_action_pressed("Sprint"):
		stamina.value -= 2
		if stamina.value == 0:
			can_sprint = false
	if stamina.value != 100 or stamina.value == 0 or stamina.value < 0:
		can_regen = true
		if can_regen == true:
			stamina.value += 1
			if stamina.value == 100:
				can_sprint = true
	#Health Bar value
	if health.value == 0:
		get_tree().quit()
