	object_const_def
	const ELMSLAB_ELM
	const ELMSLAB_ELMS_AIDE
	const ELMSLAB_POKE_BALL1
	const ELMSLAB_POKE_BALL2
	const ELMSLAB_POKE_BALL3
	const ELMSLAB_OFFICER

ElmsLab_MapScripts:
	def_scene_scripts
	scene_script BeechsLabMeetBeechScene, SCENE_ELMSLAB_MEET_ELM
	scene_script BeechsLabNoop1Scene,   SCENE_ELMSLAB_CANT_LEAVE
	scene_script BeechsLabNoop2Scene,   SCENE_ELMSLAB_NOOP
	scene_script BeechsLabNoop3Scene,   SCENE_ELMSLAB_MEET_OFFICER
	scene_script BeechsLabNoop4Scene,   SCENE_ELMSLAB_UNUSED
	scene_script BeechsLabNoop5Scene,   SCENE_ELMSLAB_AIDE_GIVES_POTION
	scene_const SCENE_ELMSLAB_AIDE_GIVES_POKE_BALLS

	def_callbacks
	callback MAPCALLBACK_OBJECTS, BeechsLabMoveBeechCallback

BeechsLabMeetBeechScene:
	sdefer BeechsLabWalkUpToBeechScript
	end

BeechsLabNoop1Scene:
	end

BeechsLabNoop2Scene:
	end

BeechsLabNoop3Scene:
	end

BeechsLabNoop4Scene:
	end

BeechsLabNoop5Scene:
	end

BeechsLabMoveBeechCallback:
	checkscene
	iftrue .Skip ; not SCENE_ELMSLAB_MEET_ELM
	moveobject ELMSLAB_ELM, 3, 4
.Skip:
	endcallback

BeechsLabWalkUpToBeechScript:
	applymovement PLAYER, BeechsLab_WalkUpToBeechMovement
	pause 15
	showemote EMOTE_BOLT, ELMSLAB_POKE_BALL2, 15
	cry SOBBOLB
	applymovement ELMSLAB_POKE_BALL2, BeechsLabSobbolbBullyBlobbos
	playsound SFX_STRENGTH
	earthquake 10
	applymovement ELMSLAB_POKE_BALL1, BeechsLabBlobbosHit
	waitsfx
	showemote EMOTE_SAD, ELMSLAB_POKE_BALL1, 15
	pause 30
	showemote EMOTE_SHOCK, ELMSLAB_ELM, 15
	turnobject ELMSLAB_ELM, RIGHT
	turnobject PLAYER, LEFT
	opentext
	writetext BeechText_Intro
	waitbutton
	turnobject ELMSLAB_ELM, UP
	turnobject PLAYER, UP
	writetext BeechText_Intro2
	waitbutton
	turnobject ELMSLAB_ELM, RIGHT
	turnobject PLAYER, LEFT
	writetext BeechText_Intro3
.MustSayYes:
	yesorno
	iftrue .BeechSaidYes
	writetext BeechText_Refused
	sjump .MustSayYes

.BeechSaidYes:
	writetext BeechText_Accepted
	promptbutton
	jump .BeechGetBlobbosSobbolb

.BeechGetBlobbosSobbolb:
	closetext
	turnobject PLAYER, UP
	applymovement ELMSLAB_ELM, BeechsLab_BeechToBlobbos
	disappear ELMSLAB_POKE_BALL1
	playsound SFX_BALL_WOBBLE
	waitsfx
	pause 20
	applymovement ELMSLAB_ELM, BeechsLab_BeechToSobbolb
	disappear ELMSLAB_POKE_BALL2
	playsound SFX_BALL_WOBBLE
	waitsfx
	pause 20
	applymovement ELMSLAB_ELM, BeechsLab_BeechFacePlayer
	pause 20
	opentext
	getmonname STRING_BUFFER_3, BLOBBOS
	writetext ReceivedStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	promptbutton
	givepoke BLOBBOS, 5, BERRY
	closetext
	opentext
	getmonname STRING_BUFFER_3, SOBBOLB
	writetext ReceivedStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	promptbutton
	closetext
	opentext
	givepoke SOBBOLB, 5, BERRY
	closetext
	opentext
	writetext BeechText_DirectToMrPokemon
	waitbutton
	closetext
	addcellnum PHONE_ELM
	opentext
	writetext GotBeechsNumberText
	playsound SFX_REGISTER_PHONE_NUMBER
	waitsfx
	waitbutton
	closetext
	setevent EVENT_GOT_A_POKEMON_FROM_ELM
	setevent EVENT_RIVAL_CHERRYGROVE_CITY
	setscene SCENE_ELMSLAB_AIDE_GIVES_POTION
	setmapscene NEW_BARK_TOWN, SCENE_NEWBARKTOWN_NOOP
	end

