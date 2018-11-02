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
	get_node("is_on_wall/CollisionShape2D").scale = Vector2(0, 0)
	$Timer.start()

func _physics_process(delta):
	if ($SeePlayer.is_colliding()==true or $Playerabove.is_colliding()==true) and is_dead==false:
		velocity.x=0
		if $AttPlayer.is_colliding()==true or $Playerabove.is_colliding()==true:
			$AnimatedSprite.visible=false
			$Animatedattack.visible=true
			attplayer=true
			react=false
			$Animatedattack.play("attack")
		elif done==false:
			$AnimatedSprite.play("react")
			react=true	
			
	if $SeePlayer.is_colliding()==false:
		done=false
		
	if ($AttPlayer.is_colliding()==false or $Playerabove.is_colliding()==false) and attplayer==false:
		$AnimatedSprite.visible=true
		$Animatedattack.visible=false
		$Animatedattack.stop()
		
	if 	is_dead==true:
		$AnimatedSprite.visible=true
		$Animatedattack.visible=false
		$Animatedattack.stop()
		
	if ($AttPlayer.is_colliding()==false or $Playerabove.is_colliding()==false):
		$SeePlayer.enabled=true
		
		
	if is_dead==false and react==false and attplayer==false:
		if done==false and attplayer==false:
			velocity.x=SPEED*direction
		elif done==true and attplayer==false:
			velocity.x=(SPEED+30)*direction
		elif attplayer==true:
			velocity.x=0
		if direction==1:
			$AnimatedSprite.flip_h = false
			$Animatedattack.flip_h = false
			get_node("RayCast2D").position = Vector2(9.624265, 10.193007)
			get_node("SeePlayer").position = Vector2(0, 0)
			get_node("AttPlayer").position = Vector2(0, 0)
			get_node("is_on_wall").position = Vector2(0, 0)
			get_node("Playerabove").position = Vector2(0, -16.2)
			
			get_node("AnimatedSprite").position = Vector2(0, 0)
			get_node("CollisionShape2D").position = Vector2(0, 0)
			get_node("SeePlayer").rotation_degrees = 270
			get_node("AttPlayer").rotation_degrees = 270
		else:
			$AnimatedSprite.flip_h = true
			$Animatedattack.flip_h = true
			get_node("RayCast2D").position = Vector2((9.624265*-1)+7, 10.193007)
			get_node("SeePlayer").position = Vector2(16, 0)
			get_node("AttPlayer").position = Vector2(16, 0)
			get_node("is_on_wall").position = Vector2(16, 0)
			get_node("Playerabove").position = Vector2(16, -16.2)
			
			get_node("AnimatedSprite").position = Vector2(16, 0)
			get_node("CollisionShape2D").position = Vector2(16, 0)
			get_node("SeePlayer").rotation_degrees = 90
			get_node("AttPlayer").rotation_degrees = 90
		if attplayer==false:
			$AnimatedSprite.play("walk")

		velocity.y +=GRAVITY

	velocity = move_and_slide(velocity,FLOOR)


	if $RayCast2D.is_colliding()==false:
		direction=direction*-1
		$RayCast2D.position.x*=-1


func _on_is_on_wall_body_entered(body):
	if body.name!="Player":
		direction = direction * -1
		$RayCast2D.position.x*=-1

func _on_Timer_timeout():
	queue_free()


func _on_AnimatedSprite_animation_finished():
	if react==true:
		done=true
		$AnimatedSprite.stop()
		react=false



func _on_Animatedattack_animation_finished():
	if attplayer==true:
		attplayer=false
