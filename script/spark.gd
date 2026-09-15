extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("spark")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Gamemanager.sparks+=1
		queue_free()
