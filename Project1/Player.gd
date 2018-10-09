extends KinematicBody2D

const speed=60
const GRAVITY=10
const JUMP_POWER=-250
const FLOOR = Vector2(0,-1)
const ARROW =preload("res://arrow.tscn")

var velocity = Vector2()

var on_ground = false

var is_attacking =false


func _physics_process(delta):
	if  Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_down") :
		if is_attacking==false:
			velocity.x= speed
			$AnimatedSprite.play("Run")
			$AnimatedSprite.flip_h = false
			if sign($Position2D.position.x)==-1:
				$Position2D.position.x *=-1
	elif Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_down") :
		if is_attacking==false:
			velocity.x=-speed
			$AnimatedSprite.play("Run")
			$AnimatedSprite.flip_h = true
			if sign($Position2D.position.x)==1:
				$Position2D.position.x *=-1
	elif Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left") :
		if is_attacking==false:
			$AnimatedSprite.play("Crouch")
			velocity.x=0
	elif Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_down"):
		if is_attacking==false:
			velocity.x= speed-25
			$AnimatedSprite.play("Crouchw")
			$AnimatedSprite.flip_h = false
			if sign($Position2D.position.x)==-1:
				$Position2D.position.x *=-1
	elif Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_down"):
		if is_attacking==false:
			velocity.x= -speed+25
			$AnimatedSprite.play("Crouchw")
			$AnimatedSprite.flip_h = true
			if sign($Position2D.position.x)==1:
				$Position2D.position.x *=-1

				
	else:
		velocity.x=0
		if on_ground==true and is_attacking==false:
			$AnimatedSprite.play("Idle")
	
		
	if  Input.is_action_pressed("ui_up") :
		if is_attacking==false:
			if on_ground== true:
				velocity.y= JUMP_POWER
				
				on_ground=false
		
	
	if Input.is_action_just_pressed("ui_focus_next") and is_attacking==false:
		is_attacking=true
		$AnimatedSprite.play("arrowfire")
		
		
		
	velocity.y += GRAVITY
	
	if is_on_floor():
		on_ground=true
	else:
		if is_attacking==false:
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