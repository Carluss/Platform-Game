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
	$Spikes/CollisionShape2D.disabled=false
	$Spikes/CollisionShape2D2.disabled=false
	$Spikes/CollisionShape2D3.disabled=false
	$Spikes/Col.disabled=false
	$Spikes/CollisionShape2D5.disabled=false
	$Spikes/CollisionShape2D4.disabled=false
	$Spikes/fsta1.disabled=false
	$Spikes/CollisionShape2D7.disabled=false
	$Spikes/CollisionShape2D6.disabled=false


func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		get_node("Player").position=$Area2D2/dra1.global_position


func _on_Area2D2_body_entered(body):
	if "Player" in body.name:
		get_node("Player").position=$Area2D/dra.global_position


func _on_FStage_body_entered(body):
	if "Player" in body.name:
		get_node("Player").position=$FstageB/Fstageb.global_position


func _on_FstageB_body_entered(body):
	if "Player" in body.name:
		get_node("Player").position=$FStage/Fstage.global_position


func _on_Spikes_body_entered(body):
	if "Player" in body.name:
		$Spikes/CollisionShape2D.disabled=true
		$Spikes/CollisionShape2D2.disabled=true
		$Spikes/CollisionShape2D3.disabled=true
		$Spikes/Col.disabled=true
		$Spikes/CollisionShape2D5.disabled=true
		$Spikes/CollisionShape2D4.disabled=true
		$Spikes/fsta1.disabled=true
		$Spikes/CollisionShape2D7.disabled=true
		$Spikes/CollisionShape2D6.disabled=true
		body.spikes(25)
