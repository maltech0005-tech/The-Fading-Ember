extends Node2D

@onready var master_v_slider: HSlider = $Main_Container/Audio_Volumes/VBoxContainer2/MasterV_container/MasterV_slider
@onready var music_v_slider: HSlider = $Main_Container/Audio_Volumes/VBoxContainer2/MusicV_container/MusicV_slider
@onready var sfxv_slider: HSlider = $Main_Container/Audio_Volumes/VBoxContainer2/SFXV_container/SFXV_slider

@onready var master_v_amnt: Label = $Main_Container/Audio_Volumes/VBoxContainer2/MasterV_container/MasterV_amnt
@onready var music_v_amnt: Label = $Main_Container/Audio_Volumes/VBoxContainer2/MusicV_container/MusicV_amnt
@onready var sfxv_amnt: Label = $Main_Container/Audio_Volumes/VBoxContainer2/SFXV_container/SFXV_amnt
@onready var bg_music: AudioStreamPlayer2D = $bg_music
@onready var mute: CheckBox = $Main_Container/mute
@onready var toast: Label = $toast
@onready var toast_timer: Timer = $toast_timer

var game = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DisplayServer.window_set_size(Gamemanager.screen_size)
	master_v_slider.value=Gamemanager.background_music_value
	music_v_slider.value=Gamemanager.background_music_value
	sfxv_slider.value=Gamemanager.sound_effects_value
	mute.button_pressed=Gamemanager.muted

func _on_apply_pressed() -> void:
	toast.visible=true
	toast_timer.start(0.7)
	
func _on_toast_timer_timeout() -> void:
	toast.visible=false	
	
func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_mute_toggled(toggled_on: bool) -> void:
	var audio_bus_index=AudioServer.get_bus_index("Master")
	if toggled_on==true:
		Gamemanager.muted=true
		AudioServer.set_bus_mute(audio_bus_index, true)
	else:
		Gamemanager.muted=false
		AudioServer.set_bus_mute(audio_bus_index, false)
	
func update_sound():
	master_v_amnt.text=str(master_v_slider.value)
	music_v_amnt.text=str(music_v_slider.value)
	sfxv_amnt.text=str(sfxv_slider.value)
	Gamemanager.background_music_value=float(music_v_amnt.text)
	Gamemanager.sound_effects_value=float(sfxv_amnt.text)
	bg_music.volume_db=linear_to_db(Gamemanager.background_music_value/100)
	update_sounds()

func master_volume():
	music_v_slider.value=master_v_slider.value
	sfxv_slider.value=master_v_slider.value
	master_v_amnt.text=str(master_v_slider.value)
	music_v_amnt.text=str(master_v_slider.value)
	sfxv_amnt.text=str(master_v_slider.value)
	
	Gamemanager.background_music_value=float(music_v_amnt.text)
	Gamemanager.sound_effects_value=float(sfxv_amnt.text)
	bg_music.volume_db=linear_to_db(Gamemanager.background_music_value/100)
	update_sounds()
	
func _on_master_v_slider_value_changed(_value: float) -> void:
	master_volume()

func _on_music_v_slider_value_changed(_value: float) -> void:
	update_sound()

func _on_sfxv_slider_value_changed(_value: float) -> void:
	update_sound()

func update_sounds():
	game=get_tree().get_first_node_in_group("game")
	if game:
		game.update_sound()

func _on_option_button_item_selected(index: int) -> void:
	if index == 1:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	if index == 2:
		DisplayServer.window_set_size(Vector2i(1280, 720))
		Gamemanager.screen_size=Vector2i(1280, 720)
	if index == 3:
		DisplayServer.window_set_size(Vector2i(1600, 900))
		Gamemanager.screen_size=Vector2i(1600, 900)
	if index == 4:
		DisplayServer.window_set_size(Vector2i(1920, 1080))
		Gamemanager.screen_size=Vector2i(1920, 1080)
	if index == 5:
		DisplayServer.window_set_size(Vector2i(2560, 1440))
		Gamemanager.screen_size=Vector2i(2560, 1440)
