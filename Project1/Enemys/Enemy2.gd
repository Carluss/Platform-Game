extends KinematicBody2D

var velocity = Vector2()
const FLOOR=Vector2(0,-1)
const SPEED=40
const maxspeed=50
const GRAVITY= 10

const CAST =preload("res://Enemys/Enemy2cast.tscn")

var is_dead=false
var direction=-1
#---
var is_att=false
var cancast=true
var fire=0

func _ready():
	pass

func _process(delta):
	if $SeePlayer.is_colliding()==false and fire>=1 and fire<4 and cancast==true:
		fire+=1
		cancast=false
		$AnimatedSprite.play("att")
		is_att=true
	if $SeePlayer.is_colliding()==true and cancast==true:
		fire+=1
		cancast=false
		$AnimatedSprite.play("att")
		is_att=true
	if fire>=4:
		fire=0
	if is_dead==false and is_att==false:
		velocity.x=0
		$AnimatedSprite.play("idle")
		velocity.y +=GRAVITY
		
	velocity = move_and_slide(velocity,FLOOR)


func _on_AnimatedSprite_animation_finished():
	if is_att==true:
		is_att=false
		$attTimer.start()
		var cast = CAST.instance()
		if sign($Position2D.position.x)==1:
			cast.set_arrow_direction(1)
		else:
			cast.set_arrow_direction(-1)
		get_parent().add_child(cast)
		cast.position = $Position2D.global_position


func _on_attTimer_timeout():
	cancast=true
