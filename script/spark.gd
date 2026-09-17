extends Area2D
var player = null
@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("spark")
	player = get_tree().get_first_node_in_group("player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if player.current_light+0.2>1.0:
			player.current_light=1.0
		else:
			player.current_light=player.current_light+0.2
		Gamemanager.sparks+=1
		queue_free()
