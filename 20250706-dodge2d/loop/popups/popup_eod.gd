extends CanvasLayer
class_name POPUPEOD
static var instance: POPUPEOD

@export var default_text: String = "这是静态弹窗内容。\n点击任意处关闭。"
@export var pause_on_open: bool = true

@export var _label: RichTextLabel
@export var _panel: Panel
@export var _btn: Button

@onready var _day: RichTextLabel = $Panel/Day
@onready var _required_destruction: RichTextLabel = $Panel/RequiredDestruction
@onready var _total_destruction: RichTextLabel = $"Panel/Total Destruction"
var currentText: String

signal closed

func _ready() -> void:
	instance = self
	visible = false
	currentText = _label.text

	_panel.gui_input.connect(_on_panel_input)
	#_btn.pressed.connect(close)
	#currentText = "Do your job!"

# -------- 公共接口 --------
func open() -> void:
	_label.text = currentText
	visible = true
	if pause_on_open:
		get_tree().paused = true

func close() -> void:
	if pause_on_open:
		get_tree().paused = false
	visible = false
	emit_signal("closed")

func update_text(string: String):
	currentText = string
	
func update_score(day: String, required: String, total: String):
	_day.text = day
	_required_destruction.text = required
	_total_destruction.text = total

# -------- 内部 --------
func _on_panel_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		close()


func _on_close_button_pressed() -> void:
	print("pressed to close")
	close()
