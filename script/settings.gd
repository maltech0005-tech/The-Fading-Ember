extends Node2D

@onready var master_v_slider: HSlider = $Main_Container/Audio_Volumes/VBoxContainer2/MasterV_container/MasterV_slider
@onready var music_v_slider: HSlider = $Main_Container/Audio_Volumes/VBoxContainer2/MusicV_container/MusicV_slider
@onready var sfxv_slider: HSlider = $Main_Container/Audio_Volumes/VBoxContainer2/SFXV_container/SFXV_slider

@onready var master_v_amnt: Label = $Main_Container/Audio_Volumes/VBoxContainer2/MasterV_container/MasterV_amnt
@onready var music_v_amnt: Label = $Main_Container/Audio_Volumes/VBoxContainer2/MusicV_container/MusicV_amnt
@onready var sfxv_amnt: Label = $Main_Container/Audio_Volumes/VBoxContainer2/SFXV_container/SFXV_amnt

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	check_values()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	check_values()

func check_values():
	master_v_amnt.text=str(master_v_slider.value)
	music_v_amnt.text=str(music_v_slider.value)
	sfxv_amnt.text=str(sfxv_slider.value)

func _on_apply_pressed() -> void:
	pass
	
func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_mute_toggled(_toggled_on: bool) -> void:
	pass # Replace with function body.
