extends KinematicBody2D
export var speed = 250
var velocity = Vector2()
var seed_plant = false

var timer_started = false

var idle_side=0
#0=down
#1=up
#2=left_right


func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
		if $AnimatedSprite.flip_h==true:
			$AnimatedSprite.flip_h=false
		$AnimatedSprite.play("Right_walk")
		idle_side=2
		_timer_manager("init")
	elif Input.is_action_pressed('ui_left'):
		velocity.x -= 1
		if $AnimatedSprite.flip_h==false:
			$AnimatedSprite.flip_h=true
		$AnimatedSprite.play("Right_walk")
		idle_side=2
		_timer_manager("init")
	elif Input.is_action_pressed('ui_down'):
		velocity.y += 1
		$AnimatedSprite.play("Down_walk")
		idle_side=0
		_timer_manager("init")
	elif Input.is_action_pressed('ui_up'):
		velocity.y -= 1
		$AnimatedSprite.play("Up_walk")
		idle_side=1
		_timer_manager("init")
	else:
		idle_manager(idle_side)
	velocity = velocity.normalized() * speed	

func _process(delta):
	_timer_manager("set_time_on_label")
	_seed_manager()

func _physics_process(delta):
	get_input()
	move_and_collide(velocity * delta)

func _seed_manager():
	if seed_plant == true:
		$Camera2D/Seed_Label.text="Seed 1"
	else:
		$Camera2D/Seed_Label.text="Seed 0"

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

func _timer_manager(cmd):
	if cmd == "init":
		if not timer_started:
			$Timer.start(10)
			print("Timer started")
			timer_started=true
	elif cmd == "set_time_on_label":
		$Camera2D/Timer_Label.text="Time Left : "+str($Timer.time_left)


func _on_Timer_timeout():
	print("Time out")
	pass # Replace with function body.
