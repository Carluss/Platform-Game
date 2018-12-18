extends "res://addons/gut/test.gd"

func before_each():
	gut.p("ran setup", 2)

func after_each():
	gut.p("ran teardown", 2)

func before_all():
	gut.p("ran run setup", 2)

func after_all():
	gut.p("ran run teardown", 2)

func test_arrow_on_arrow_body_entered():
	var myScript = load("res://arrow.gd")
	var myS = myScript.new()
	
	var enemy = load("res://Enemys/Enemy.tscn")
	add_child(enemy)
	var enemy_Instance = enemy.instance()
	add_child(enemy_Instance)
	
	myS._on_arrow_body_entered(enemy_Instance)
	add_child(myS)
	assert_true(myS.enemy, "Teste Arrow a tocar nos Enimigos")
	

func test_cast_on_cast_body_entered():	
	var myScript = load("res://Enemys/cast.gd")
	var myS = myScript.new()
	
	var player = load("res://Player.tscn")
	add_child(player)
	var player_Instance = player.instance()
	add_child(player_Instance)
	
	myS._on_cast_body_entered(player_Instance)
	add_child(myS)
	assert_true(myS.player , "Teste cast em player")
	
func test_Enemy_on_Area2D_body_entered():
	var myScript = load("res://Enemys/Enemy.gd")
	var myS = myScript.new()
	
	var player = load("res://Player.tscn")
	add_child(player)
	var player_Instance = player.instance()
	add_child(player_Instance)
	
	myS._on_Area2D_body_entered(player_Instance)
	add_child(myS)
	assert_true(myS.wall, "Teste hits player")
	
func test_Player_hurt():
	var myScript = load("res://Player.gd")
	var myS = myScript.new()
	
	myS.hurt()
	add_child(myS)
	assert_true(myS.is_hurt, "Teste hits player")
	
func test_Player_hurt1():
	var myScript = load("res://Player.gd")
	var myS = myScript.new()
	
	myS.hurt()
	add_child(myS)
	assert_ne(myS.health, myS.fullhealth)