.BeechGetsEmailNext:
	writetext BeechText_ResearchAmbitions
	waitbutton
	closetext
	playsound SFX_GLASS_TING
	pause 30
	showemote EMOTE_SHOCK, ELMSLAB_ELM, 10
	turnobject ELMSLAB_ELM, DOWN
	opentext
	writetext BeechText_GotAnEmail
	waitbutton
	closetext
	opentext
	turnobject ELMSLAB_ELM, RIGHT
	writetext BeechText_MissionFromMrPokemon
	waitbutton
	closetext
	applymovement ELMSLAB_ELM, BeechsLab_BeechToDefaultPositionMovement1
	turnobject PLAYER, UP
	applymovement ELMSLAB_ELM, BeechsLab_BeechToDefaultPositionMovement2
	turnobject PLAYER, RIGHT
	opentext
	writetext BeechText_ChooseAPokemon
	waitbutton
	setscene SCENE_ELMSLAB_CANT_LEAVE
	closetext
	end

ProfBeechScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_SS_TICKET_FROM_ELM
	iftrue BeechCheckMasterBall
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue BeechGiveTicketScript
BeechCheckMasterBall:
	checkevent EVENT_GOT_MASTER_BALL_FROM_ELM
	iftrue BeechCheckEverstone
	checkflag ENGINE_RISINGBADGE
	iftrue BeechGiveMasterBallScript
BeechCheckEverstone:
	checkevent EVENT_GOT_EVERSTONE_FROM_ELM
	iftrue BeechScript_CallYou
	checkevent EVENT_SHOWED_TOGEPI_TO_ELM
	iftrue BeechGiveEverstoneScript
	checkevent EVENT_TOLD_ELM_ABOUT_TOGEPI_OVER_THE_PHONE
	iffalse BeechCheckTogepiEgg
	loadmonindex 1, TOGEPI
	special FindPartyMonThatSpeciesYourTrainerID
	iftrue ShowBeechTogepiScript
	loadmonindex 2, TOGETIC
	special FindPartyMonThatSpeciesYourTrainerID
	iftrue ShowBeechTogepiScript
	writetext BeechThoughtEggHatchedText
	waitbutton
	closetext
	end

BeechEggHatchedScript:
	loadmonindex 1, TOGEPI
	special FindPartyMonThatSpeciesYourTrainerID
	iftrue ShowBeechTogepiScript
	loadmonindex 2, TOGETIC
	special FindPartyMonThatSpeciesYourTrainerID
	iftrue ShowBeechTogepiScript
	sjump BeechCheckGotEggAgain

BeechCheckTogepiEgg:
	checkevent EVENT_GOT_TOGEPI_EGG_FROM_ELMS_AIDE
	iffalse BeechCheckGotEggAgain
	checkevent EVENT_TOGEPI_HATCHED
	iftrue BeechEggHatchedScript
BeechCheckGotEggAgain:
	checkevent EVENT_GOT_TOGEPI_EGG_FROM_ELMS_AIDE ; why are we checking it again?
	iftrue BeechWaitingEggHatchScript
	checkflag ENGINE_ZEPHYRBADGE
	iftrue BeechAideHasEggScript
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue BeechStudyingEggScript
	checkevent EVENT_GOT_MYSTERY_EGG_FROM_MR_POKEMON
	iftrue BeechAfterTheftScript
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue BeechDescribesMrPokemonScript
	writetext BeechText_LetYourMonBattleIt
	waitbutton
	closetext
	end

LabTryToLeaveScript:
	turnobject ELMSLAB_ELM, DOWN
	opentext
	writetext LabWhereGoingText
	waitbutton
	closetext
	applymovement PLAYER, BeechsLab_CantLeaveMovement
	end

CyndaquilPokeBallScript:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue LookAtBeechPokeBallScript
	turnobject ELMSLAB_ELM, DOWN
	reanchormap
	pokepic BLOBBOS
	cry BLOBBOS
	waitbutton
	closepokepic
	opentext
	writetext TakeCyndaquilText
	yesorno
	iffalse DidntChooseStarterScript
	disappear ELMSLAB_POKE_BALL1
	setevent EVENT_GOT_CYNDAQUIL_FROM_ELM
	writetext ChoseStarterText
	promptbutton
	waitsfx
	getmonname STRING_BUFFER_3, CYNDAQUIL
	writetext ReceivedStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	promptbutton
	givepoke BLOBBOS, 5, BERRY
	closetext
	readvar VAR_FACING
	ifequal RIGHT, BeechDirectionsScript
	applymovement PLAYER, AfterCyndaquilMovement
	sjump BeechDirectionsScript

TotodilePokeBallScript:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue LookAtBeechPokeBallScript
	turnobject ELMSLAB_ELM, DOWN
	reanchormap
	pokepic SOBBOLB
	cry SOBBOLB
	waitbutton
	closepokepic
	opentext
	writetext TakeTotodileText
	yesorno
	iffalse DidntChooseStarterScript
	disappear ELMSLAB_POKE_BALL2
	setevent EVENT_GOT_TOTODILE_FROM_ELM
	writetext ChoseStarterText
	promptbutton
	waitsfx
	getmonname STRING_BUFFER_3, TOTODILE
	writetext ReceivedStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	promptbutton
	givepoke SOBBOLB, 5, BERRY
	closetext
	applymovement PLAYER, AfterTotodileMovement
	sjump BeechDirectionsScript

