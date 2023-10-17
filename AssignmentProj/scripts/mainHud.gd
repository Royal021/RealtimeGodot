extends CanvasLayer

var hp_gradient: GradientTexture1D = preload("res://assets/UIelements/hp1Dgradient.tres")

#export var hp_gradient: GradientTexture1D

func do_change_score(new_value):
	$scoreLabel.text = "Score:  " +  str(new_value)
	
func do_change_health(new_health_percent):
	var bar = $healthBar
	bar.value = new_health_percent * bar.max_value
	
	bar.tint_progress = hp_gradient.gradient.sample(new_health_percent)

#func on_button_button_down():
#	print("you Clicked me!")
