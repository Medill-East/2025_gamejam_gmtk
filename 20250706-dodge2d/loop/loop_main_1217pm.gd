extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_popup01()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _popup01():
	print("popup01")
	var popup01 := preload("res://loop/popups/popup01.tscn").instantiate()
	add_child(popup01)
	popup01.open()        # 打开&暂停
