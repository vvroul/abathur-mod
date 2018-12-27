-- This information tells other players more about the mod
name = "Abathur"
description = "Thanks for playing with Abathur!"
author = "shyAba"
version = "1.00"

-- This is the URL name of the mod's thread on the forum; the part after the index.php? and before the first & in the URL
-- Example:
-- http://forums.kleientertainment.com/index.php?/files/file/202-sample-mods/
-- becomes
-- /files/file/202-sample-mods/
forumthread = "http://forums.kleientertainment.com/topic/54582-custom-character-kerrigan-the-queen-of-blades-dst-version/"-- "/files/file/202-sample-mods/"

-- This lets other players know if your mod is out of date, update it to match the current version in the game
api_version = 6
api_version_dst =10

dont_starve_compatible = true
reign_of_giants_compatible = true
dst_compatible = true
shipwrecked_compatible = true

all_clients_require_mod = true

server_filter_tags = {"zerg", "starcraft", "abathur"}

icon_atlas = "modicon.xml"
icon = "modicon.tex"


configuration_options =
{
    {
        name = "dronegather",
        label = "drone automaticgathering",
        options =
        {
            {description = "on (default)", data = 1},
            {description = "off", data = 0},
        },
        default = 1,
    },
		{
        name = "attackorder",
        label = "attack order",
        options =
        {   {description = "off", data = "off"},
            {description = "R (default)", data = "R"},
            {description = "T", data = "T"},
            {description = "Y", data = "Y"},
            {description = "U", data = "U"},
            {description = "G", data = "G"},
            {description = "H", data = "H"},
            {description = "J", data = "J"},
            {description = "Z", data = "Z"},
            {description = "X", data = "X"},
            {description = "C", data = "C"},
            {description = "V", data = "V"},
            {description = "B", data = "B"},
            {description = "N", data = "N"},
        },
        default = "R",
    },
	{
        name = "dronetarget",
        label = "drone smart targeting",
        options =
        {
            {description = "on (default)", data = 1},
            {description = "off", data = 0},
        },
        default = 1,
    },
	{
        name = "stopattackorder",
        label = "stop attacking order",
        options =
        {   {description = "off", data = "off"},
            {description = "R", data = "R"},
            {description = "T", data = "T"},
            {description = "Y", data = "Y"},
            {description = "U", data = "U"},
            {description = "G", data = "G"},
            {description = "H", data = "H"},
            {description = "J", data = "J"},
            {description = "Z", data = "Z"},
            {description = "X", data = "X"},
            {description = "C (default)", data = "C"},
            {description = "V", data = "V"},
            {description = "B", data = "B"},
            {description = "N", data = "N"},
        },
        default = "C",
    },
	    {
        name = "custompunch",
        label = "custom punch animation",
        options =
        {
            {description = "on (default)", data = 1},
            {description = "off", data = 0},
        },
        default = 1,
    },
		    {
        name = "difficulty",
        label = "difficulty",
        options =
        {
            {description = "normal (default)", data = 0},
            {description = "hard", data = 1},
			{description = "brutal", data = 2},
        },
        default = 0,
    },
	}