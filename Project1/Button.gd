extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Area2D2_area_entered(area):
	if "arrow" in area.name:
		area.queue_free()
		$Area2D2/rope.visible=false
		$Area2D2/CollisionShape2D.disabled=true
		$Area2D2/CollisionShape2D.scale=Vector2(0,0)

var bt=false

func _on_Area2D_area_entered(area):
	if "arrow" in area.name:
		bt=true
		$Area2D/AnimatedSprite.play("Button")
