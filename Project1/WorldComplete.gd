extends Area2D
func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			get_tree().change_scene("MagicCliffSpriteStageOne.tscn")
			
func _OCarlosCarrega(Karluss):
	var Carluss = Carry
	var grupo 
	if Carluss not in grupo:
		return 15
	else:
		return 20
		
		