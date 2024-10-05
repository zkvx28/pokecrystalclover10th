	db AGGRON ; 266

	db  70, 110, 180,  50,  60,  60
	;   hp  atk  def  spd  sat  sdf

	db STEEL, ROCK ; type
	db 45 ; catch rate
	db 205 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 35 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/aggron/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_MONSTER, EGG_MONSTER ; egg groups

	; tm/hm learnset
	tmhm HEADBUTT, CURSE, ROLLOUT, ROAR, TOXIC, ROCK_SMASH, SNORE, PROTECT, ENDURE, DRAGONBREATH, EARTHQUAKE, RETURN, MUD_SLAP, SANDSTORM, REST, ATTRACT, STRENGTH, HYPER_BEAM
	; end
