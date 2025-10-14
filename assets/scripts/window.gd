extends NinePatchRect

var windowState="busy"
#signal continueText

func windowInit(length,width):
	set_size(Vector2(length,width))
	$continueIcon.visible=false
	$continueIcon.play()
	#$text.set_text("* i like girls kissing <3 \n")
func textWindow(text,whereTo=null,quickWindow=null,center=null):
	if quickWindow==true:
		$text.set_text(text)
		$continueIcon.visible=false
	match windowState:
		"busy":
			$continueIcon.visible=false
			$text.set_text(text)
			$text/appearingText.play("start")
			await $text/appearingText.animation_finished
			windowState="free"
		"free":
			#print(windowState)
			$continueIcon.visible=true
			if Input.is_action_just_pressed("ui_select"):
				#continueText.emit()
				$%continueSFX.play()
				flushText()
				if whereTo=="actionPick":
					$%commandAnims.play("appear")
					$"..".uiState="actionPick"
func flushText():
	$continueIcon.visible=false
	$text.set_text("")
	print("#flushed")
