extends KinematicBody2D

const GRAVITY= 10
const SPEED=30
const FLOOR=Vector2(0,-1)

var velocity = Vector2()

var is_hit=false
var on_ground = false

func _ready():
	pass
	

func _physics_process(delta):
	if is_hit==true and on_ground==false:
		velocity.y +=GRAVITY
	if is_on_floor()==true:
		velocity=Vector2(0,0)
		
		
	velocity = move_and_slide(velocity,FLOOR)
	
	if is_on_floor():
		on_ground=true

func _on_Area2D_area_entered(area):
	if "arrow" in area.name:
		is_hit=true
		$Area2D/CollisionShape2D2.disabled=true
		$Area2D/rope.visible=false
		get_node("Area2D/CollisionShape2D2").scale = Vector2(0, 0)
		area.queue_free()
