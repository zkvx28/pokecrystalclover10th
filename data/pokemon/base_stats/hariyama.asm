	db HARIYAMA ; 277

	db 144, 120,  60,  55,  40,  60
	;   hp  atk  def  spd  sat  sdf

	db FIGHTING, FIGHTING ; type
	db 200 ; catch rate
	db 184 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F25 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/hariyama/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_HUMANSHAPE, EGG_HUMANSHAPE ; egg groups

	; tm/hm learnset
	tmhm DYNAMICPUNCH, HEADBUTT, CURSE, TOXIC, ROCK_SMASH, HIDDEN_POWER, SNORE, PROTECT, RAIN_DANCE, SUNNY_DAY, ENDURE, FRUSTRATION, RETURN, EARTHQUAKE, MUD_SLAP, DOUBLE_TEAM, ICE_PUNCH, SLEEP_TALK, SANDSTORM, DETECT, REST, ATTRACT, FIRE_PUNCH, THUNDERPUNCH, STRENGTH
	; end
