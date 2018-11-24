extends Area2D

const SPEED = 200
const maxspeed=175
var velocity=Vector2()

var canfly=false
var stop=false
func _ready():
	$AnimatedSprite.visible=false
	$AnimatedSprite.modulate = Color(1, 0.22, 0.37) 
	$AnimatedSprite2.visible=true
	$AnimatedSprite2.play("start")
	
func _process(delta):
	if canfly==true and stop==false:
		$AnimatedSprite.visible=true
		velocity.y = min((velocity.y+SPEED)*delta,maxspeed)
		#velocity.x=SPEED*delta*direction
		translate(velocity)
		$AnimatedSprite.play("summ")
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Summ_body_entered(body):
	stop=true
	$AnimatedSprite.visible=false
	if "Player" in body.name:
		body.hurt()
	$AnimatedSprite3.visible=true
	$AnimatedSprite3.play("fall")


func _on_AnimatedSprite3_animation_finished():
	queue_free()


func _on_AnimatedSprite2_animation_finished():
	$AnimatedSprite2.visible=false
	canfly=true
