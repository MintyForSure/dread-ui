extends Control

@onready var hpBar=$status/healthBar
@onready var hpText=$status/healthText
@onready var tensBar=$status/tensionBar
@onready var tensText=$status/tensionText

var battleJSON = JSON.parse_string(FileAccess.get_file_as_string("res://assets/scripts/battleOpener.json"))
var commmonJSON = JSON.parse_string(FileAccess.get_file_as_string("res://assets/scripts/common.json"))
#var enemyTextWindow = preload("res://assets/scenes/system/window.tscn")

const mhealth=43
var health=43
var tension=0
var uiState="startWindow"
var selectedEnemy=0
var turnOrder=[]
var action=["actionType","target"]
signal unlock

func _ready():
	%pcam.set_look_at_damping(true)
	%pcam.set_look_at_damping_value(.1)
	restoreMenuState()
	hpBar.max_value=mhealth
	hpBar.value=health
	tensBar.value=0
	tensText.text=str(tension)+"%"
	$window.position=$windowPos.position
	$window.windowInit(384.0, 88.0)
	$enemyWindow.set_visible(false)
	$enemyWindow.windowInit(256.0, 48.0,false,false)
	$enemyWindow.position=$windowPos/enemyNamePos.position
	
#var enemyList=$"../enemies".get_children()
func _process(_delta):
	hpText.text=str(health)
	#cursor.position.x
	match uiState:
		"startWindow":
			$"../pcam".look_at_mode=0
			$"../pcam".set_look_at_target($"../enemies")
			$window.textWindow(battleJSON.maremareEncounter.text,"actionPick")
		"actionPick":
			if Input.is_action_just_pressed("up"):
				$status/commands/selectSFX.play()
				$%commandAnims.play("fightNoFade")
				await $%commandAnims.animation_finished
				$%commandAnims.play_backwards("appear")
				$enemyWindow.set_visible(true)
				uiState="fight"
			elif Input.is_action_just_pressed("right"):
				$status/commands/selectSFX.play()
				$%commandAnims.play("stratNoFade")
				uiState="strat"
			elif Input.is_action_just_pressed("down"):
				$status/commands/selectSFX.play()
				$%commandAnims.play("fleeNoFade")
				uiState="flee"
			elif Input.is_action_just_pressed("left"):
				$status/commands/selectSFX.play()
				$%commandAnims.play("itemNoFade")
				uiState="item"
		"fight":
			var enemyList=$"../enemies".get_children()
			$"../pcam".look_at_mode=2
			$enemyWindow/text.set_text(str(enemyList[selectedEnemy]).get_slice(":",0))
			$"../pcam".set_look_at_target(enemyList[selectedEnemy])
			if Input.is_action_just_pressed("left"):
				if selectedEnemy != 0:
					selectedEnemy-=1
				elif selectedEnemy==0:
					selectedEnemy=len(enemyList)-1
			elif Input.is_action_just_pressed("right"):
				#$enemyWindow.flushText()
				if selectedEnemy != len(enemyList)-1:
					print("get fucked")
					selectedEnemy+=1
				else:
					selectedEnemy=0
			elif Input.is_action_just_pressed("ui_cancel"):
				$enemyWindow.flushText()
				$enemyWindow.set_visible(false)
				$%commandAnims.play("appear")
				#$"../pcam".look_at_mode=0
				$"../pcam".set_look_at_target($"../lookie")
				restoreMenuState()
				$window.flushText()
				#$window.textWindow(battleJSON.maremareEncounter.text,"nowhere",true)
				uiState="actionPick"
			elif Input.is_action_just_pressed("ui_select"):
				$enemyWindow.set_visible(false)
				$"../pcam".set_look_at_target($"../lookie")
				action=["basicAttack",enemyList[selectedEnemy]]
				restoreMenuState()
				playerMove(action)
				uiState="lock"
		"lock":
			await unlock

func restoreMenuState(): #ccould've made it more efficient but oh well lol
	$status/commands/fight.set_modulate(Color(1.0, 1.0, 1.0, 1.0))
	$status/commands/skill.set_modulate(Color(1.0, 1.0, 1.0, 1.0))
	$status/commands/item.set_modulate(Color(1.0, 1.0, 1.0, 1.0))
	$status/commands/run.set_modulate(Color(1.0, 1.0, 1.0, 1.0))
	
	$status/commands/fight.set_scale(Vector2i(2,2))
	$status/commands/skill.set_scale(Vector2i(2,2))
	$status/commands/item.set_scale(Vector2i(2,2))
	$status/commands/run.set_scale(Vector2i(2,2))

func playerMove(selectedAction):
	print("hi minty :3")
	match selectedAction[0]:
		"basicAttack":
			var dmg = damageCalc("playerBasicAttack")
			

func damageCalc(source):
	match source:
		"playerBasicAttack":
			return 14