ChikoritaPokeBallScript:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue LookAtBeechPokeBallScript
	turnobject ELMSLAB_ELM, DOWN
	reanchormap
	pokepic CHIKORITA
	cry CHIKORITA
	waitbutton
	closepokepic
	opentext
	writetext TakeChikoritaText
	yesorno
	iffalse DidntChooseStarterScript
	disappear ELMSLAB_POKE_BALL3
	setevent EVENT_GOT_CHIKORITA_FROM_ELM
	writetext ChoseStarterText
	promptbutton
	waitsfx
	getmonname STRING_BUFFER_3, CHIKORITA
	writetext ReceivedStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	promptbutton
	givepoke CHIKORITA, 5, BERRY
	closetext
	applymovement PLAYER, AfterChikoritaMovement
	sjump BeechDirectionsScript

DidntChooseStarterScript:
	writetext DidntChooseStarterText
	waitbutton
	closetext
	end

BeechDirectionsScript:
	turnobject PLAYER, UP
	opentext
	writetext BeechDirectionsText1
	waitbutton
	closetext
	addcellnum PHONE_ELM
	opentext
	writetext GotBeechsNumberText
	playsound SFX_REGISTER_PHONE_NUMBER
	waitsfx
	waitbutton
	closetext
	turnobject ELMSLAB_ELM, LEFT
	opentext
	writetext BeechDirectionsText2
	waitbutton
	closetext
	turnobject ELMSLAB_ELM, DOWN
	opentext
	writetext BeechDirectionsText3
	waitbutton
	closetext
	setevent EVENT_GOT_A_POKEMON_FROM_ELM
	setevent EVENT_RIVAL_CHERRYGROVE_CITY
	setscene SCENE_ELMSLAB_AIDE_GIVES_POTION
	setmapscene NEW_BARK_TOWN, SCENE_NEWBARKTOWN_NOOP
	end

BeechDescribesMrPokemonScript:
	writetext BeechDescribesMrPokemonText
	waitbutton
	closetext
	end

LookAtBeechPokeBallScript:
	opentext
	writetext BeechPokeBallText
	waitbutton
	closetext
	end

BeechsLabHealingMachine:
	opentext
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .CanHeal
	writetext BeechsLabHealingMachineText1
	waitbutton
	closetext
	end

.CanHeal:
	writetext BeechsLabHealingMachineText2
	yesorno
	iftrue BeechsLabHealingMachine_HealParty
	closetext
	end

BeechsLabHealingMachine_HealParty:
	special StubbedTrainerRankings_Healings
	special HealParty
	playmusic MUSIC_NONE
	setval HEALMACHINE_ELMS_LAB
	special HealMachineAnim
	pause 30
	special RestartMapMusic
	closetext
	end

BeechAfterTheftDoneScript:
	waitbutton
	closetext
	end

BeechAfterTheftScript:
	writetext BeechAfterTheftText1
	checkitem MYSTERY_EGG
	iffalse BeechAfterTheftDoneScript
	promptbutton
	writetext BeechAfterTheftText2
	waitbutton
	takeitem MYSTERY_EGG
	scall BeechJumpBackScript1
	writetext BeechAfterTheftText3
	waitbutton
	scall BeechJumpBackScript2
	writetext BeechAfterTheftText4
	promptbutton
	writetext BeechAfterTheftText5
	promptbutton
	setevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	setflag ENGINE_MOBILE_SYSTEM
	setmapscene ROUTE_29, SCENE_ROUTE29_CATCH_TUTORIAL
	clearevent EVENT_ROUTE_30_YOUNGSTER_JOEY
	setevent EVENT_ROUTE_30_BATTLE
	writetext BeechAfterTheftText6
	waitbutton
	closetext
	setscene SCENE_ELMSLAB_AIDE_GIVES_POKE_BALLS
	end

BeechStudyingEggScript:
	writetext BeechStudyingEggText
	waitbutton
	closetext
	end

BeechAideHasEggScript:
	writetext BeechAideHasEggText
	waitbutton
	closetext
	end

BeechWaitingEggHatchScript:
	writetext BeechWaitingEggHatchText
	waitbutton
	closetext
	end

ShowBeechTogepiScript:
	writetext ShowBeechTogepiText1
	waitbutton
	closetext
	showemote EMOTE_SHOCK, ELMSLAB_ELM, 15
	setevent EVENT_SHOWED_TOGEPI_TO_ELM
	opentext
	writetext ShowBeechTogepiText2
	promptbutton
	writetext ShowBeechTogepiText3
	promptbutton
BeechGiveEverstoneScript:
	writetext BeechGiveEverstoneText1
	promptbutton
	verbosegiveitem EVERSTONE
	iffalse BeechScript_NoRoomForEverstone
	writetext BeechGiveEverstoneText2
	waitbutton
	closetext
	setevent EVENT_GOT_EVERSTONE_FROM_ELM
	end

BeechScript_CallYou:
	writetext BeechText_CallYou
	waitbutton
BeechScript_NoRoomForEverstone:
	closetext
	end

