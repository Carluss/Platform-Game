extends KinematicBody2D

const TYPE="PLAYER"

const speed=30
const GRAVITY=10
const JUMP_POWER=-280
const JUMP_ATTPWR=-170
const FLOOR = Vector2(0,-1)
const ARROW =preload("res://arrow.tscn")
const MaxSpeed = 100
const MaxSpeedatt =45

var velocity = Vector2()

var on_ground = false

var is_attacking =false

# Arrow
var firearrow=true
#---
# novas var de attk
var is_att=false
var is_attf=true
var rdyatt=true
var at=1
#-------------
# subir escadas
var is_ladder=false
var is_inladder=false
#--------------
#Var climbw
var climbdir = 1
var is_climbw=false
var corner=false
#Sword Draw f----
var swordanimation=false
var anifinished=false
#_---
#Modes
var attmode=false
#---
#-health
var fullhealth=100
var health=100
var dmg=25
var is_hurt=false
var is_dead=false
var teleport=false
#------
func limitation(mode,state):
	if state=="arrow":
		if is_attacking==false and is_on_floor()==true and is_climbw==false:
			return true
	if state=="arrowjump":
		if is_attacking==false and is_on_floor()==false and is_climbw==false:
			return true
	if  state=="jump":
		if $Crouch.is_colliding()==false and is_attacking==false and is_climbw==false:
			return true
	if mode==false and state=="crouch":
		if is_inladder==false and is_attacking==false and is_on_floor()==true and is_climbw==false:
			return true
		else:
			return false
	if mode==false and state=="climbwalls":
		return true
	if mode==false and state=="ladder":
		if is_attacking==false:
			return true
	if  state=="idle":
		if is_attacking==false and is_climbw==false:
			return true
		else:
			return false
	if mode==false and is_climbw==false and (state=="right" or state=="left") :	
		if is_attacking==false or is_on_floor()==false :
			return true
		else:
			return false
	return	false
			
func fliph(position):
	if position=="right":
		$AnimatedSprite.flip_h = false
		$AttCollision2D/AttCollisionE.visible=false
		$AttCollision2D/AttCollisionD.visible=true
		get_node("climbw").rotation_degrees = 270
		if sign($Position2D.position.x)==-1:
			$Position2D.position.x *=-1
	elif position=="left":
		$AnimatedSprite.flip_h = true
		$AttCollision2D/AttCollisionE.visible=true
		$AttCollision2D/AttCollisionD.visible=false
		get_node("climbw").rotation_degrees = 90
		if sign($Position2D.position.x)==1:
			$Position2D.position.x *=-1	
	if $AnimatedSprite.flip_h==false:
		return true
	else:
		return false
			
func incrouch(cmode):
	if cmode==true:
		get_node("CollisionShape2D").scale = Vector2(1,0.6)
		get_node("CollisionShape2D").position = Vector2(0, 8.9)
	elif cmode==false:
		get_node("CollisionShape2D").scale = Vector2(1,1)
		get_node("CollisionShape2D").position = Vector2(0,3)
	#if $RayCast2D.is_colliding()==true or Input.is_action_pressed("ui_down"):
		#velocity.x= speed
		#$AnimatedSprite.play("Crouchw")
		
		
#Move functions------------------
func right(mode):
	if is_dead==false and mode==false and limitation(mode,"right")==true and not Input.is_action_pressed("ui_down") and $Crouch.is_colliding()==false:
		limitation(mode,"right")
		if is_attacking==false:
			fliph("right")
		incrouch(false)
		velocity.x = min(velocity.x+speed,MaxSpeed)
		if !velocity.y<0 and is_attacking==false:
			if is_hurt==true:
				$AnimatedSprite.play("hurt")
			else:
				$AnimatedSprite.play("Run")
	elif is_dead==false and mode==false and limitation(mode,"right")==true and Input.is_action_pressed("ui_down") or $Crouch.is_colliding()==true:
		if limitation(attmode,"crouch")==true:
			velocity.x= speed
			if is_attacking==false:
				fliph("right")
			incrouch(true)
			$AnimatedSprite.play("Crouchw")
		else:
			velocity.x = min(velocity.x+speed,MaxSpeed)
			if is_attacking==false:
				fliph("right")
	if is_dead==false and mode==true and not Input.is_action_pressed("ui_down") and $Crouch.is_colliding()==false:
		if is_attacking==false:
			fliph("right")
		incrouch(false)
		if is_att==false:
			velocity.x = min(velocity.x+speed,MaxSpeed)
		else:
			velocity.x = min(velocity.x+speed,MaxSpeedatt)
		if Input.is_action_just_pressed("ui_attack1") and is_on_floor()==true:
			velocity.x = min(velocity.x+speed,MaxSpeedatt)
			is_att=true
			attacking()
		if !velocity.y<0 and is_attacking==false and is_att==false:
			$AnimatedSprite.play("RunSword")
	elif is_dead==false and mode==true and Input.is_action_pressed("ui_down"):
		if is_attacking==false:
			fliph("right")
		incrouch(false)
		velocity.x = min(velocity.x+speed,MaxSpeed)
		if !velocity.y<0 and is_attacking==false:
			$AnimatedSprite.play("RunSword")
	return true
	
