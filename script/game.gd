extends Node2D

@export var floorSc: PackedScene
@onready var health: AnimatedSprite2D = $CanvasLayer/health
@onready var gameover = $CanvasLayer/Game_Over
@onready var paused_menu: VBoxContainer = $CanvasLayer/Game_Over/paused_menu
@onready var game_over_menu: HBoxContainer = $CanvasLayer/Game_Over/game_over_menu
@export var enemy_scene: PackedScene

var player = null
var life = 100

@onready var stats: RichTextLabel = $CanvasLayer/stats
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("game")
	gameover.visible=false
	player  = get_tree().get_first_node_in_group("player")
	
	if player:
		life=player.current_light*100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	stats.text="Sparks collected: "+str(Gamemanager.sparks)+"\nScore: "+str(Gamemanager.score)
	if player:
		life=player.current_light*100
		check_life()
	game_over()
	
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
	
func game_over():
	if life==0:
		gameover.visible=true
		paused_menu.visible=false
		game_over_menu.visible=true
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
	get_tree().quit()
	