BeechGiveMasterBallScript:
	writetext BeechGiveMasterBallText1
	promptbutton
	verbosegiveitem MASTER_BALL
	iffalse .notdone
	setevent EVENT_GOT_MASTER_BALL_FROM_ELM
	writetext BeechGiveMasterBallText2
	waitbutton
.notdone
	closetext
	end

BeechGiveTicketScript:
	writetext BeechGiveTicketText1
	promptbutton
	verbosegiveitem S_S_TICKET
	setevent EVENT_GOT_SS_TICKET_FROM_ELM
	writetext BeechGiveTicketText2
	waitbutton
	closetext
	end

BeechJumpBackScript1:
	closetext
	readvar VAR_FACING
	ifequal DOWN, BeechJumpDownScript
	ifequal UP, BeechJumpUpScript
	ifequal LEFT, BeechJumpLeftScript
	ifequal RIGHT, BeechJumpRightScript
	end

BeechJumpBackScript2:
	closetext
	readvar VAR_FACING
	ifequal DOWN, BeechJumpUpScript
	ifequal UP, BeechJumpDownScript
	ifequal LEFT, BeechJumpRightScript
	ifequal RIGHT, BeechJumpLeftScript
	end

BeechJumpUpScript:
	applymovement ELMSLAB_ELM, BeechJumpUpMovement
	opentext
	end

BeechJumpDownScript:
	applymovement ELMSLAB_ELM, BeechJumpDownMovement
	opentext
	end

BeechJumpLeftScript:
	applymovement ELMSLAB_ELM, BeechJumpLeftMovement
	opentext
	end

BeechJumpRightScript:
	applymovement ELMSLAB_ELM, BeechJumpRightMovement
	opentext
	end

AideScript_WalkPotion1:
	applymovement ELMSLAB_ELMS_AIDE, AideWalksRight1
	turnobject PLAYER, DOWN
	scall AideScript_GivePotion
	applymovement ELMSLAB_ELMS_AIDE, AideWalksLeft1
	end

AideScript_WalkPotion2:
	applymovement ELMSLAB_ELMS_AIDE, AideWalksRight2
	turnobject PLAYER, DOWN
	scall AideScript_GivePotion
	applymovement ELMSLAB_ELMS_AIDE, AideWalksLeft2
	end

AideScript_GivePotion:
	opentext
	writetext AideText_GiveYouPotion
	promptbutton
	verbosegiveitem POTION
	writetext AideText_AlwaysBusy
	waitbutton
	closetext
	setscene SCENE_ELMSLAB_NOOP
	end

AideScript_WalkBalls1:
	applymovement ELMSLAB_ELMS_AIDE, AideWalksRight1
	turnobject PLAYER, DOWN
	scall AideScript_GiveYouBalls
	applymovement ELMSLAB_ELMS_AIDE, AideWalksLeft1
	end

AideScript_WalkBalls2:
	applymovement ELMSLAB_ELMS_AIDE, AideWalksRight2
	turnobject PLAYER, DOWN
	scall AideScript_GiveYouBalls
	applymovement ELMSLAB_ELMS_AIDE, AideWalksLeft2
	end

AideScript_GiveYouBalls:
	opentext
	writetext AideText_GiveYouBalls
	promptbutton
	getitemname STRING_BUFFER_4, POKE_BALL
	scall AideScript_ReceiveTheBalls
	giveitem POKE_BALL, 5
	writetext AideText_ExplainBalls
	promptbutton
	itemnotify
	closetext
	setscene SCENE_ELMSLAB_NOOP
	end

AideScript_ReceiveTheBalls:
	jumpstd ReceiveItemScript
	end

BeechsAideScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_TOGEPI_EGG_FROM_ELMS_AIDE
	iftrue AideScript_AfterTheft
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue AideScript_ExplainBalls
	checkevent EVENT_GOT_MYSTERY_EGG_FROM_MR_POKEMON
	iftrue AideScript_TheftTestimony
	writetext AideText_AlwaysBusy
	waitbutton
	closetext
	end

AideScript_TheftTestimony:
	writetext AideText_TheftTestimony
	waitbutton
	closetext
	end

AideScript_ExplainBalls:
	writetext AideText_ExplainBalls
	waitbutton
	closetext
	end

AideScript_AfterTheft:
	writetext AideText_AfterTheft
	waitbutton
	closetext
	end

MeetCopScript2:
	applymovement PLAYER, MeetCopScript2_StepLeft

MeetCopScript:
	applymovement PLAYER, MeetCopScript_WalkUp
CopScript:
	turnobject ELMSLAB_OFFICER, LEFT
	opentext
	writetext BeechsLabOfficerText1
	promptbutton
	special NameRival
	writetext BeechsLabOfficerText2
	waitbutton
	closetext
	applymovement ELMSLAB_OFFICER, OfficerLeavesMovement
	disappear ELMSLAB_OFFICER
	setscene SCENE_ELMSLAB_NOOP
	end

BeechsLabWindow:
	opentext
	checkflag ENGINE_FLYPOINT_VIOLET
	iftrue .Normal
	checkevent EVENT_ELM_CALLED_ABOUT_STOLEN_POKEMON
	iftrue .BreakIn
	sjump .Normal

