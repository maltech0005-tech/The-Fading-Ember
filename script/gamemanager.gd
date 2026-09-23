extends Node

const save_path = "user://fading_ember.save"
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
	load_data()
	score=0
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if high_score<score:
		high_score=score
	
func save_data():
	var data_dict = {
		"sparks": sparks,
		"score": score,
		"high_score": high_score,
		"background_music_value": background_music_value,
		"sound_effects_value": sound_effects_value,
		"muted": muted,
		"is_fullscreen": is_fullscreen,
		"initial_screen_size": initial_screen_size,
		"screen_size_x": screen_size.x,
		"screen_size_y": screen_size.y,
		"initial_screen_size_x": initial_screen_size.x,
		"initial_screen_size_y": initial_screen_size.y
	}
	
	var json_string = JSON.stringify(data_dict)
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if file:
		file.store_string(json_string)
		file.close()
	
func load_data():
	if not FileAccess.file_exists(save_path):
		return
	var file = FileAccess.open(save_path, FileAccess.READ)
	
	if not file:
		return
	
	var json_string = file.get_as_text()
	file.close()
	var json = JSON.new()
	var check_error = json.parse(json_string)
	if check_error==OK:
		var data_dict=json.data
		sparks = data_dict.get("sparks", sparks)
		score = data_dict.get("score", score)
		high_score = data_dict.get("high_score", high_score)
		background_music_value = data_dict.get("background_music_value", background_music_value)
		sound_effects_value = data_dict.get("sound_effects_value", sound_effects_value)
		muted = data_dict.get("muted", muted)
		is_fullscreen = data_dict.get("is_fullscreen", is_fullscreen)
		screen_size = Vector2i(int(data_dict.get("screen_size_x", screen_size.x)), int(data_dict.get("screen_size_y", screen_size.y)))
		initial_screen_size = Vector2i(int(data_dict.get("initial_screen_size_x", initial_screen_size.x)), int(data_dict.get("initial_screen_size_y", initial_screen_size.y)))
		
func check_and_load_data():
	save_data()
