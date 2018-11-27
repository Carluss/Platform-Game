extends KinematicBody2D

var velocity = Vector2()
const FLOOR=Vector2(0,-1)
const SPEED=40
const maxspeed=50
const GRAVITY= 10

const CAST =preload("res://Enemys/Enemy2cast.tscn")
const SUMM = preload("res://Enemys/Enemy2Summ.tscn")

var is_dead=false
var direction=-1
#---
var is_att=false
var is_summ=false
var cancast=true
var cansumm=true

#health
var level=1
var health=100
#hurt-----
var hitstun=25
var is_hurt=false
var knockdir=Vector2(0,0)
const TYPE="ENEMY"

func _ready():
	pass

func _process(delta):
	if is_dead==false and is_hurt==false and is_att==false:
		summon()

	if ($SeePlayer.is_colliding()==true and $Summon.is_colliding()==false) and is_dead==false and cancast==true and is_hurt==false:
		cancast=false
		$AnimatedSprite.play("att")
		is_att=true
	
	if is_dead==false and is_att==false and is_hurt==false and is_summ==false:
		velocity.x=0
		$AnimatedSprite.play("idle")
		velocity.y +=GRAVITY
		
	velocity = move_and_slide(velocity,FLOOR)
func summon():
	if $Summon.is_colliding()==true and cansumm==true:
		is_summ=true
		cansumm=false
		$AnimatedSprite.play("cast")
		
func hurt():
	is_summ=false
	health-=hitstun
	$AnimatedSprite.stop()
	$AnimatedSprite.set_frame(0)
	if health>0:
		is_hurt=true
		$AnimatedSprite.play("hurt")
	else:
		dead()
func dead():
	is_dead=true
	velocity = Vector2(0,0)
	$AnimatedSprite.play("die")
	$CollisionShape2D.disabled = true
	get_node("CollisionShape2D").scale = Vector2(0, 0)
	$Timer.start()
	
func _on_AnimatedSprite_animation_finished():
	if is_summ==true:
		is_summ=false
		$SumTimer.start()
		var summm = SUMM.instance()
		var summm1 = SUMM.instance()
		var summm2 = SUMM.instance()
		get_parent().add_child(summm)
		get_parent().add_child(summm1)
		get_parent().add_child(summm2)
		summm.position = $summ1.global_position
		summm1.position = $summ2.global_position
		summm2.position = $summ3.global_position
		
	if is_hurt==true:
		is_hurt=false
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


func _on_Timer_timeout():
	queue_free()


func _on_SumTimer_timeout():
	cansumm=true
