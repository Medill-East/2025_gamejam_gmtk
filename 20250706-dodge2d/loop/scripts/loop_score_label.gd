extends Label


func _ready():
	AUTOLOAD_SCORE.changed.connect(_on_score_changed)
	self.text = str(AUTOLOAD_SCORE.points)

#func _on_score_changed(p):
	#self.text = str(p)


func _on_score_changed(total: int, gained: int, bonus: int) -> void:
	text = str(total)                  # 显示总分
	#if bonus > 0:
		#show_popup("+%d BONUS!" % bonus)
