extends CanvasLayer
class_name PopupStatic

@export var default_text: String = "这是静态弹窗内容。\n点击任意处关闭。"
@export var pause_on_open: bool = true

@export var _label: RichTextLabel
@export var _panel: Panel
@export var _btn: TextureButton

func _ready() -> void:
	visible = false
	_label.text = default_text

	_panel.gui_input.connect(_on_panel_input)
	_btn.pressed.connect(close)

# -------- 公共接口 --------
func open() -> void:
	_label.text = default_text
	visible = true
	if pause_on_open:
		get_tree().paused = true

func close() -> void:
	if pause_on_open:
		get_tree().paused = false
	visible = false

# -------- 内部 --------
func _on_panel_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		close()
