extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $sprite
@onready var point_light_2d: PointLight2D = $sprite/PointLight2D
@onready var collide_range: CollisionShape2D = $range/collide_range
@onready var respawn_enemy: Timer = $respawn_enemy
@onready var invincibility_timer: Timer = $invincibility_timer
@onready var spetra_timer: Timer = $spetra_timer

var collision_radius:float=88.0
const SPEED = 150.0
var current_light: float=1.0
var is_invincible= false
var is_spectrablast = false

var enemy = null
var game=null
var enemy_pos_init:Vector2

func _ready() -> void:
	add_to_group("player")
	game=get_tree().get_first_node_in_group("game")
	enemy=get_tree().get_first_node_in_group("enemies")

func _physics_process(delta: float) -> void:
	if is_invincible:
		point_light_2d.texture_scale=current_light
	else:
		if current_light-0.05*delta<0.0:
			current_light=0
		else:
			current_light-=0.05*delta
			point_light_2d.texture_scale=current_light
	
	if not is_spectrablast:
		collide_range.shape.radius=collision_radius*point_light_2d.texture_scale
	else:
		collide_range.shape.radius=200 #191 was enough for the camera viewable part

	# Handle jump.
	var climb := Input.get_axis("up", "down")
	if climb:
		velocity.y = climb*SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		if direction<0:
			sprite.flip_h=true
		else:
			sprite.flip_h=false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.die()
		Gamemanager.score+=1
		if is_invincible:
			pass
		else:
			current_light-=0.1
		enemy_pos_init=body.intial_pos
		respawn_enemy.start(3)
		
func _on_respawn_enemy_timeout() -> void:
	enemy=get_tree().get_first_node_in_group("enemies")
	game=get_tree().get_first_node_in_group("game")
	game.respawn()
	if enemy:
		enemy.queue_free()
	
func start_invincibility():
	game=get_tree().get_first_node_in_group("game")
	game.reviving=true
	sprite.modulate = Color(1.0, 0.85, 0.2, 0.8)
	invincibility_timer.start(8)

func _on_invincibility_timer_timeout() -> void:
	game.reviving=false
	is_invincible=false
	sprite.modulate = Color.WHITE
	
func spectrablast():
	game=get_tree().get_first_node_in_group("game")
	sprite.modulate = Color(0.213, 0.379, 0.791, 0.8)
	game.canvas_modulate.color=Color.WHITE
	is_spectrablast=true
	is_invincible= true
	spetra_timer.start(3)

func _on_spetra_timer_timeout() -> void:
	game=get_tree().get_first_node_in_group("game")
	sprite.modulate = Color.WHITE
	game.canvas_modulate.color = Color(0.01, 0.01, 0.01, 0.78)
	is_spectrablast=false
	is_invincible= false
	