func left(mode):
	if is_dead==false and mode==false and limitation(mode,"left")==true and not Input.is_action_pressed("ui_down") and $Crouch.is_colliding()==false:
		limitation(mode,"left")
		if is_attacking==false:
			fliph("left")
		incrouch(false)
		velocity.x = max(velocity.x-speed,-MaxSpeed)
		if !velocity.y<0 and is_attacking==false:
			if is_hurt==true:
				$AnimatedSprite.play("hurt")
			else:
				$AnimatedSprite.play("Run")
	elif is_dead==false and mode==false and limitation(mode,"left")==true and Input.is_action_pressed("ui_down") or $Crouch.is_colliding()==true:
		if limitation(attmode,"crouch")==true:
			velocity.x= -speed
			if is_attacking==false:
				fliph("left")
			incrouch(true)
			$AnimatedSprite.play("Crouchw")
		else:
			velocity.x = max(velocity.x-speed,-MaxSpeed)
			if is_attacking==false:
				fliph("left")
	if is_dead==false and mode==true and not Input.is_action_pressed("ui_down") and $Crouch.is_colliding()==false:
		if is_attacking==false:
			fliph("left")
		incrouch(false)
		if is_att==false:
			velocity.x = max(velocity.x-speed,-MaxSpeed)
		else:
			velocity.x = max(velocity.x-speed,-MaxSpeedatt)
		if Input.is_action_just_pressed("ui_attack1") and is_on_floor()==true:
			is_att=true
			attacking()
		if !velocity.y<0 and is_attacking==false and is_att==false:
			$AnimatedSprite.play("RunSword")
	elif is_dead==false and mode==true and Input.is_action_pressed("ui_down"):
		if is_attacking==false:
			fliph("left")
		incrouch(false)
		velocity.x = max(velocity.x-speed,-MaxSpeed)
		if !velocity.y<0 and is_attacking==false:
			$AnimatedSprite.play("RunSword")	
	return true

func crouch(mode):
	if is_dead==false and mode==false and limitation(mode,"crouch")==true:
		limitation(mode,"crouch")
		if is_hurt==true:
			$AnimatedSprite.play("hurt")
		else:
			$AnimatedSprite.play("Crouch")
		incrouch(true)
		velocity.x=0
	return true
	
func idle(mode):
	incrouch(false)
	velocity.x=0
	if is_dead==true:
		$AnimatedSprite.play("dead")
		if teleport==true:
			print("teleport")
			health=fullhealth*0.75
			is_dead=false
			teleport=false
	if is_dead==false and mode==false and limitation(mode,"idle")==true:
		anifinished=false
		if $Crouch.is_colliding()==true:
			limitation(mode,"crouch")
			incrouch(true)
			if is_hurt==true:
				$AnimatedSprite.play("hurt")
			else:
				$AnimatedSprite.play("Crouch")
		elif $Crouch.is_colliding()==false and is_inladder==false and is_on_floor()==true:
			limitation(mode,"idle")
			if swordanimation==false:
				if is_hurt==true:
					$AnimatedSprite.play("hurt")
				else:
					$AnimatedSprite.play("Idle")
			else:
				if is_hurt==true:
					$AnimatedSprite.play("hurt")
				else:
					$AnimatedSprite.play("IdleSwordS")
					$DrawSheet.start()
			incrouch(false)
	elif mode==true and limitation(mode,"idle")==true:
		if Input.is_action_just_pressed("ui_attack1") and is_on_floor()==true:
			is_att=true
			attacking()
		if swordanimation==false and is_att==false:
			if is_hurt==true:
				$AnimatedSprite.play("hurt")
			else:
				$AnimatedSprite.play("Idleatt")
		elif is_att==false:
			if is_hurt==true:
				$AnimatedSprite.play("hurt")
			else:
				$AnimatedSprite.play("IdleSwordD")
				$DrawSheet.start()
		incrouch(false)
		
		
