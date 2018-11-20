extends KinematicBody2D

var velocity = Vector2()
const FLOOR=Vector2(0,-1)
const SPEED=40
const maxspeed=50
const GRAVITY= 10


var is_dead=false
var direction=-1

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass


func _process(delta):
	if is_dead==false:
		velocity.x=SPEED*direction
		fliph()
		$AnimatedSprite.play("walk")
		velocity.y +=GRAVITY
		
	velocity = move_and_slide(velocity,FLOOR)
	
	if $RayCast2D.is_colliding()==false:
		direction=direction*-1
		$RayCast2D.position.x*=-1


func _on_Fliph_body_entered(body):
	if body.name!="Player" and body.name!="Enemy1":
		direction = direction*-1
		$RayCast2D.position.x*=-1

func fliph():
	if direction==-1:
		$AnimatedSprite.flip_h = false
		get_node("AnimatedSprite").position=Vector2(-12,-2.2)

	else:
		$AnimatedSprite.flip_h = true
		get_node("AnimatedSprite").position=Vector2(12,-2.2)

		
		
		
		