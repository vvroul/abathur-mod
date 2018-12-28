PrefabFiles = {
	"aba",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/aba.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/aba.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/aba.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/aba.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/aba_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/aba_silho.xml" ),

    Asset( "IMAGE", "bigportraits/aba.tex" ),
    Asset( "ATLAS", "bigportraits/aba.xml" ),

}

-- The character select screen lines
-- note: these are lower-case character name
GLOBAL.STRINGS.CHARACTER_TITLES.aba = "The Swarm Evolution Master"
GLOBAL.STRINGS.CHARACTER_NAMES.aba = "Abathur"  -- Note! This line is especially important as some parts of the game require the character to have a valid name.
GLOBAL.STRINGS.CHARACTER_DESCRIPTIONS.aba = "Can spawn toxic nests. \nHeals all friendly units. \nAbilities: T for toxic nests, M for mend."
GLOBAL.STRINGS.CHARACTER_QUOTES.aba = "\"Evolution never over.\""

-- You can also add any kind of custom dialogue that you would like. Don't forget to make
-- categores that don't exist yet using = {}
-- note: these are UPPER-CASE charcacter name
GLOBAL.STRINGS.CHARACTERS.aba = {}
GLOBAL.STRINGS.CHARACTERS.aba.DESCRIBE = {}
GLOBAL.STRINGS.CHARACTERS.aba.DESCRIBE.EVERGREEN = "A template description of a tree."

-- Let the game know aba is a male, for proper pronouns during the end-game sequence.
-- Possible genders here are MALE, FEMALE, or ROBOT
table.insert(GLOBAL.CHARACTER_GENDERS.ROBOT, "aba")


AddModCharacter("aba")