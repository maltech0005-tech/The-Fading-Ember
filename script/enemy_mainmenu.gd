extends CharacterBody2D

var SPEED = 1000.0
const JUMP_VELOCITY = -400.0
var to_pos_x
var to_pos_y
	
func _ready() -> void:
	random_motion()
	
func _physics_process(delta: float) -> void:
	var direction = Vector2(to_pos_x-global_position.x, to_pos_y-global_position.y).normalized()
	velocity=direction*SPEED*delta
	#move_toward(to_pos_x,to_pos_y, SPEED)
	if global_position.distance_to(Vector2(to_pos_x, to_pos_y))<10:
		velocity= Vector2.ZERO
		random_motion()
		
	move_and_slide()
	
func random_motion():
	to_pos_x = randi_range(32, 514)
	to_pos_y = randi_range(32, 280)
	if global_position.distance_to(Vector2(to_pos_x, to_pos_y))<100:
		to_pos_x = randi_range(32, 514)
		to_pos_y = randi_range(32, 280)
	
