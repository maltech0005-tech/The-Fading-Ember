extends CharacterBody2D

@onready var agent: NavigationAgent2D = $NavigationAgent2D
@export var move_speed := 30.0
@export var repath_interval := 0.5
@export var knockback_decay := 0.1

var knockback_velocity := Vector2.ZERO
var repath_timer :float = 0.0
var player = null


func _ready() -> void:
	add_to_group("enemies")
	repath_timer=repath_interval
	agent.radius = 6.0
	agent.path_desired_distance = 4.0
	agent.target_desired_distance = 4.0
	agent.avoidance_enabled = false
	get_player()

func _physics_process(delta: float) -> void:	
	if player:
		repath_timer+=delta
		if repath_timer >= repath_interval:
			agent.target_position = player.global_position
			repath_timer = 0.0
		if agent.is_navigation_finished():
			velocity= knockback_velocity
		else:
			var next_pos: Vector2 = agent.get_next_path_position()
			var direction: Vector2 = (next_pos - global_position).normalized()
			velocity = direction * move_speed + knockback_velocity
	else:
		velocity = knockback_velocity
	move_and_slide()
	knockback_velocity = knockback_velocity.lerp(Vector2.ZERO, knockback_decay)

func get_player():
	player = get_tree().get_first_node_in_group('player')
	
func apply_knockback(source_position: Vector2, strength: float) -> void:
	var dir := (global_position - source_position).normalized()
	knockback_velocity = dir * strength
