	db BLOBBOS ; 252

	db  42,  17,  36,  15,  15,  25
	;   hp  atk  def  spd  sat  sdf

	db ICE, ROCK ; type
	db 30 ; catch rate
	db 10 ; base exp
	db NO_ITEM, METAL_POWDER ; items
	db GENDER_UNKNOWN ; gender ratio
	db 100 ; unknown 1
	db 50 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/bulbasaur/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_DITTO, EGG_DITTO ; egg groups

	; tm/hm learnset
	tmhm HEADBUTT, CURSE, ROLLOUT, TOXIC, ROCK_SMASH, HIDDEN_POWER, SNORE, BLIZZARD, HYPER_BEAM, ICY_WIND, PROTECT, ENDURE, RETURN, MUD_SLAP, DOUBLE_TEAM, SLEEP_TALK, SWIFT, DEFENSE_CURL, REST, ATTRACT, ICE_BEAM
	; end
