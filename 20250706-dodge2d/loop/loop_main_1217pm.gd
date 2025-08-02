extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#pass # Replace with function body.
	get_tree().paused = true
	#HUD.instance.show_fail_label("GAME OVER！")
	POPUP.instance.update_text("Eric 被困在日复一日的无聊工作中，他希望在办公室里搞点破坏，好让老板给他们放个大假。或许，不止员工们想放假...!")
	POPUP.instance.open()
	_popup()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _popup():
	var popup := preload("res://loop/popup.tscn").instantiate()
	add_child(popup)
	popup.open()        # 打开&暂停