.BreakIn:
	writetext BeechsLabWindowText2
	waitbutton
	closetext
	end

.Normal:
	writetext BeechsLabWindowText1
	waitbutton
	closetext
	end

BeechsLabTravelTip1:
	jumptext BeechsLabTravelTip1Text

BeechsLabTravelTip2:
	jumptext BeechsLabTravelTip2Text

BeechsLabTravelTip3:
	jumptext BeechsLabTravelTip3Text

BeechsLabTravelTip4:
	jumptext BeechsLabTravelTip4Text

BeechsLabTrashcan:
	jumptext BeechsLabTrashcanText

BeechsLabPC:
	jumptext BeechsLabPCText

BeechsLabTrashcan2: ; unreferenced
	jumpstd TrashCanScript

BeechsLabBookshelf:
	jumpstd DifficultBookshelfScript

BeechsLab_WalkUpToBeechMovement:
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	step_end

BeechsLab_CantLeaveMovement:
	step UP
	step_end

MeetCopScript2_StepLeft:
	step LEFT
	step_end

MeetCopScript_WalkUp:
	step UP
	step UP
	turn_head RIGHT
	step_end

OfficerLeavesMovement:
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step_end

AideWalksRight1:
	step RIGHT
	step RIGHT
	turn_head UP
	step_end

AideWalksRight2:
	step RIGHT
	step RIGHT
	step RIGHT
	turn_head UP
	step_end

AideWalksLeft1:
	step LEFT
	step LEFT
	turn_head DOWN
	step_end

AideWalksLeft2:
	step LEFT
	step LEFT
	step LEFT
	turn_head DOWN
	step_end

BeechJumpUpMovement:
	fix_facing
	big_step UP
	remove_fixed_facing
	step_end

BeechJumpDownMovement:
	fix_facing
	big_step DOWN
	remove_fixed_facing
	step_end

BeechJumpLeftMovement:
	fix_facing
	big_step LEFT
	remove_fixed_facing
	step_end

BeechJumpRightMovement:
	fix_facing
	big_step RIGHT
	remove_fixed_facing
	step_end

BeechsLab_BeechToBlobbos:
	step UP
	turn_head RIGHT
	step_end

BeechsLab_BeechToSobbolb:
	step RIGHT
	step_end

BeechsLab_BeechFacePlayer:
	turn_head DOWN
	step_end

BeechsLabSobbolbBullyBlobbos:
	fast_slide_step LEFT
	step_end

BeechsLabBlobbosHit:
	fix_facing
	fast_slide_step LEFT
	step_sleep 8
	step_sleep 8
	step_sleep 8
	step_sleep 8
	remove_fixed_facing
	slow_step RIGHT
	step_end

BeechsLab_BeechToDefaultPositionMovement1:
	step UP
	step_end

BeechsLab_BeechToDefaultPositionMovement2:
	step RIGHT
	step RIGHT
	step UP
	turn_head DOWN
	step_end

AfterCyndaquilMovement:
	step LEFT
	step UP
	turn_head UP
	step_end

AfterTotodileMovement:
	step LEFT
	step LEFT
	step UP
	turn_head UP
	step_end

AfterChikoritaMovement:
	step LEFT
	step LEFT
	step LEFT
	step UP
	turn_head UP
	step_end

BeechText_Intro:
	text "BEECH: Yo!"
	line "It's <PLAY_G>!"
	cont "Konnichiwassup!"

	para "I need your"
	line "help, <PLAY_G>."

	para "As you may know,"
	line "at this lab,"

	para "I conduct dream"
	line "research."

	para "My DREAM MACHINE"
	line "lets me analyse"
	cont "#MON dreams."

	para "When I used the"
	line "machine on"
	cont "BLOBBOS,"
	cont "another #MON"
	cont "popped out!"

	para "But I've never"
	line "seen this #MON"
	cont "before."

	para "I've named it"
	line "SOBBOLB!"

	para "But SOBBOLB is"
	line "a bully."
	done

BeechText_Intro2:
	text "BLOBBOS and"
	line "SOBBOLB, the two"
	cont "of them hate"
	cont "each other, man!"
	done

BeechText_Intro3:
	text "<PLAY_G>, can"
	line "you raise these"
	cont "two to get"
	cont "along for me?"
	done

BeechText_Accepted:
	text "Thanks, <PLAY_G>!"

	para "You're doing me"
	line "a massive favor."
	done

BeechText_Refused:
	text "Don't be like that,"
	line "<PLAY_G>!"
	done

BeechText_DirectToMrPokemon:
	text "One more thing,"
	line "<PLAY_G>."

	para "I have an ac-"
	line "quaintance named"
	cont "MR. #MON."

	para "He lives nearby,"
	line "on ROUTE 30."

	para "He's been spend-"
	line "ing his retire-"
	cont "ment doing all"
	cont "sorts of #MON"
	cont "research."

	para "The guy's a bit"
	line "of a crank, but"
	cont "he often comes"
	cont "up with cool"
	cont "findings."

	para "Anyway, he's"
	line "called me over"
	cont "about something,"
	cont "but I'm super busy"
	cont "A-T-M."

	para "You'll go in"
	line "my place, won't"
	cont "you <PLAY_G>?"

	para "Here, take my"
	line "number in case you"
	cont "need to reach me."

	done

