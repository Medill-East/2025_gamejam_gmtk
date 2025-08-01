extends CanvasLayer
class_name HUD

@export var _bar: TextureProgressBar

# 暴露给外部：更新可见性 & 进度
func update_hold_progress(ratio: float, visible: bool) -> void:
	_bar.visible = visible
	if visible:
		_bar.value = clamp(ratio * 100.0, 0.0, 100.0)
