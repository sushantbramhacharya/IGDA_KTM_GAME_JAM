extends KinematicBody2D
export var speed = 250
var velocity = Vector2()
var seed_plant = false
export var time=25
export var time_evil=23
var evil =false
var plant =0 
var timer_started = false

var idle_side=0
#0=down
#1=up
#2=left_right


func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
		if evil== false:
			if $AnimatedSprite.flip_h==true:
				$AnimatedSprite.flip_h=false
			$AnimatedSprite.play("Right_walk")
			idle_side=2
		timer_manager("init")
	elif Input.is_action_pressed('ui_left'):
		velocity.x -= 1
		if evil== false:
			if $AnimatedSprite.flip_h==false:
				$AnimatedSprite.flip_h=true
			$AnimatedSprite.play("Right_walk")
			idle_side=2
		timer_manager("init")
	elif Input.is_action_pressed('ui_down'):
		velocity.y += 1
		if evil== false:
			$AnimatedSprite.play("Down_walk")
			idle_side=0
		timer_manager("init")
	elif Input.is_action_pressed('ui_up'):
		velocity.y -= 1
		if evil== false:
			$AnimatedSprite.play("Up_walk")
			idle_side=1
		timer_manager("init")
	else:
		if evil== false:
			idle_manager(idle_side)
	velocity = velocity.normalized() * speed	

func _process(delta):
	$Camera2D/Main_Timer_Label.text="Main Timer :"+str($"Main Timer".time_left)
	timer_manager("set_time_on_label")
	timer_manager("timer_color")
	_seed_manager()
	if plant == 10:
		if $"Main Timer".wait_time==300:
			get_tree().change_scene("res://Next Level.tscn")
		else :
			get_tree().change_scene("res://You win.tscn")

func _physics_process(delta):
	get_input()
	move_and_collide(velocity * delta)

func _seed_manager():
	if seed_plant == true:
		$Camera2D/Seed_Label.text="Seed 1"
		$Camera2D/Seed_Label.set("custom_colors/font_color",Color(255,255,255))
	else:
		$Camera2D/Seed_Label.text="Seed 0"
		$Camera2D/Seed_Label.set("custom_colors/font_color",Color(255,0,0))

func _on_Seed_Area_body_entered(body):
	if body==self:
		seed_plant=true
	pass # Replace with function body.

func idle_manager(idle_side):
	if idle_side==0:
		$AnimatedSprite.play("Idle_down")
	elif idle_side==1:
		$AnimatedSprite.play("Idle_up")
	elif idle_side==2:
		$AnimatedSprite.play("Idle_right")

func timer_manager(cmd):
	if $Timer.time_left<time_evil:
		evil=false
	if cmd == "init":
		if not timer_started:
			$Timer.start(time)
			print("Timer started")
			timer_started=true
	elif cmd == "reset_timer":
		$Timer.start(time)
	elif cmd == "set_time_on_label":
		$Camera2D/Timer_Label.text="Time Left : "+str($Timer.time_left)
	elif cmd == "timer_color":
		if $"Main Timer".time_left < 10:
			$Camera2D/Main_Timer_Label.set("size",60)
			$Camera2D/Main_Timer_Label.set("custom_colors/font_color",Color(255,0,0))
		if $Timer.time_left < 5:
			$Camera2D/Timer_Label.set("size",60)
			$Camera2D/Timer_Label.set("custom_colors/font_color",Color(255,0,0))
		else :
			$Camera2D/Timer_Label.set("size",40)
			$Camera2D/Timer_Label.set("custom_colors/font_color",Color(255,255,255))
func _evil_controller():
	evil=true
	$AnimatedSprite.play("Evil")

func _on_Timer_timeout():
	get_node("../Plants/Plant").destroy()
	get_node("../Plants/Plant2").destroy()
	get_node("../Plants/Plant3").destroy()
	get_node("../Plants/Plant4").destroy()
	get_node("../Plants/Plant5").destroy()
	get_node("../Plants/Plant6").destroy()
	get_node("../Plants/Plant7").destroy()
	get_node("../Plants/Plant8").destroy()
	get_node("../Plants/Plant9").destroy()
	get_node("../Plants/Plant10").destroy()
	seed_plant=false
	timer_manager("reset_timer")
	print("Time out")
	_evil_controller()
	pass # Replace with function body.

func plant_manager(cmd):
	if cmd == "add":
		plant+=1
	if cmd == "reset":
		plant=0
	$Camera2D/Plant_label.text = "Plant : "+str(plant)


func _on_Main_Timer_timeout():
	get_tree().change_scene("res://Game Over.gd") 
	pass # Replace with function body.
