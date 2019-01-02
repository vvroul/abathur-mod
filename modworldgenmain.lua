modimport("scripts/tile_adder.lua")

GLOBAL.require("constants")
local GROUND = GLOBAL.GROUND
GLOBAL.require("map/lockandkey")
GLOBAL.require("map/tasks")
local LOCKS = GLOBAL.LOCKS
local KEYS = GLOBAL.KEYS
local Layouts = GLOBAL.require("map/layouts").Layouts
local StaticLayout = GLOBAL.require("map/static_layout")


GLOBAL.require("map/terrain")


AddTile("ZERGCREEP", 84, "zergcreep", {noise_texture = "levels/textures/noise_zergcreep.tex",    runsound="dontstarve/movement/run_marble",		walksound="dontstarve/movement/walk_marble",	snowsound="dontstarve/movement/run_ice", mudsound = "dontstarve/movement/run_mud"}, {noise_texture = "levels/textures/mini_noise_zergcreep.tex"})