extends KinematicBody2D

const GRAVITY= 10
const SPEED=30
const FLOOR=Vector2(0,-1)

var velocity = Vector2()

var is_hit=false
var on_ground = false

func _ready():
	pass
	
func hit():
	is_hit=true

func _physics_process(delta):
	if is_hit==true and on_ground==false:
		velocity.y +=GRAVITY
		
	velocity = move_and_slide(velocity,FLOOR)
	
	if is_on_floor():
		on_ground=true
	
	

