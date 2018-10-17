extends KinematicBody2D

const TYPE="PLAYER"

const speed=30
const GRAVITY=10
const JUMP_POWER=-250
const FLOOR = Vector2(0,-1)
const ARROW =preload("res://arrow.tscn")
const MaxSpeed = 100

var velocity = Vector2()

var on_ground = false

var is_attacking =false

# For jump
var jumped=false
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
#------		

func _physics_process(delta):
	#atck()
	if  Input.is_action_pressed("ui_right"):
		if is_attacking==false and corner==false and is_climbw==false:
			velocity.x = min(velocity.x+speed,MaxSpeed)
			get_node("CollisionShape2D").scale = Vector2(1,1)
			get_node("CollisionShape2D").position = Vector2(0,3)
			if $RayCast2D.is_colliding()==true or Input.is_action_pressed("ui_down"):
				velocity.x= speed
				get_node("CollisionShape2D").scale = Vector2(1,0.6)
				get_node("CollisionShape2D").position = Vector2(0, 8.9)
				$AnimatedSprite.play("Crouchw")
				$AnimatedSprite.flip_h = false
				get_node("climbw").rotation_degrees = 270
				if sign($Position2D.position.x)==-1:
					$Position2D.position.x *=-1
			elif is_inladder==false:
				$AnimatedSprite.play("Run")
				$AnimatedSprite.flip_h = false
				get_node("climbw").rotation_degrees = 270
				if sign($Position2D.position.x)==-1:
					$Position2D.position.x *=-1
			else:
				$AnimatedSprite.flip_h = false
				get_node("climbw").rotation_degrees = 270
				if sign($Position2D.position.x)==-1:
					$Position2D.position.x *=-1
			#elif is_inladder==true:
				#$AnimatedSprite.play("fall")
	elif Input.is_action_pressed("ui_left") :
		if is_attacking==false and corner==false and is_climbw==false:
			velocity.x = max(velocity.x-speed,-MaxSpeed)
			get_node("CollisionShape2D").scale = Vector2(1,1)
			get_node("CollisionShape2D").position = Vector2(0,3)
			if $RayCast2D.is_colliding()==true or Input.is_action_pressed("ui_down"):
				velocity.x= -speed
				$AnimatedSprite.play("Crouchw")
				get_node("CollisionShape2D").scale = Vector2(1,0.6)
				get_node("CollisionShape2D").position = Vector2(0, 8.9)
				$AnimatedSprite.flip_h = true
				get_node("climbw").rotation_degrees = 90
				if sign($Position2D.position.x)==1:
					$Position2D.position.x *=-1	
			elif is_inladder==false:
				$AnimatedSprite.play("Run")
				$AnimatedSprite.flip_h = true
				get_node("climbw").rotation_degrees = 90
				if sign($Position2D.position.x)==1:
					$Position2D.position.x *=-1
			else:
				$AnimatedSprite.flip_h = true
				get_node("climbw").rotation_degrees = 90
				if sign($Position2D.position.x)==1:
					$Position2D.position.x *=-1
	elif Input.is_action_pressed("ui_down") :
		if is_attacking==false and is_inladder==false and corner==false and is_climbw==false:
			$AnimatedSprite.play("Crouch")
			get_node("CollisionShape2D").scale = Vector2(1,0.6)
			get_node("CollisionShape2D").position = Vector2(0, 8.9)
			velocity.x=0
	else:
		get_node("CollisionShape2D").scale = Vector2(1,1)
		get_node("CollisionShape2D").position = Vector2(0,3)
		velocity.x=0	
		if on_ground==true and is_attacking==false and is_inladder==false:
			if $RayCast2D.is_colliding()==true:
				get_node("CollisionShape2D").scale = Vector2(1,0.6)
				get_node("CollisionShape2D").position = Vector2(0, 8.9)
				$AnimatedSprite.play("Crouch")
			elif Input.is_action_just_pressed("ui_attack"):
				is_att=true
				velocity.x=0
				attacking()
			elif $RayCast2D.is_colliding()==false and is_att!=true:
				$AnimatedSprite.play("Idle")
		elif corner==true:
			$AnimatedSprite.play("climbcorner")
		elif is_inladder==true and not Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
			velocity.y=0
			$AnimatedSprite.stop()
		
	if  Input.is_action_pressed("ui_up") and $RayCast2D.is_colliding()==false or is_ladder==true :
		if is_attacking==false:
			if on_ground==true and is_ladder==false:
				velocity.y= JUMP_POWER
				jumped=true	
				on_ground=false
			elif is_ladder==true and Input.is_action_pressed("ui_up"):
				is_inladder=true
				$AnimatedSprite.play("climbl")
				velocity.y=-speed-10
			elif is_ladder==true and Input.is_action_pressed("ui_down"):
				if is_on_floor()==false:
					is_inladder=true
					$AnimatedSprite.play("climbl")
					velocity.y=speed+10
				elif is_on_floor()==true:
					$AnimatedSprite.play("Idle")
					is_inladder=false
	if is_on_floor()==false and is_ladder==true:
			$AnimatedSprite.play("climbl")
			is_inladder=true
	
	if Input.is_action_just_pressed("ui_focus_next") and is_attacking==false and on_ground==true:
		if $RayCast2D.is_colliding()==false and is_climbw==false:
			velocity.x=0
			is_attacking=true
			get_node("CollisionShape2D").scale = Vector2(1,1)
			get_node("CollisionShape2D").position = Vector2(0,3)
			$AnimatedSprite.play("arrowfire")
			
	if Input.is_action_just_pressed("ui_focus_next")  and is_attacking==false and on_ground==false:
		if $RayCast2D.is_colliding()==false and is_climbw==false:
			is_attacking=true
			get_node("CollisionShape2D").scale = Vector2(1,1)
			get_node("CollisionShape2D").position = Vector2(0,3)
			$AnimatedSprite.play("arrowfirejump")
			
	if is_inladder==false and corner==false:
		if is_climbw==true and is_on_floor()==false and corner==false and velocity.y>0:
			$AnimatedSprite.play("climbwdown")
		velocity.y += GRAVITY
	
	if is_on_floor():
		on_ground=true
		corner=false
		is_climbw=false
		is_inladder=false
	else:
		on_ground=false
		if is_attacking==false and $RayCast2D.is_colliding()==false and is_ladder==false :
			on_ground=false
			if velocity.y<0 and is_ladder==false and jumped==true:
				$AnimatedSprite.play("Jump")
				jumped=false
			#elif is_ladder==false:
				#$AnimatedSprite.play("fall")
				
			
	if $ladder.is_colliding()==true and Input.is_action_pressed("ui_down"):
		set_collision_layer_bit(1,false )
		if is_inladder==true:
			$ladder.enabled=false
	elif $ladder.is_colliding()==true :	
		set_collision_layer_bit(1,true)
	else:
		set_collision_layer_bit(1,false )
		if is_inladder==true:
			$ladder.enabled=false
	
	
	if ($climbw.is_colliding()==true and Input.is_action_pressed("ui_up"))or($climbw.is_colliding()==true and Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_right")) or($climbw.is_colliding()==true and Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_left")):
		is_climbw=true
		velocity.y=-speed-5	
		$AnimatedSprite.play("climbl")
	if is_climbw==true:
		if $climbw.is_colliding()==false:
			corner=true
			jumpcorner()
	velocity = move_and_slide(velocity, FLOOR)