func jump(mode):
	if limitation(mode,"jump")==true:
		if is_on_floor()==true:
			limitation(mode,"jump")
			velocity.y= JUMP_POWER

			
func climbladders(mode):
	if is_dead==false and limitation(mode,"ladder")==true:
		if is_inladder==true and is_ladder==true:
			if velocity.y==0:
				$AnimatedSprite.play("climbl")
				$AnimatedSprite.stop()
			else:
				$AnimatedSprite.play("climbl")
			velocity.y=0
			$ladder.enabled=false
		if mode==false and is_on_floor()==false and is_ladder==true:
			$AnimatedSprite.play("climbl")
			is_inladder=true
		if mode==false and Input.is_action_pressed("ui_up") and is_ladder==true:
			is_inladder=true
			$AnimatedSprite.play("climbl")
			velocity.y=-speed-10
		elif (is_ladder==true or $ladder.is_colliding()==true) and Input.is_action_pressed("ui_down"):
			if is_on_floor()==true and $ladder.is_colliding()==false:
				set_collision_layer_bit(1,false)
				velocity.y=speed+10
			else:
				set_collision_layer_bit(1,false)
				is_inladder=true
				$AnimatedSprite.play("climbl")
				velocity.y=speed+10

func Arrow(mode):
	if firearrow==true and $Crouch.is_colliding()==false and is_climbw==false and is_inladder==false:
		firearrow=false
		if limitation(mode,"arrow")==true :
			velocity.x=0
			is_attacking=true
			$AnimatedSprite.play("arrowfire")
		elif limitation(mode,"arrowjump")==true:
			is_attacking=true
			if is_on_floor()==true:
				velocity.x=0
			$AnimatedSprite.play("arrowfirejump")
func _on_Arrowdelay_timeout():
	firearrow=true

func attacking():
	if is_attf==true and rdyatt==true:
		match at:
			1:
				$AnimatedSprite.play("attack1")
				if fliph("nada")==true:
					$AttCollision2D/AttCollisionD.disabled=false
				else:
					$AttCollision2D/AttCollisionE.disabled=false
				is_attf=false
			2:
				$AnimatedSprite.play("attack2")
				if fliph("nada")==true:
					$AttCollision2D/AttCollisionD.disabled=false
				else:
					$AttCollision2D/AttCollisionE.disabled=false
				is_attf=false
			3:
				$AnimatedSprite.play("attack3")
				if fliph("nada")==true:
					$AttCollision2D/AttCollisionD.disabled=false
				else:
					$AttCollision2D/AttCollisionE.disabled=false
				is_attf=false
		rdyatt=false
		$attdelay.start()
		at+=1
		if at>=4:
			at=1


func _on_att_delay_timeout():
	rdyatt=true
	
func _on_AttCollision2D_body_entered(body):
	if "Enemy" in body.name or "Enemy2" in body.name:
		
		body.hurt()



func hurt():
	$AnimatedSprite.modulate = Color(1, 0.22, 0.37) 
	health-=dmg
	is_hurt=true
	if health>0:
		print(health)
	else:
		dead()

func dead():
	is_dead=true
	velocity = Vector2(0,0)
	print("dead")
	
	
	
