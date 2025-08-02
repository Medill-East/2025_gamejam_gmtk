extends Node2D

var popup01 := preload("res://loop/popups/popup01.tscn").instantiate()

@onready var clocklabel = $"Loop-clock"

var current_hour

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_popup01()
	await popup01.closed
	print("popup01closed")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#current_hour = await clocklabel.hour_tick
	#print(current_hour)

func _popup01():
	print("popup01")
	add_child(popup01)
	popup01.open()        # 打开&暂停

func _on_hour_tick(h):
	print("Ding！ %02d:00" % h)
