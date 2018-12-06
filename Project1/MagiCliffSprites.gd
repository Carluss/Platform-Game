extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if get_node("Player").get("teleport")== true:
		get_node("Player").position=$Dead.global_position
	$spikes/CollisionShape2D.disabled=false




func _on_spikes_body_entered(body):
	if "Player" in body.name:
		$spikes/CollisionShape2D.disabled=true
		body.spikes(25)
