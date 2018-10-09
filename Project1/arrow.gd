extends Area2D

const SPEED = 100

var velocity=Vector2()
var direction=1

func _ready():
	pass


func set_arrow_direction(dir):
	direction=dir
	if dir == -1:
		$AnimatedSprite.flip_h=true
	else:
		$AnimatedSprite.flip_h=false

func _physics_process(delta):
	velocity.x=SPEED*delta*direction
	translate(velocity)
	$AnimatedSprite.play("arrow")
	
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_arrow_body_entered(body):
	queue_free()