BeechText_ResearchAmbitions:
	text "When I announce my"
	line "findings, I'm sure"

	para "we'll delve a bit"
	line "deeper into the"

	para "many mysteries of"
	line "#MON."

	para "You can count on"
	line "it!"
	done

BeechText_GotAnEmail:
	text "Oh, hey! I got an"
	line "e-mail!"

	para "<……><……><……>"
	line "Hm… Uh-huh…"

	para "Okay…"
	done

BeechText_MissionFromMrPokemon:
	text "Hey, listen."

	para "I have an acquain-"
	line "tance called MR."
	cont "#MON."

	para "He keeps finding"
	line "weird things and"

	para "raving about his"
	line "discoveries."

	para "Anyway, I just got"
	line "an e-mail from him"

	para "saying that this"
	line "time it's real."

	para "It is intriguing,"
	line "but we're busy"

	para "with our #MON"
	line "research…"

	para "Wait!"

	para "I know!"

	para "<PLAY_G>, can you"
	line "go in our place?"
	done

BeechText_ChooseAPokemon:
	text "I want you to"
	line "raise one of the"

	para "#MON contained"
	line "in these BALLS."

	para "You'll be that"
	line "#MON's first"
	cont "partner, <PLAY_G>!"

	para "Go on. Pick one!"
	done

BeechText_LetYourMonBattleIt:
	text "If a wild #MON"
	line "appears, let your"
	cont "#MON battle it!"
	done

LabWhereGoingText:
	text "BEECH: Wait! Where"
	line "are you going?"
	done

TakeCyndaquilText:
	text "BEECH: You'll take"
	line "CYNDAQUIL, the"
	cont "fire #MON?"
	done

TakeTotodileText:
	text "BEECH: Do you want"
	line "TOTODILE, the"
	cont "water #MON?"
	done

TakeChikoritaText:
	text "BEECH: So, you like"
	line "CHIKORITA, the"
	cont "grass #MON?"
	done

DidntChooseStarterText:
	text "BEECH: Think it over"
	line "carefully."

	para "Your partner is"
	line "important."
	done

ChoseStarterText:
	text "BEECH: I think"
	line "that's a great"
	cont "#MON too!"
	done

ReceivedStarterText:
	text "<PLAYER> received"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done

BeechDirectionsText1:
	text "MR.#MON lives a"
	line "little bit beyond"

	para "CHERRYGROVE, the"
	line "next city over."

	para "It's almost a"
	line "direct route"

	para "there, so you"
	line "can't miss it."

	para "But just in case,"
	line "here's my phone"

	para "number. Call me if"
	line "anything comes up!"
	done

BeechDirectionsText2:
	text "If your #MON is"
	line "hurt, you should"

	para "heal it with this"
	line "machine."

	para "Feel free to use"
	line "it anytime."
	done

BeechDirectionsText3:
	text "<PLAY_G>, I'm"
	line "counting on you!"
	done

GotBeechsNumberText:
	text "<PLAYER> got BEECH's"
	line "phone number."
	done

BeechDescribesMrPokemonText:
	text "I first heard"
	line "about MR.#MON"
	cont "from ELM, who I"
	cont "bought this"
	cont "building from."

	para "He was pretty"
	line "dismissive about"
	cont "him, but I think"
	cont "MR.#MON's cool."
	done

BeechPokeBallText:
	text "It contains a"
	line "#MON caught by"
	cont "PROF.BEECH."
	done

BeechsLabHealingMachineText1:
	text "I wonder what this"
	line "does?"
	done

BeechsLabHealingMachineText2:
	text "Would you like to"
	line "heal your #MON?"
	done

BeechAfterTheftText1:
	text "BEECH: <PLAY_G>, this"
	line "is terrible…"

	para "Oh, yes, what was"
	line "MR.#MON's big"
	cont "discovery?"
	done

BeechAfterTheftText2:
	text "<PLAYER> handed"
	line "the MYSTERY EGG to"
	cont "PROF.BEECH."
	done

BeechAfterTheftText3:
	text "BEECH: This?"
	done

BeechAfterTheftText4:
	text "But… Is it a"
	line "#MON EGG?"

	para "If it is, it is a"
	line "great discovery!"
	done

BeechAfterTheftText5:
	text "BEECH: What?!?"

	para "PROF.OAK gave you"
	line "a #DEX?"

	para "<PLAY_G>, is that"
	line "true? Th-that's"
	cont "incredible!"

	para "He is superb at"
	line "seeing the poten-"
	cont "tial of people as"
	cont "trainers."

	para "Wow, <PLAY_G>. You"
	line "may have what it"

	para "takes to become"
	line "the CHAMPION."

	para "You seem to be"
	line "getting on great"
	cont "with #MON too."

	para "You should take"
	line "the #MON GYM"
	cont "challenge."

	para "The closest GYM"
	line "would be the one"
	cont "in VIOLET CITY."
	done

