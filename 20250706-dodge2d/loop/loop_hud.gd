extends CanvasLayer
class_name HUD
static var instance: HUD

#@export var _bar: ProgressBar

## 暴露给外部：更新可见性 & 进度
#func update_hold_progress(ratio: float, visible: bool) -> void:
	#_bar.visible = true
	#if _bar.visible == true:
		#_bar.value = clamp(ratio * 100.0, 0.0, 100.0)

@onready var _overlay := Control.new()   # 专门装世界条
var bar_scene := preload("res://loop/loop-worldholdbar.tscn")

func _ready():
	instance = self
	add_child(_overlay)

func create_world_bar() -> Control:
	var b: Control = bar_scene.instantiate()
	_overlay.add_child(b)
	return b
