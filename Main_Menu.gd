extends Node2D



func _on_Button_pressed():
	get_tree().change_scene_to(load("res://Main.tscn"))
	pass # Replace with function body.


#func _on_Button2_pressed():
#	get_tree().change_scene_to(load("res://Credits.gd"))
#	pass # Replace with function body.


func _on_Button3_pressed():
	get_tree().change_scene_to(load("res://How_to_play.tscn"))
	pass # Replace with function body.