BeechAfterTheftText6:
	text "…<PLAY_G>. The"
	line "road to the"

	para "championship will"
	line "be a long one."

	para "Before you leave,"
	line "make sure that you"
	cont "talk to your mom."
	done

BeechStudyingEggText:
	text "BEECH: Don't give"
	line "up! I'll call if"

	para "I learn anything"
	line "about that EGG!"
	done

BeechAideHasEggText:
	text "BEECH: <PLAY_G>?"
	line "Didn't you meet my"
	cont "assistant?"

	para "He should have met"
	line "you with the EGG"

	para "at VIOLET CITY's"
	line "#MON CENTER."

	para "You must have just"
	line "missed him. Try to"
	cont "catch him there."
	done

BeechWaitingEggHatchText:
	text "BEECH: Hey, has that"
	line "EGG changed any?"
	done

BeechThoughtEggHatchedText:
	text "<PLAY_G>? I thought"
	line "the EGG hatched."

	para "Where is the"
	line "#MON?"
	done

ShowBeechTogepiText1:
	text "BEECH: <PLAY_G>, you"
	line "look great!"
	done

ShowBeechTogepiText2:
	text "What?"
	line "That #MON!?!"
	done

ShowBeechTogepiText3:
	text "The EGG hatched!"
	line "So, #MON are"
	cont "born from EGGS…"

	para "No, perhaps not"
	line "all #MON are."

	para "Wow, there's still"
	line "a lot of research"
	cont "to be done."
	done

BeechGiveEverstoneText1:
	text "Thanks, <PLAY_G>!"
	line "You're helping"

	para "unravel #MON"
	line "mysteries for us!"

	para "I want you to have"
	line "this as a token of"
	cont "our appreciation."
	done

BeechGiveEverstoneText2:
	text "That's an"
	line "EVERSTONE."

	para "Some species of"
	line "#MON evolve"

	para "when they grow to"
	line "certain levels."

	para "A #MON holding"
	line "the EVERSTONE"
	cont "won't evolve."

	para "Give it to a #-"
	line "MON you don't want"
	cont "to evolve."
	done

BeechText_CallYou:
	text "BEECH: <PLAY_G>, I'll"
	line "call you if any-"
	cont "thing comes up."
	done

AideText_AfterTheft:
	text "…sigh… That"
	line "stolen #MON."

	para "I wonder how it's"
	line "doing."

	para "They say a #MON"
	line "raised by a bad"

	para "person turns bad"
	line "itself."
	done

BeechGiveMasterBallText1:
	text "BEECH: Hi, <PLAY_G>!"
	line "Thanks to you, my"

	para "research is going"
	line "great!"

	para "Take this as a"
	line "token of my"
	cont "appreciation."
	done

BeechGiveMasterBallText2:
	text "The MASTER BALL is"
	line "the best!"

	para "It's the ultimate"
	line "BALL! It'll catch"

	para "any #MON with-"
	line "out fail."

	para "It's given only to"
	line "recognized #MON"
	cont "researchers."

	para "I think you can"
	line "make much better"

	para "use of it than I"
	line "can, <PLAY_G>!"
	done

BeechGiveTicketText1:
	text "BEECH: <PLAY_G>!"
	line "There you are!"

	para "I called because I"
	line "have something for"
	cont "you."

	para "See? It's an"
	line "S.S.TICKET."

	para "Now you can catch"
	line "#MON in KANTO."
	done

BeechGiveTicketText2:
	text "The ship departs"
	line "from OLIVINE CITY."

	para "But you knew that"
	line "already, <PLAY_G>."

	para "After all, you've"
	line "traveled all over"
	cont "with your #MON."

	para "Give my regards to"
	line "PROF.OAK in KANTO!"
	done

BeechsLabMonEggText: ; unreferenced
	text "It's the #MON"
	line "EGG being studied"
	cont "by PROF.BEECH."
	done

AideText_GiveYouPotion:
	text "<PLAY_G>, I want"
	line "you to have this"
	cont "for your errand."
	done

AideText_AlwaysBusy:
	text "Dream research"
	line "historically"
	cont "pays poorly."

	para "But recently,"
	line "we attracted a"
	cont "wealthy sponsor,"
	cont "and we've been"
	cont "able to work non-"
	cont "stop!"

	para "Although I don't"
	line "know that much"
	cont "about our sponsor,"
	cont "mind you…"
	done

AideText_TheftTestimony:
	text "There was a loud"
	line "noise outside…"

	para "When we went to"
	line "look, someone"
	cont "stole a #MON."

	para "It's unbelievable"
	line "that anyone would"
	cont "do that!"

	para "…sigh… That"
	line "stolen #MON."

	para "I wonder how it's"
	line "doing."

	para "They say a #MON"
	line "raised by a bad"

	para "person turns bad"
	line "itself."
	done

AideText_GiveYouBalls:
	text "<PLAY_G>!"

	para "Use these on your"
	line "#DEX quest!"
	done

AideText_ExplainBalls:
	text "To add to your"
	line "#DEX, you have"
	cont "to catch #MON."

	para "Throw # BALLS"
	line "at wild #MON"
	cont "to get them."
	done