#--------------------------------------------	
func _physics_process(delta):
	if attmode==false and is_inladder==false and is_climbw==false and is_on_floor()==true:
		if Input.is_action_just_pressed("ui_attack"):
			swordanimation=true
			attmode=true
			print(attmode)
	else:
		if Input.is_action_just_pressed("ui_attack"):
			swordanimation=true
			attmode=false
			print(attmode)
	
		
	if  Input.is_action_pressed("ui_right"):
		right(attmode)
	elif Input.is_action_pressed("ui_left") :
		left(attmode)
	elif Input.is_action_pressed("ui_down") and limitation(attmode,"crouch")==true :
		crouch(attmode)
	else:
		idle(attmode)
	
	if  Input.is_action_just_pressed("ui_jump"):	
		jump(attmode)
	#climbladders------
	if $ladder.is_colliding()==true:
		if attmode==true and is_on_floor()==false:
			set_collision_layer_bit(1,false)
		else:
			set_collision_layer_bit(1,true)
	elif $ladder.is_colliding()==false and get_collision_layer_bit(1)==true and attmode==false:
		set_collision_layer_bit(1,false)	
	if ($ladder.is_colliding()==true or is_ladder==true or is_inladder==true) and attmode==false:	
		climbladders(false)
	#------
	if Input.is_action_just_pressed("ui_focus_next"):
		Arrow(attmode)
		
	climbwalls(attmode)
		
	if is_inladder==false and corner==false:
		if (is_climbw==true or $climbw.is_colliding()==true) and attmode==false and is_on_floor()==false and corner==false and velocity.y>0:
			is_climbw=true
			$AnimatedSprite.play("climbwdown")
		velocity.y += GRAVITY
		
	if is_on_floor()==true:
		on_ground=true
		corner=false
		is_climbw=false
		is_inladder=false
	else:
		on_ground=false
		if is_attacking==false and $Crouch.is_colliding()==false and is_ladder==false :
			on_ground=false
			if velocity.y<0 and is_ladder==false and corner==false and is_climbw==false:
				$AnimatedSprite.play("Jump")
			elif $Fallray.is_colliding()==false and corner==false and $climbw.is_colliding()==false:
				$AnimatedSprite.play("fall")	
				
	velocity = move_and_slide(velocity, FLOOR)
	
func climbwalls(mode):
	if mode==false and (($climbw.is_colliding()==true and Input.is_action_pressed("ui_up"))or($climbw.is_colliding()==true and Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_right")) or($climbw.is_colliding()==true and Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_left"))):
		is_climbw=true
		velocity.y=-speed-5
		$AnimatedSprite.play("climbl")
	if is_climbw==true and mode==false:
		if Input.is_action_just_pressed("ui_jump") and ((Input.is_action_pressed("ui_right") and fliph("nada")==false) or (Input.is_action_pressed("ui_left") and fliph("nada")==true) ):
			velocity.y= JUMP_POWER+50
			is_climbw=false
		if Input.is_action_pressed("ui_right") and Input.is_action_just_pressed("ui_jump") and fliph("nada")==false: 
			velocity.y=JUMP_POWER+50
			is_climbw=false
		if Input.is_action_pressed("ui_left") and Input.is_action_just_pressed("ui_jump") and fliph("nada")==true:
			velocity.y=JUMP_POWER+50
			is_climbw=false
		if $climbw.is_colliding()==false and not velocity.y>0:
			$AnimatedSprite.play("climbcorner")
			corner=true
			velocity.y=0
			if (corner==true and Input.is_action_pressed("ui_jump")) or (corner==true and Input.is_action_pressed("ui_jump") and Input.is_action_pressed("ui_right") )or (corner==true and Input.is_action_pressed("ui_jump") and Input.is_action_pressed("ui_left")):
				corner=false
				is_climbw=false
				velocity.y= JUMP_POWER
				on_ground=false




func _on_AnimatedSprite_animation_finished():
	if is_dead==true:
		$deadtimer.start()
	if is_hurt==true:
		$AnimatedSprite.modulate = Color(1, 1, 1) 
		is_hurt=false
	if swordanimation==true:
		anifinished=true
		swordanimation=false
	if is_att==true:
		is_attf=true
		is_att=false
		$AttCollision2D/AttCollisionD.disabled=true
		$AttCollision2D/AttCollisionE.disabled=true
		$AnimatedSprite.stop()
	if is_attacking==true:
		$Arrowdelay.start()
		is_attacking=false
		var arrow = ARROW.instance()
		if sign($Position2D.position.x)==1:
			arrow.set_arrow_direction(1)
		else:
			arrow.set_arrow_direction(-1)
		get_parent().add_child(arrow)
		arrow.position = $Position2D.global_position


func _on_ladders_body_entered(body):
	if body.get_collision_mask_bit(1)==true:
		is_ladder=true

func _on_ladders_body_exited(body):
	if body.get_collision_mask_bit(1)==true:
		set_collision_layer_bit(1,false)
		is_ladder=false
		$ladder.enabled=true
		is_inladder=false



func _on_DrawSheet_timeout():
	swordanimation=false




func _on_deadtimer_timeout():
	teleport=true
