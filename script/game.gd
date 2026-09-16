extends Node2D

@export var floorSc: PackedScene
var player = null
var fln_y=1
var fln_x=1
@onready var stats: RichTextLabel = $CanvasLayer/stats
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player  = get_tree().get_first_node_in_group("player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	stats.text="Sparks collected: "+str(Gamemanager.sparks)+"\nScore: "+str(Gamemanager.score)
	if floorSc:
		add_floor()
	
func get_floor_number():
	pass
	#if player.global_position:
	#if fln_x=1
	
func add_floor():
	pass
	#var floor1=floorSc.instantiate()
	#floor1.global_position=Vector2(0, 512)
	#add_child(floor1)
	#var floor2=floorSc.instantiate()
	#floor2.global_position=Vector2(0, -512)
	#add_child(floor2)
	#var floor3=floorSc.instantiate()
	#floor3.global_position=Vector2(-768, 512)
	#add_child(floor3)
	#var floor4=floorSc.instantiate()
	#floor4.global_position=Vector2(-768, -512)
	#add_child(floor4)
