extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $sprite

const SPEED = 150.0

func _ready() -> void:
	add_to_group("player")

func _physics_process(_delta: float) -> void:

	# Handle jump.
	var climb := Input.get_axis("up", "down")
	if climb:
		velocity.y = climb*SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if direction<0:
			sprite.flip_h=true
		else:
			sprite.flip_h=false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

#func _on_area_2d_body_entered(body: Node2D) -> void:
	#if body.is_in_group("spark"):
		#pass
