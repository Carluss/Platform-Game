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
	var at=get_node("Player").get("health")
	match at:
		0: 
			$Player/Camera2D/heart.visible=false
			$Player/Camera2D/heart2.visible=false
			$Player/Camera2D/heart3.visible=false
			$Player/Camera2D/heart4.visible=false
			$Player/Camera2D/heart5.visible=false
		1: 
			$Player/Camera2D/heart.visible=true
			$Player/Camera2D/heart2.visible=false
			$Player/Camera2D/heart3.visible=false
			$Player/Camera2D/heart4.visible=false
			$Player/Camera2D/heart5.visible=false
			
		2:
			$Player/Camera2D/heart.visible=true
			$Player/Camera2D/heart2.visible=true
			$Player/Camera2D/heart3.visible=false
			$Player/Camera2D/heart4.visible=false
			$Player/Camera2D/heart5.visible=false
			
		3:
			$Player/Camera2D/heart.visible=true
			$Player/Camera2D/heart2.visible=true
			$Player/Camera2D/heart3.visible=true
			$Player/Camera2D/heart4.visible=false
			$Player/Camera2D/heart5.visible=false
			
		4:
			$Player/Camera2D/heart.visible=true
			$Player/Camera2D/heart2.visible=true
			$Player/Camera2D/heart3.visible=true
			$Player/Camera2D/heart4.visible=true
			$Player/Camera2D/heart5.visible=false
			
		5:
			$Player/Camera2D/heart.visible=true
			$Player/Camera2D/heart2.visible=true
			$Player/Camera2D/heart3.visible=true
			$Player/Camera2D/heart4.visible=true
			$Player/Camera2D/heart5.visible=true
			




func _on_spikes_body_entered(body):
	if "Player" in body.name:
		$spikes/CollisionShape2D.disabled=true
		body.spikes(1)
