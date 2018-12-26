PrefabFiles = {
	"abathur",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/abathur.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/abathur.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/abathur.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/abathur.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/abathur_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/abathur_silho.xml" ),

    Asset( "IMAGE", "bigportraits/abathur.tex" ),
    Asset( "ATLAS", "bigportraits/abathur.xml" ),
	
	Asset( "IMAGE", "images/map_icons/abathur.tex" ),
	Asset( "ATLAS", "images/map_icons/abathur.xml" ),

}

local require = GLOBAL.require

-- The character select screen lines
GLOBAL.STRINGS.CHARACTER_TITLES.abathur = "The Sample Character"
GLOBAL.STRINGS.CHARACTER_NAMES.abathur = "Esc"
GLOBAL.STRINGS.CHARACTER_DESCRIPTIONS.abathur = "*Perk 1\n*Perk 2\n*Perk 3"
GLOBAL.STRINGS.CHARACTER_QUOTES.abathur = "\"Quote\""

-- Custom speech strings
GLOBAL.STRINGS.CHARACTERS.abathur = require "speech_abathur"

-- Let the game know character is male, female, or robot
table.insert(GLOBAL.CHARACTER_GENDERS.FEMALE, "abathur")


AddMinimapAtlas("images/map_icons/abathur.xml")
AddModCharacter("abathur")

