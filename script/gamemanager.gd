extends Node

@export var sparks: int = 0
@export var score: int = 0
@export var high_score: int = 0
@export var background_music_value: float = 100.0
@export var sound_effects_value: float = 100
@export var muted: bool = false
@export var is_fullscreen: bool=false
@export var screen_size: Vector2i = DisplayServer.window_get_size()
@export var initial_screen_size: Vector2 = DisplayServer.window_get_size()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
