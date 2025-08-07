extends Node
class_name Slicegame

static var instance: Slicegame

var popupwarning1 := preload("res://slices/slices-popup-warning1.tscn").instantiate()
var popupwarning2 := preload("res://slices/slices-popup-warning2.tscn").instantiate()
var popupwarning3 := preload("res://slices/slices-popup-warning3.tscn").instantiate()
var popupwarning4 := preload("res://slices/slices-popup-warning4.tscn").instantiate()
var popupwarning5 := preload("res://slices/slices-popup-warning5.tscn").instantiate()
var popupwarning6 := preload("res://slices/slices-popup-warning6.tscn").instantiate()
var popupwarning7 := preload("res://slices/slices-popup-warning7.tscn").instantiate()
var popupwarning8 := preload("res://slices/slices-popup-warning8.tscn").instantiate()
var popupwarning9 := preload("res://slices/slices-popup-warning9.tscn").instantiate()
var popupwarning10 := preload("res://slices/slices-popup-warning10.tscn").instantiate()
var popupwarning11 := preload("res://slices/slices-popup-warning11.tscn").instantiate()
var popupwarning12 := preload("res://slices/slices-popup-warning12.tscn").instantiate()
var popupwarning13 := preload("res://slices/slices-popup-warning13.tscn").instantiate()
var popupwarning14 := preload("res://slices/slices-popup-warning14.tscn").instantiate()
var popupwarning15 := preload("res://slices/slices-popup-warning15.tscn").instantiate()
var popupwarning16 := preload("res://slices/slices-popup-warning16.tscn").instantiate()
var popupwarning17 := preload("res://slices/slices-popup-warning17.tscn").instantiate()
var popupwarning18 := preload("res://slices/slices-popup-warning18.tscn").instantiate()

func _ready() -> void:
	instance = self
	
	

func _popupwarning1():
	print("popupwarning1")
	#add_child(popupwarning1)
	#popupwarning1.open()        # 打开&暂停	
	call_deferred("add_child", popupwarning1)
	popupwarning1.call_deferred("open")


func _popupwarning2():
	print("popupwarning2")
	#add_child(popupwarning2)
	#popupwarning2.open()        # 打开&暂停	
	call_deferred("add_child", popupwarning2)
	popupwarning2.call_deferred("open")

	
func _popupwarning3():
	print("popupwarning3")
	#add_child(popupwarning3)
	#popupwarning3.open()        # 打开&暂停	
	call_deferred("add_child", popupwarning3)
	popupwarning3.call_deferred("open")
	
func _popupwarning4():
	print("popupwarning4")
	#add_child(popupwarning4)
	#popupwarning4.open()        # 打开&暂停	
	call_deferred("add_child", popupwarning4)
	popupwarning4.call_deferred("open")

func _popupwarning5():
	print("popupwarning5")
	#add_child(popupwarning5)
	#popupwarning5.open()        # 打开&暂停	
	call_deferred("add_child", popupwarning5)
	popupwarning5.call_deferred("open")

func _popupwarning6():
	print("popupwarning6")
	#add_child(popupwarning6)
	#popupwarning6.open()        # 打开&暂停	
	call_deferred("add_child", popupwarning6)
	popupwarning6.call_deferred("open")

func _popupwarning7():
	print("popupwarning7")
	#add_child(popupwarning7)
	#popupwarning7.open()        # 打开&暂停	
	call_deferred("add_child", popupwarning7)
	popupwarning7.call_deferred("open")
	
func _popupwarning8():
	print("popupwarning8")
	#add_child(popupwarning8)
	#popupwarning8.open()        # 打开&暂停	
	call_deferred("add_child", popupwarning8)
	popupwarning8.call_deferred("open")
	
func _popupwarning9():
	print("popupwarning9")
	#add_child(popupwarning9)
	#popupwarning9.open()        # 打开&暂停	
	call_deferred("add_child", popupwarning9)
	popupwarning9.call_deferred("open")

func _popupwarning10():
	print("popupwarning10")
	#add_child(popupwarning10)
	#popupwarning10.open()        # 打开&暂停	
	call_deferred("add_child", popupwarning10)
	popupwarning10.call_deferred("open")

func _popupwarning11():
	print("popupwarning11")
	#add_child(popupwarning11)
	#popupwarning11.open()        # 打开&暂停	
	call_deferred("add_child", popupwarning11)
	popupwarning11.call_deferred("open")

func _popupwarning12():
	print("popupwarning12")
	#add_child(popupwarning12)
	#popupwarning12.open()        # 打开&暂停	
	call_deferred("add_child", popupwarning12)
	popupwarning12.call_deferred("open")
	
func _popupwarning13():
	print("popupwarning13")
	#add_child(popupwarning13)
	#popupwarning13.open()        # 打开&暂停	
	call_deferred("add_child", popupwarning13)
	popupwarning13.call_deferred("open")
	
func _popupwarning14():
	print("popupwarning14")
	#add_child(popupwarning14)
	#popupwarning14.open()        # 打开&暂停	
	call_deferred("add_child", popupwarning14)
	popupwarning14.call_deferred("open")

func _popupwarning15():
	print("popupwarning15")
	#add_child(popupwarning15)
	#popupwarning15.open()        # 打开&暂停	
	call_deferred("add_child", popupwarning15)
	popupwarning15.call_deferred("open")

func _popupwarning16():
	print("popupwarning16")
	#add_child(popupwarning14)
	#popupwarning14.open()        # 打开&暂停	
	call_deferred("add_child", popupwarning16)
	popupwarning16.call_deferred("open")

func _popupwarning17():
	print("popupwarning17")
	#add_child(popupwarning15)
	#popupwarning15.open()        # 打开&暂停	
	call_deferred("add_child", popupwarning17)
	popupwarning17.call_deferred("open")

func _popupwarning18():
	print("popupwarning18")
	#add_child(popupwarning15)
	#popupwarning15.open()        # 打开&暂停	
	call_deferred("add_child", popupwarning18)
	popupwarning18.call_deferred("open")

func fail():
	get_tree().paused = true
	#HUD.instance.show_fail_label("GAME OVER！")
	#POPUP.instance.update_text("GAME OVER!")
	#POPUP.instance.open()
	print("warning")
	#await POPUP.instance.closed
	if AUTOLOAD_SCORE.death <= 17:
		match AUTOLOAD_SCORE.death:	 
					1: _popupwarning1() 
					2: _popupwarning2() 
					3: _popupwarning3() 
					4: _popupwarning4() 
					5: _popupwarning5() 				
					6: _popupwarning6() 
					7: _popupwarning7() 
					8: _popupwarning8() 
					9: _popupwarning9() 
					10: _popupwarning10() 		
					11: _popupwarning11() 
					12: _popupwarning12() 
					13: _popupwarning13() 
					14: _popupwarning14() 
					15: _popupwarning15() 		
					16: _popupwarning16() 		
					17: _popupwarning17() 		
	#_popupwarning()
	if AUTOLOAD_SCORE.death == 18:
		_popupwarning18()
	#if AUTOLOAD_SCORE.health <= 0:
		#POPUP.instance.close()
		#get_tree().change_scene_to_file("res://loop/Start.tscn")
