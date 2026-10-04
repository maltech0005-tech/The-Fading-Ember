extends Node2D

@onready var balance: Label = $Main_Container/nav/balance
@onready var instant_refill: Label = $Inventory/Instant_refills
@onready var invincibility: Label = $Inventory/Invincibilities
@onready var spectra_blast: Label = $Inventory/spectra_blasts
@onready var revival: Label = $Inventory/revivals
@onready var toast: Label = $toast
@onready var toast_timer: Timer = $toast_timer
var sparks=Gamemanager.sparks
var instant_refills=Gamemanager.instant_refills
var invincibilities=Gamemanager.invincibilities
var spectra_blasts=Gamemanager.spectra_blasts
var revivals=Gamemanager.revivals

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_balance()
	DisplayServer.window_set_size(Gamemanager.screen_size)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
func _on_instant_refill_pressed() -> void:
	if sparks>=50:
		instant_refills+=1
		sparks-=50
		update_balance()
	else:
		start_toast()
		
func _on_invincibility_pressed() -> void:
	if sparks>=50:
		invincibilities+=1
		sparks-=50
		update_balance()
	else:
		start_toast()

func _on_spectra_blast_pressed() -> void:
	if sparks>=100:
		spectra_blasts+=1
		sparks-=100
		update_balance()
	else:
		start_toast()
		
func _on_revival_pressed() -> void:
	if sparks>=100:
		revivals+=1
		sparks-=100
		update_balance()
	else:
		start_toast()
	
func update_balance():
	Gamemanager.sparks=sparks
	Gamemanager.instant_refills=instant_refills
	Gamemanager.invincibilities=invincibilities
	Gamemanager.spectra_blasts=spectra_blasts
	Gamemanager.revivals=revivals
	balance.text="Balance: "+str(Gamemanager.sparks)+"                         "
	instant_refill.text=str(Gamemanager.instant_refills)
	invincibility.text=str(Gamemanager.invincibilities)
	spectra_blast.text=str(Gamemanager.spectra_blasts)
	revival.text=str(Gamemanager.revivals)
	Gamemanager.save_data()

func start_toast():
	toast.visible=true
	toast_timer.start(0.7)

func _on_toast_timer_timeout() -> void:
	toast.visible=false	
