extends KinematicBody2D

const speed=30
const GRAVITY=10
const JUMP_POWER=-250
const FLOOR = Vector2(0,-1)
const ARROW =preload("res://arrow.tscn")
const MaxSpeed = 100

var velocity = Vector2()

var on_ground = false

var is_attacking =false

var is_crouch=false


func _physics_process(delta):
	if  Input.is_action_pressed("ui_right") :
		if is_attacking==false or is_on_floor()==false:
			velocity.x = min(velocity.x+speed,MaxSpeed)
			$CollisionShape2D.disabled=false
			if is_attacking==false:
				if $RayCast2D.is_colliding()==true or Input.is_action_pressed("ui_down"):
					is_crouch==true
					velocity.x= speed-25
					$CollisionShape2D.disabled=true
					$AnimatedSprite.play("Crouch")
					$AnimatedSprite.flip_h = false
				else:
					$AnimatedSprite.play("Run")
					$AnimatedSprite.flip_h = false
					if sign($Position2D.position.x)==-1:
						$Position2D.position.x *=-1
	elif Input.is_action_pressed("ui_left") :
		if is_attacking==false or is_on_floor()==false :
			velocity.x = max(velocity.x-speed,-MaxSpeed)
			$CollisionShape2D.disabled=false
			if is_attacking==false:
				if $RayCast2D.is_colliding()==true or Input.is_action_pressed("ui_down"):
					is_crouch==true
					velocity.x= -speed+25
					$CollisionShape2D.disabled=true
					$AnimatedSprite.play("Crouch")
					$AnimatedSprite.flip_h = true
					
				else:
					$AnimatedSprite.play("Run")
					$AnimatedSprite.flip_h = true
					if sign($Position2D.position.x)==1:
						$Position2D.position.x *=-1
	elif Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left") :
		if is_attacking==false:
			$AnimatedSprite.play("Crouch")
			$CollisionShape2D.disabled=true
			velocity.x=0
	elif (Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_right")) :
		if is_attacking==false:
			velocity.x= speed-25
			$AnimatedSprite.play("Crouchw")
			$AnimatedSprite.flip_h = false
			if is_crouch==true:
				$CollisionShape2D.disabled=true
			if sign($Position2D.position.x)==-1:
				$Position2D.position.x *=-1
	elif Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_left"):
		if is_attacking==false:
			velocity.x= -speed+25
			$AnimatedSprite.play("Crouchw")
			$AnimatedSprite.flip_h = true
			if is_crouch==true:
				$CollisionShape2D.disabled=true
			if sign($Position2D.position.x)==1:
				$Position2D.position.x *=-1

				
	else:
		$CollisionShape2D.disabled=false
		velocity.x=0
		
		if on_ground==true and is_attacking==false:
			if $RayCast2D.is_colliding()==true:
				is_crouch==true
				$CollisionShape2D.disabled=true
				$AnimatedSprite.play("Crouch")
			elif $RayCast2D.is_colliding()==false:
				is_crouch=false
				$AnimatedSprite.play("Idle")

	
		
	if  Input.is_action_pressed("ui_up") and $RayCast2D.is_colliding()==false :
		if is_attacking==false:
			if on_ground== true:
				$CollisionShape2D.disabled=false
				velocity.y= JUMP_POWER
				
				on_ground=false
		
	
	if Input.is_action_just_pressed("ui_focus_next") and is_attacking==false and on_ground==true:
		velocity.x=0
		is_attacking=true
		$CollisionShape2D.disabled=false
		$AnimatedSprite.play("arrowfire")
		
	if Input.is_action_just_pressed("ui_focus_next")  and is_attacking==false and on_ground==false:
		is_attacking=true
		$CollisionShape2D.disabled=false
		$AnimatedSprite.play("arrowfirejump")	
		
		
	velocity.y += GRAVITY
	
	if is_on_floor():
		on_ground=true
	else:
		if is_attacking==false and $RayCast2D.is_colliding()==false:
			on_ground=false
			if velocity.y<0:
				$AnimatedSprite.play("Jump")
			else:
				$AnimatedSprite.play("fall")
		
	velocity = move_and_slide(velocity, FLOOR)

func _on_AnimatedSprite_animation_finished():
	if is_attacking==true:
		var arrow = ARROW.instance()
		if sign($Position2D.position.x)==1:
			arrow.set_arrow_direction(1)
		else:
			arrow.set_arrow_direction(-1)
		get_parent().add_child(arrow)
		arrow.position = $Position2D.global_position
		is_attacking=false

