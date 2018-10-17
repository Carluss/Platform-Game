extends KinematicBody2D

const GRAVITY= 10
const SPEED=21
const FLOOR=Vector2(0,-1)

var velocity = Vector2()

var is_dead=false
var direction = 1

var hitstun=0
var knockdir=Vector2(0,0)
const TYPE="ENEMY"


func _ready():
	pass
	


func dead():
	is_dead=true
	velocity = Vector2(0,0)
	$AnimatedSprite.play("dead")
	$CollisionShape2D.disabled = true
	get_node("CollisionShape2D").scale = Vector2(0, 0)
	$Timer.start()

func _physics_process(delta):
	
	#var detect = $Body.get_overlapping_bodies()
	
	if is_dead==false:
		
		velocity.x=SPEED* direction
		
		#if detect.size() !=0:
			#$AnimatedSprite.play("hit")
		
		if direction ==1:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
		
		$AnimatedSprite.play("walk")

		velocity.y +=GRAVITY

		velocity = move_and_slide(velocity,FLOOR)

	if is_on_wall():
		direction = direction * -1
		$RayCast2D.position.x*=-1

	if $RayCast2D.is_colliding()==false:
		direction=direction*-1
		$RayCast2D.position.x*=-1
		
	
func atck():
	if hitstun >0:
		hitstun -=1

	for body in $Body.get_overlapping_bodies():
		if hitstun == 0 and body.get("TYPE") != TYPE:
			hitstun=10
			knockdir= transform.origin - body.transform.origin
			
			

func _on_Timer_timeout():
	queue_free()
