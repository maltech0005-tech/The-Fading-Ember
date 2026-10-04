extends Node2D

@export var floorSc: PackedScene
@onready var health: AnimatedSprite2D = $CanvasLayer/health
@onready var gameover = $CanvasLayer/Game_Over
@onready var paused_menu: VBoxContainer = $CanvasLayer/Game_Over/paused_menu
@onready var game_over_menu: HBoxContainer = $CanvasLayer/Game_Over/game_over_menu
@export var enemy_scene: PackedScene
@onready var death_sound: AudioStreamPlayer2D = $"death sound"
@onready var background: AudioStreamPlayer2D = $background
@onready var highscore: Label = $CanvasLayer/highscore
@onready var instant_refills: Label = $CanvasLayer/Power_ups/Instant_refills
@onready var invincibilities: Label = $CanvasLayer/Power_ups/Invincibilities
@onready var spectra_blasts: Label = $CanvasLayer/Power_ups/spectra_blasts
@onready var revivals: Label = $CanvasLayer/Power_ups/revivals
@onready var canvas_modulate: CanvasModulate = $CanvasModulate
@onready var revive: Button = $CanvasLayer/Game_Over/game_over_menu/revive
@onready var gameover_label: Label = $CanvasLayer/Game_Over/GameOver
@onready var refill_sound: AudioStreamPlayer2D = $refill_sound
@onready var invincible_sound: AudioStreamPlayer2D = $invincible_sound
@onready var blast_sound: AudioStreamPlayer2D = $blast_sound
@onready var revive_sound: AudioStreamPlayer2D = $revive_sound

var bg_sound_value=Gamemanager.background_music_value
var death_sound_value=Gamemanager.sound_effects_value

var player = null
var life = 100
var reviving= false

@onready var stats: RichTextLabel = $CanvasLayer/stats
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Gamemanager.score=0
	update_powerups()
	DisplayServer.window_set_size(Gamemanager.screen_size)
	add_to_group("game")
	background.volume_db=linear_to_db(Gamemanager.background_music_value/100)
	gameover.visible=false
	player  = get_tree().get_first_node_in_group("player")
	
	if player:
		life=player.current_light*100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	stats.text="Sparks collected: "+str(Gamemanager.sparks)+"\nScore: "+str(Gamemanager.score)
	highscore.text="THE FADING EMBER\nHIGH SCORE: "+str(Gamemanager.high_score)
	if player:
		life=player.current_light*100
		check_life()
		
	if Input.is_action_just_pressed("pause"):
		_on_pause_pressed()
		
	if Input.is_action_pressed("restart"):
		get_tree().reload_current_scene()
		
	if Input.is_action_just_pressed("instant_refill"):
		instant_refill_pressed()
		
	if Input.is_action_just_pressed("invincibility"):
		invincibility_pressed()
		
	if Input.is_action_just_pressed("spectra_blast"):
		spectra_blast_pressed()
		
	if not reviving:	
		game_over()
	else:
		pass
		
func check_life():
	if 90<life and life<=100:
		health.play("10")
	elif 80<life and life<=90:
		health.play("9")
	elif 70<life and life<=80:
		health.play("8")
	elif 60<life and life<=70:
		health.play("7")
	elif 50<life and life<=60:
		health.play("6")
	elif 40<life and life<=50:
		health.play("5")
	elif 30<life and life<=40:
		health.play("4")
	elif 20<life and life<=30:
		health.play("3")
	elif 10<life and life<=20:
		health.play("2")
	elif 0<life and life<=10:
		health.play("1")
	else:
		health.play("0")
		death_sound.play()
	
func game_over():
	if life==0:
		death_sound.volume_db=linear_to_db(Gamemanager.sound_effects_value/100)
		death_sound.play()
		await death_sound.finished
		gameover_label.visible=true
		gameover.visible=true
		paused_menu.visible=false
		game_over_menu.visible=true
		Gamemanager.check_and_load_data()
		get_tree().paused=true
		
func respawn():
	var enemy1=enemy_scene.instantiate()
	enemy1.global_position= player.enemy_pos_init
	add_child(enemy1)
		
func _on_pause_pressed() -> void:
	gameover.visible=true
	paused_menu.visible=true
	game_over_menu.visible=false
	get_tree().paused=true	

func _on_continue_pressed() -> void:
	gameover.visible=false
	get_tree().paused=false	

func _on_restart_pressed() -> void:
	get_tree().paused=false	
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	get_tree().paused=false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
func _on_revive_pressed() -> void:
	if Gamemanager.revivals<1:
		return
	Gamemanager.revivals-=1
	update_powerups()
	get_tree().paused=false
	revive_sound.play()
	reviving = true
	player=get_tree().get_first_node_in_group("player")
	player.current_light=1.0
	player.start_invincibility()
	gameover_label.visible=false
	gameover.visible=false
	paused_menu.visible=false
	game_over_menu.visible=false
	
func update_sound():
	background.volume_db=linear_to_db(Gamemanager.background_music_value/100)
	
func update_powerups():
	instant_refills.text=str(Gamemanager.instant_refills)
	invincibilities.text=str(Gamemanager.invincibilities)
	spectra_blasts.text=str(Gamemanager.spectra_blasts)
	revivals.text=str(Gamemanager.revivals)
	revive.text="Revive ("+str(Gamemanager.revivals)+")"
	
func instant_refill_pressed():
	if Gamemanager.instant_refills>0:
		player.current_light=1.0
		Gamemanager.instant_refills-=1
		refill_sound.play()
		update_powerups()
	else:
		pass
	
func invincibility_pressed():
	if Gamemanager.invincibilities>0:
		Gamemanager.invincibilities-=1
		invincible_sound.play()
		update_powerups()
		player.start_invincibility()
	else:
		pass
	
func spectra_blast_pressed():
	if Gamemanager.spectra_blasts>0:
		Gamemanager.spectra_blasts-=1
		blast_sound.play()
		update_powerups()
		player.spectrablast()
	
