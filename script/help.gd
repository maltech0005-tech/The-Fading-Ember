extends Node2D

@onready var bg_music: AudioStreamPlayer2D = $bg_music
@onready var visual_guide_2: Node2D = $visual_guide2
@onready var game_play_1: AnimatedSprite2D = $visual_guide2/game_play1
@onready var img_1: RichTextLabel = $visual_guide2/game_play1/img1
@onready var img_2: RichTextLabel = $visual_guide2/game_play1/img2
@onready var img_3: RichTextLabel = $visual_guide2/game_play1/img3
@onready var img_4: RichTextLabel = $visual_guide2/game_play1/img4
@onready var img_5: RichTextLabel = $visual_guide2/game_play1/img5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DisplayServer.window_set_size(Gamemanager.screen_size)
	bg_music.volume_db=linear_to_db(Gamemanager.background_music_value/100)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
func _on_next_pressed() -> void:
	if img_1.visible==true:
		img_1.visible=false
		game_play_1.play("2")
		img_2.visible=true
		
	elif img_2.visible==true:
		img_2.visible=false
		game_play_1.play("3")
		img_3.visible=true
		
	elif img_3.visible==true:
		img_3.visible=false	
		game_play_1.play("4")
		img_4.visible=true
		
	elif img_4.visible==true:
		img_4.visible=false
		game_play_1.play("5")
		img_5.visible=true
		
	elif img_5.visible==true:
		pass
	
func _on_previous_pressed() -> void:
	if img_1.visible==true:
		pass
		
	elif img_2.visible==true:
		img_2.visible=false
		game_play_1.play("1")
		img_1.visible=true
		
	elif img_3.visible==true:
		img_3.visible=false
		game_play_1.play("2")
		img_2.visible=true
		
	elif img_4.visible==true:
		img_4.visible=false
		game_play_1.play("3")
		img_3.visible=true
		
	elif img_5.visible==true:
		img_5.visible=false
		game_play_1.play("4")
		img_4.visible=true
		
func _on_back_2_pressed() -> void:
	visual_guide_2.visible=false

func _on_visual_guide_button_pressed() -> void:
	visual_guide_2.visible=true
