extends Node2D

@onready var stats: RichTextLabel = $CanvasLayer/stats
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	stats.text="Sparks collected: "+str(Gamemanager.sparks)+"\nScore: "+str(Gamemanager.score)
