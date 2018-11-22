extends Area2D

const SPEED = 200
const maxspeed=175
var velocity=Vector2()
var direction=1

func _ready():
	pass


func set_arrow_direction(dir):
	direction=dir
	if dir == -1:
		$AnimatedSprite.flip_h=false
	else:
		$AnimatedSprite.flip_h=true

func _process(delta):
	velocity.x = min((velocity.x+SPEED)*delta*direction,maxspeed)
	#velocity.x=SPEED*delta*direction
	translate(velocity)
	$AnimatedSprite.play("cast")



func _on_cast_body_entered(body):
	if "Player" in body.name:
		body.hurt()
	queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
