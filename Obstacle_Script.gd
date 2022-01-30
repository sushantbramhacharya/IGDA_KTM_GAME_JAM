extends KinematicBody2D

export var X=0
export var X_neg=0
export var Y=0
export var Y_neg=0
export var speed=10

var move_x=true
var move_y=true

var _position_x_positive
var _position_x_negetive
var _position_y_positive
var _position_y_negetive

func _ready():
	_position_x_positive=position.x+X
	_position_x_negetive=position.x-X_neg
	_position_y_positive=position.y-Y
	_position_y_negetive=position.y+Y_neg
	print(_position_x_positive)
	print(_position_x_negetive)
	print(_position_y_positive)
	print(_position_y_negetive)

func _physics_process(delta):
	if X != 0:
		if position.x <_position_x_positive and move_x:
			position.x+=speed
		else:
			move_x=false
		if position.x>_position_x_negetive and not move_x:
			position.x-=speed
		else:
			move_x=true
	elif Y !=0:
		if position.y >_position_y_positive and move_y:
			position.y-=speed
		else:
			move_y=false
		if position.y<_position_y_negetive and not move_y:
			position.y+=speed
		else:
			move_y=true
