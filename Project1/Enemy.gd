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
#---player
var react=false
var done=false
var attplayer=false

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
	
	if $SeePlayer.is_colliding()==true and done==false and is_dead==false:
		$AnimatedSprite.play("react")
		velocity.x=0
		react=true
	if $SeePlayer.is_colliding()==false:
		done=false
		
	if $AttPlayer.is_colliding()==true and is_dead==false:
		attplayer=true
		$SeePlayer.enabled=false
		$AnimatedSprite.play("attack")

	if $AttPlayer.is_colliding()==false:
		$SeePlayer.enabled=true
		
		
	if is_dead==false and react==false:
		if done==false and attplayer==false:
			velocity.x=SPEED*direction
		elif done==true and attplayer==false:
			velocity.x=SPEED+20*direction
		elif attplayer==true:
			velocity.x=0
		if direction==1:
			$AnimatedSprite.flip_h = false
			get_node("SeePlayer").rotation_degrees = 270
			get_node("AttPlayer").rotation_degrees = 270
		else:
			$AnimatedSprite.flip_h = true
			get_node("SeePlayer").rotation_degrees = 90
			get_node("AttPlayer").rotation_degrees = 90
		if attplayer==false:
			$AnimatedSprite.play("walk")

		velocity.y +=GRAVITY

	velocity = move_and_slide(velocity,FLOOR)

	if is_on_wall():
		direction = direction * -1
		$RayCast2D.position.x*=-1


	if $RayCast2D.is_colliding()==false:
		direction=direction*-1
		$RayCast2D.position.x*=-1

		
"""	
func atck():
	if hitstun >0:
		hitstun -=1

	for body in $Body.get_overlapping_bodies():
		if hitstun == 0 and body.get("TYPE") != TYPE:
			hitstun=10
			knockdir= transform.origin - body.transform.origin
"""			
			

func _on_Timer_timeout():
	queue_free()


func _on_AnimatedSprite_animation_finished():
	if attplayer==true:
		attplayer=false
	if react==true:
		done=true
		$AnimatedSprite.stop()
		react=false
		print(react)
