extends Area2D

var planted=false

func _on_Plant_body_entered(body):
	if body == get_node("../../Player") and not planted and body.seed_plant:
		$AnimationPlayer.play("Flower")
		planted=true
		body.seed_plant = false
	pass # Replace with function body.

func destroy():
	$AnimationPlayer.play("Flower Gone")
	planted=false
	
