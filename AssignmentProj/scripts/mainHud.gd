extends CanvasLayer

var hp_gradient: GradientTexture1D = preload("res://assets/UIelements/hp1Dgradient.tres")

#export var hp_gradient: GradientTexture1D

func _process(delta):
	$scoreLabel.text = "Score:  " +  str(Globals.total_score)
	var bar = $healthBar
	bar.value = Globals.healthPoints * bar.max_value
	bar.tint_progress = hp_gradient.gradient.sample(Globals.healthPoints)

