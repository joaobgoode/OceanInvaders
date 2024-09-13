extends CharacterBody2D
class_name Character

var speed = 200.0
const animation_names_idle = ["idle intact", "idle 1 hit", "idle 2 hit"]
const animation_names_moving = ["Intact", "1 hit", "2 hit"]
var damage = 0
var on_wall_r = false
var on_wall_l = false
var lifes = 3

#from other
@onready var collision_rect: CollisionShape2D = $CollisionShape2D;
var bounding_size_x;
var start_bound;
var end_bound;
var alive = true
var invincible = false
signal game_lost

func _ready():
	bounding_size_x = collision_rect.shape.get_rect().size.x;
	var rect = get_viewport().get_visible_rect();
	var camera = get_viewport().get_camera_2d();
	var camera_postion = camera.position;
	start_bound = (camera_postion.x - rect.size.x) / 2;
	end_bound =  (camera_postion.x + rect.size.x) / 2;

func move_character(delta_movement: float):
	if (position.x + delta_movement < start_bound + bounding_size_x * transform.get_scale().x || 
		position.x + delta_movement > end_bound - bounding_size_x * transform.get_scale().x):
		return;
	
	position.x += delta_movement

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	var delta_movement = direction * speed * delta
	
	move_character(delta_movement)
	#if direction:
	#	velocity.x = direction * speed
	#else:
	#	velocity.x = move_toward(velocity.x, 0, speed)
	if alive:
		if direction > 0:
			$AnimatedSprite2D.flip_h = true
		elif direction < 0:
			$AnimatedSprite2D.flip_h = false

		if direction == 0:
			$AnimatedSprite2D.play(animation_names_idle[damage])
		else:
			$AnimatedSprite2D.play(animation_names_moving[damage])
		move_and_slide()

func take_damage(hits: int):
	if !invincible || hits == 3:
		invincible = true
		$InvencibilityTimer.start()
		if hits + damage < lifes:
			damage += hits
			$HitSound.play()
		elif hits + damage == lifes:
			alive = false
			speed = 0
			$AnimatedSprite2D.play("explosion")
			$ExplosionSound.play()
			await get_tree().create_timer(2).timeout
			queue_free()
			game_lost.emit()


func _on_enemies_game_lost() -> void:
	take_damage(3)


func _on_invencibility_timer_timeout() -> void:
	invincible = false