func jumpcorner():
	velocity.y=0
	if (corner==true and Input.is_action_pressed("ui_jump")) or (corner==true and Input.is_action_pressed("ui_jump") and Input.is_action_pressed("ui_right") )or (corner==true and Input.is_action_pressed("ui_jump") and Input.is_action_pressed("ui_left")):
		corner=false
		is_climbw=false
		$AnimatedSprite.play("climbcornerj")
		velocity.y= JUMP_POWER
		on_ground=false
	
func attacking():
	if is_attf==true and rdyatt==true:
		match at:
			1:
				$AnimatedSprite.play("attack1")
				is_attf=false
			2:
				$AnimatedSprite.play("attack2")
				is_attf=false
			3:
				$AnimatedSprite.play("attack3")
				is_attf=false
		rdyatt=false
		$attdelay.start()
		at+=1
		if at>=4:
			at=1

func _on_AnimatedSprite_animation_finished():
	if is_att==true:
		is_attf=true
		is_att=false
		$AnimatedSprite.stop()
	if is_attacking==true:
		var arrow = ARROW.instance()
		if sign($Position2D.position.x)==1:
			arrow.set_arrow_direction(1)
		else:
			arrow.set_arrow_direction(-1)
		get_parent().add_child(arrow)
		arrow.position = $Position2D.global_position
		is_attacking=false



func _on_att_delay_timeout():
	rdyatt=true


func _on_ladders_body_entered(body):
	if body.get_collision_mask_bit(1)==true:
		is_ladder=true
		print("true")



func _on_ladders_body_exited(body):
	if body.get_collision_mask_bit(1)==true:
		is_ladder=false
		$ladder.enabled=true
		is_inladder=false
		print("false")
