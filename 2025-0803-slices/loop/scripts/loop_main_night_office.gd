extends Node2D

var popup05 := preload("res://loop/popups/Dialogue/Dialogue_T05.tscn").instantiate()
var popup06 := preload("res://loop/popups/Dialogue/Dialogue_T06.tscn").instantiate()
var popup07 := preload("res://loop/popups/Dialogue/Dialogue_T07.tscn").instantiate()
var popup08 := preload("res://loop/popups/Dialogue/Dialogue_T08.tscn").instantiate()
var popupeod := preload("res://loop/popups/popup-eod.tscn").instantiate()

var current_hour

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_popup05()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _popup05():
	print("popup05")
	add_child(popup05)
	popup05.open()        # 打开&暂停	
