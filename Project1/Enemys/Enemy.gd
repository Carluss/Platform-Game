extends KinematicBody2D

const GRAVITY= 10
const SPEED=21
const maxspeed=50
const FLOOR=Vector2(0,-1)

var velocity = Vector2()

var is_dead=false
var direction = 1
#hurt-----
var hitstun=25
var is_hurt=false
var knockdir=Vector2(0,0)
const TYPE="ENEMY"

#---player
var react=false
var done=false
var attplayer=false

#health
var level=1
var health=100

var wall=false

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

func hurt():
	health-=hitstun
	$AnimatedSprite.stop()
	$AnimatedSprite.set_frame(0)
	if health>0:
		is_hurt=true
		$AnimatedSprite.play("hit")
	else:
		dead()
	#velocity.x = min((velocity.x+SPEED)*-direction,maxspeed)

func attk():
	if ($SeePlayer.is_colliding()==true or $Playerabove.is_colliding()==true) and is_dead==false:
		velocity.x=0
		if $AttPlayer.is_colliding()==true or $Playerabove.is_colliding()==true:
			if is_hurt==true:
				if $Animatedattack.is_playing()==true:
					$Animatedattack.stop()
					$Animatedattack.set_frame(0)
					$AnimatedSprite.stop()
					$AnimatedSprite.set_frame(0)
					$AnimatedSprite.visible=true
					$Animatedattack.visible=false
					$AnimatedSprite.play("hit")
			else:
				$AnimatedSprite.visible=false
				$Animatedattack.visible=true
				react=false
				if $Animatedattack.get_frame()==7:
					if direction==1:
						$Area2D/ColliD.disabled=false
					else:
						$Area2D/ColliE.disabled=false
				attplayer=true
				$Animatedattack.play("attack")
		elif done==false:
			if $AnimatedSprite.is_playing()==true and react==true and is_hurt==true:
				$AnimatedSprite.play("hit")
				react=false
			else:
				$AnimatedSprite.play("react")
			react=true
			

func _physics_process(delta):

	attk()
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
		if done==false and attplayer==false and is_hurt==false:
			velocity.x=SPEED*direction
		elif done==true and attplayer==false and is_hurt==false:
			velocity.x=(SPEED+30)*direction
		elif attplayer==true or is_hurt==true:
			velocity.x=0
		fliph()
		if attplayer==false and is_hurt==false:
			$AnimatedSprite.play("walk")

		velocity.y +=GRAVITY

	velocity = move_and_slide(velocity,FLOOR)


	if $RayCast2D.is_colliding()==false:
		direction=direction*-1
		$RayCast2D.position.x*=-1


func _on_is_on_wall_body_entered(body):
	if body.name!="Player" and body.name!="Enemy2" and body.name!="Enemy"and body.name!="Enemy3":
		direction = direction * -1
		$RayCast2D.position.x*=-1

func _on_Timer_timeout():
	queue_free()


func _on_AnimatedSprite_animation_finished():
	if is_hurt==true:
		is_hurt=false
	if react==true:
		done=true
		$AnimatedSprite.stop()
		react=false

func fliph():
	if direction==1:
		$Area2D/ColliE.visible=false
		$Area2D/ColliD.visible=true
		
		$AnimatedSprite.flip_h = false
		$Animatedattack.flip_h = false

			
		get_node("Animatedattack").position = Vector2(9, -3)
		
		get_node("SeePlayer").rotation_degrees = 270
		get_node("AttPlayer").rotation_degrees = 270
	else:
		$Area2D/ColliE.visible=true
		$Area2D/ColliD.visible=false
		
		$AnimatedSprite.flip_h = true
		$Animatedattack.flip_h = true

			
		get_node("Animatedattack").position = Vector2(-10, -3)
		get_node("SeePlayer").rotation_degrees = 90
		get_node("AttPlayer").rotation_degrees = 90
		
func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		wall=true
		body.hurt()

func _on_Animatedattack_animation_finished():
	if attplayer==true:
		$Area2D/ColliE.disabled=true
		$Area2D/ColliD.disabled=true
		attplayer=false

