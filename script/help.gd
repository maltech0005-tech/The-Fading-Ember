extends Node2D

@onready var bg_music: AudioStreamPlayer2D = $bg_music
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DisplayServer.window_set_size(Gamemanager.screen_size)
	bg_music.volume_db=linear_to_db(Gamemanager.background_music_value/100)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
