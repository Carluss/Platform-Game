extends Area2D

const SPEED = 200
const maxspeed=175
var velocity=Vector2()
var direction=1

var enemy=false

func _ready():
	pass


func set_arrow_direction(dir):
	direction=dir
	if dir == -1:
		$AnimatedSprite.flip_h=true
	else:
		$AnimatedSprite.flip_h=false

func _process(delta):
	velocity.x = min((velocity.x+SPEED)*delta*direction,maxspeed)
	#velocity.x=SPEED*delta*direction
	translate(velocity)
	$AnimatedSprite.play("arrow")
	
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_arrow_body_entered(body):
	if "Enemy" in body.name:
		enemy=true
		body.hurt()
	if "sprite" in body.name:
		body.hit()
		
	queue_free()
