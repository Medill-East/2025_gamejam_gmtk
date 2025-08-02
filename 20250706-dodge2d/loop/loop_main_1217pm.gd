extends Node2D

var popup01 := preload("res://loop/popups/Dialogue/Dialogue_T01.tscn").instantiate()
var popup02 := preload("res://loop/popups/Dialogue/Dialogue_T02.tscn").instantiate()
var popup03 := preload("res://loop/popups/Dialogue/Dialogue_T03.tscn").instantiate()
var popup04 := preload("res://loop/popups/Dialogue/Dialogue_T04.tscn").instantiate()
var popup05 := preload("res://loop/popups/Dialogue/Dialogue_T05.tscn").instantiate()
var popup06 := preload("res://loop/popups/Dialogue/Dialogue_T06.tscn").instantiate()
var popup07 := preload("res://loop/popups/Dialogue/Dialogue_T07.tscn").instantiate()
var popup08 := preload("res://loop/popups/Dialogue/Dialogue_T08.tscn").instantiate()

@onready var clocklabel = $"Loop-clock"

var current_hour

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_popup01()
	await popup01.closed
	#print("popup01closed")
	_popup02()
	await popup02.closed
	#print("popup02closed")
	
	await _wait_hour(9)

func _wait_hour(target: int):
	while true:
		var hour : int = await clocklabel.hour_tick   # 等下一次整点
		#print(hour)
		if hour == target:
			if target == 9:
				_popup03()
			break                                     # 满足→退出函数执行一次

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#current_hour = await clocklabel.hour_tick
	#print(current_hour)
	#if current_hour == 20:
		#_popup03()

func _on_hour_tick(h):
	print("Ding！ %02d:00" % h)

func _popup01():
	print("popup01")
	add_child(popup01)
	popup01.open()        # 打开&暂停
	
func _popup02():
	print("popup02")
	add_child(popup02)
	popup02.open()        # 打开&暂停	

func _popup03():
	print("popup03")
	add_child(popup03)
	popup03.open()        # 打开&暂停	