BeechsLabOfficerText1:
	text "I heard a #MON"
	line "was stolen here…"

	para "I was just getting"
	line "some information"
	cont "from PROF.BEECH."

	para "Apparently, it was"
	line "a young male with"
	cont "long, red hair…"

	para "What?"

	para "You battled a"
	line "trainer like that?"

	para "Did you happen to"
	line "get his name?"
	done

BeechsLabOfficerText2:
	text "OK! So <RIVAL>"
	line "was his name."

	para "Thanks for helping"
	line "my investigation!"
	done

BeechsLabWindowText1:
	text "The window's open."

	para "A pleasant breeze"
	line "is blowing in."
	done

BeechsLabWindowText2:
	text "He broke in"
	line "through here!"
	done

BeechsLabTravelTip1Text:
	text "<PLAYER> opened a"
	line "book."

	para "Travel Tip 1:"

	para "Press START to"
	line "open the MENU."
	done

BeechsLabTravelTip2Text:
	text "<PLAYER> opened a"
	line "book."

	para "Travel Tip 2:"

	para "Record your trip"
	line "with SAVE!"
	done

BeechsLabTravelTip3Text:
	text "<PLAYER> opened a"
	line "book."

	para "Travel Tip 3:"

	para "Open your PACK and"
	line "press SELECT to"
	cont "move items."
	done

BeechsLabTravelTip4Text:
	text "<PLAYER> opened a"
	line "book."

	para "Travel Tip 4:"

	para "Check your #MON"
	line "moves. Press the"

	para "A Button to switch"
	line "moves."
	done

BeechsLabTrashcanText:
	text "The wrapper from"
	line "the snack PROF.BEECH"
	cont "ate is in there…"
	done

BeechsLabPCText:
	text "OBSERVATIONS ON"
	line "#MON EVOLUTION"

	para "…It says on the"
	line "screen…"
	done

ElmsLab_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 11, NEW_BARK_TOWN, 1
	warp_event  5, 11, NEW_BARK_TOWN, 1

	def_coord_events
	coord_event  4,  6, SCENE_ELMSLAB_CANT_LEAVE, LabTryToLeaveScript
	coord_event  5,  6, SCENE_ELMSLAB_CANT_LEAVE, LabTryToLeaveScript
	coord_event  4,  5, SCENE_ELMSLAB_MEET_OFFICER, MeetCopScript
	coord_event  5,  5, SCENE_ELMSLAB_MEET_OFFICER, MeetCopScript2
	coord_event  4,  8, SCENE_ELMSLAB_AIDE_GIVES_POTION, AideScript_WalkPotion1
	coord_event  5,  8, SCENE_ELMSLAB_AIDE_GIVES_POTION, AideScript_WalkPotion2
	coord_event  4,  8, SCENE_ELMSLAB_AIDE_GIVES_POKE_BALLS, AideScript_WalkBalls1
	coord_event  5,  8, SCENE_ELMSLAB_AIDE_GIVES_POKE_BALLS, AideScript_WalkBalls2

	def_bg_events
	bg_event  2,  1, BGEVENT_READ, BeechsLabHealingMachine
	bg_event  6,  1, BGEVENT_READ, BeechsLabBookshelf
	bg_event  7,  1, BGEVENT_READ, BeechsLabBookshelf
	bg_event  8,  1, BGEVENT_READ, BeechsLabBookshelf
	bg_event  9,  1, BGEVENT_READ, BeechsLabBookshelf
	bg_event  0,  7, BGEVENT_READ, BeechsLabTravelTip1
	bg_event  1,  7, BGEVENT_READ, BeechsLabTravelTip2
	bg_event  2,  7, BGEVENT_READ, BeechsLabTravelTip3
	bg_event  3,  7, BGEVENT_READ, BeechsLabTravelTip4
	bg_event  6,  7, BGEVENT_READ, BeechsLabBookshelf
	bg_event  7,  7, BGEVENT_READ, BeechsLabBookshelf
	bg_event  8,  7, BGEVENT_READ, BeechsLabBookshelf
	bg_event  9,  7, BGEVENT_READ, BeechsLabBookshelf
	bg_event  1,  5, BGEVENT_READ, BeechsLabTrashcan
	bg_event  5,  0, BGEVENT_READ, BeechsLabWindow
	bg_event  3,  5, BGEVENT_DOWN, BeechsLabPC

	def_object_events
	object_event  5,  2, SPRITE_ELM, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ProfBeechScript, -1
	object_event  2,  9, SPRITE_SCIENTIST, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, BeechsAideScript, EVENT_ELMS_AIDE_IN_LAB
	object_event  4,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CyndaquilPokeBallScript, EVENT_CYNDAQUIL_POKEBALL_IN_ELMS_LAB
	object_event  6,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TotodilePokeBallScript, EVENT_TOTODILE_POKEBALL_IN_ELMS_LAB
	object_event  0,  0, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ChikoritaPokeBallScript, EVENT_CHIKORITA_POKEBALL_IN_ELMS_LAB
	object_event  5,  3, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CopScript, EVENT_COP_IN_ELMS_LAB
