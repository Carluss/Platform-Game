extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	$AnimatedSprite.play("health")

var heal = 1
func _on_Healthpack_body_entered(body):
	if "Player" in body.name:
		if body.get("health")!=body.get("fullhealth"):	
			body.heal(heal)
			print("health gain")
			queue_free()
		else:
			print("health is full")
		
