extends KinematicBody2D

var velocity = Vector2()
const FLOOR=Vector2(0,-1)
const SPEED=21
const maxspeed=50
const GRAVITY= 10

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass


func _process(delta):

	velocity = move_and_slide(velocity,FLOOR)
