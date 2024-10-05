	db DRIFBLIM ; 259

	db 150,  80,  44,  80,  90,  54
	;   hp  atk  def  spd  sat  sdf

	db GHOST, FLYING ; type
	db 30 ; catch rate
	db 230 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 30 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/drifblim/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_INDETERMINATE, EGG_INDETERMINATE ; egg groups

	; tm/hm learnset
	tmhm CURSE, TOXIC, HIDDEN_POWER, PROTECT, FRUSTRATION, RETURN, PSYCHIC_M, SHADOW_BALL, DOUBLE_TEAM, SWIFT, SUNNY_DAY, RAIN_DANCE, THUNDER, SWIFT, THUNDERBOLT, HYPER_BEAM
	; end
