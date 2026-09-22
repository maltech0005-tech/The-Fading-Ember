extends Area2D
var player = null
@onready var timer: Timer = $Timer
@onready var collision1: CollisionShape2D = $CollisionShape2D
@onready var collected: AudioStreamPlayer2D = $collected

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("spark")
	player = get_tree().get_first_node_in_group("player")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		collected.volume_db=linear_to_db(Gamemanager.sound_effects_value/100)
		collected.play()
		if player.current_light+0.2>1.0:
			player.current_light=1.0
		else:
			player.current_light=player.current_light+0.2
		Gamemanager.sparks+=1
		collision1.set_deferred("disabled", true)
		visible=false
		timer.start(15)

func _on_timer_timeout() -> void:
	collision1.set_deferred("disabled", false)
	visible=true
	
	
