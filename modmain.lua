
PrefabFiles = {
	"ker",
	"larva",
	"zergling",
	"overlord",
	"drone",
	"hydralisk",
	"hydraliskmark",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/ker.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/ker.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/ker.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/ker.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/ker_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/ker_silho.xml" ),

    Asset( "IMAGE", "bigportraits/ker.tex" ),
    Asset( "ATLAS", "bigportraits/ker.xml" ),
	Asset("ATLAS", "images/inventoryimages/zergtab.xml"),
	--Asset( "IMAGE", "images/inventoryimages/larva.tex"),
    --Asset( "ATLAS", "images/inventoryimages/larva.xml"),
	--Asset( "IMAGE", "images/map_icons/minimapicon.tex"),
   -- Asset( "ATLAS", "images/map_icons/minimapicon.xml"),
	Asset( "IMAGE", "images/map_icons/kerriganminimapicon.tex" ),
	Asset( "ATLAS", "images/map_icons/kerriganminimapicon.xml" ),
	--Asset( "IMAGE", "images/map_icons/minimapicon.tex" ),
	--Asset( "ATLAS", "images/map_icons/minimapicon.xml" ),
	Asset("SOUNDPACKAGE", "sound/kerrigan.fev"),
    Asset("SOUND", "sound/kerrigan.fsb"),
	Asset( "ANIM", "anim/kerpunch.zip" ),
}

RemapSoundEvent( "dontstarve/characters/kerrigan/death_voice", "kerrigan/kerrigan/death_voice" )
RemapSoundEvent( "dontstarve/characters/kerrigan/hurt", "kerrigan/kerrigan/hurt" )
RemapSoundEvent( "dontstarve/characters/kerrigan/talk_LP", "kerrigan/kerrigan/talk_LP" )
--[[AddSimPostInit(function(inst)
        if inst.prefab == "ker" then
                larva.atlas=
        end
end)]]

-- strings! Any "KER" below would have to be replaced by the prefab name of your character.

-- The character select screen lines
-- note: these are lower-case character name
GLOBAL.STRINGS.CHARACTER_TITLES.ker = "The Swarm Evolution Master"
GLOBAL.STRINGS.CHARACTER_NAMES.ker = "Abathur"  -- Note! This line is especially important as some parts of the game require
                                            -- the character to have a valid name.
GLOBAL.STRINGS.CHARACTER_DESCRIPTIONS.ker = "Can spawn toxic nests. \nHeals all friendly units. \nAbilities: T for toxic nests, M for mend."
GLOBAL.STRINGS.CHARACTER_QUOTES.ker = "\"Evolution never over.\""



-- You can also add any kind of custom dialogue that you would like. Don't forget to make
-- categores that don't exist yet using = {}
-- note: these are UPPER-CASE charcacter name
GLOBAL.STRINGS.CHARACTERS.KER  = {} --GLOBAL.require "speech_wilson"
GLOBAL.STRINGS.CHARACTERS.KER.DESCRIBE = {}--GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE--{}
GLOBAL.STRINGS.CHARACTERS.KER.DESCRIBE.EVERGREEN = "Biomass."

GLOBAL.STRINGS.CHARACTERS.KER.DESCRIBE.MONSTERMEAT = "Sufficient sequences for my swarm."
GLOBAL.STRINGS.CHARACTERS.KER.DESCRIBE.SPIDER = "Minions of a primitive Swarm."
GLOBAL.STRINGS.CHARACTERS.KER.DESCRIBE.SPIDER_WARRIOR = "Warriors of a primitive Swarm."
GLOBAL.STRINGS.CHARACTERS.KER.DESCRIBE.SPIDERDEN = "A primitive Hive."
GLOBAL.STRINGS.CHARACTERS.KER.DESCRIBE.SPIDERQUEEN = "A primitive Rival."
GLOBAL.STRINGS.CHARACTERS.KER.DESCRIBE.CATCOON = "Awwwwwwwwwwwwwww..."
GLOBAL.STRINGS.NAMES.ZERGLING = "Zergling"
GLOBAL.STRINGS.NAMES.DRONE = "Drone"
GLOBAL.STRINGS.NAMES.KER = "Kerrigan"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.KER = 
{
	GENERIC = "The Queen of Blades!",
	ATTACKER = "Die abomination!",
	MURDERER = "Monster!",
	REVIVER = "Don't consume my essence!",
	GHOST = "Her essence remains.",
}
GLOBAL.STRINGS.CHARACTERS.KER.DESCRIBE.KER = 
{
	GENERIC = "You remind me of Narud...!",
	ATTACKER = "You will join the Swarm!",
	MURDERER = "Petty quarrels.",
	REVIVER = "My essence is eternal!",
	GHOST = "Her essence remains.",
}

GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ZERGLING = "What a foreign creature..."
GLOBAL.STRINGS.CHARACTERS.KER.DESCRIBE.OVERLORD = "Grow my swarm!"
GLOBAL.STRINGS.CHARACTERS.KER.DESCRIBE.DRONE = "Harvest for the swarm!"
GLOBAL.STRINGS.CHARACTERS.KER.DESCRIBE.ZERGLING = "My children..."
GLOBAL.STRINGS.NAMES.LARVA = "Larva"
GLOBAL.STRINGS.NAMES.LARVA_DRONE = "Dronelarva"
GLOBAL.STRINGS.NAMES.LARVA_OVERLORD = "Overlordlarva"
GLOBAL.STRINGS.NAMES.LARVA_HYDRA = "Hydralisklarva"
GLOBAL.STRINGS.NAMES.OVERLORD = "Overlord"
GLOBAL.STRINGS.NAMES.HYDRALISK = "Hydralisk"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.HYDRALISK = "Aliens!"
GLOBAL.STRINGS.CHARACTERS.KER.DESCRIBE.HYDRALISK = "They miss some brainmatter, but it will do."
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.LARVA = "Iiiueeeehh..."
GLOBAL.STRINGS.CHARACTERS.KER.DESCRIBE.LARVA = "Hatch, my Dear!"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.LARVA_DRONE = "Iiiueeeehh..."
GLOBAL.STRINGS.CHARACTERS.KER.DESCRIBE.LARVA_DRONE = "Hatch, my Dear!"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.LARVA_OVERLORD = "Iiiueeeehh..."
GLOBAL.STRINGS.CHARACTERS.KER.DESCRIBE.LARVA_OVERLORD = "Hatch, my Dear!"
GLOBAL.STRINGS.CHARACTERS.KER.BATTLECRY={}
GLOBAL.STRINGS.CHARACTERS.KER.BATTLECRY.SPIDER="For the swarm!"
GLOBAL.STRINGS.CHARACTERS.KER.BATTLECRY.SPIDER_WARRIOR="For the swarm!"
GLOBAL.STRINGS.CHARACTERS.KER.BATTLECRY.SPIDERQUEEN="For the swarm!"
GLOBAL.STRINGS.CHARACTERS.KER.BATTLECRY.GENERIC="A bold move!"
--GLOBAL.STRINGS.ACTIONS.SPAWNZERG="Spawn Zergling"

GLOBAL.ZERGCONFIG={}
GLOBAL.ZERGCONFIG.DRONE_TARGET=GetModConfigData("dronetarget")
GLOBAL.ZERGCONFIG.DRONE_GATHER=GetModConfigData("dronegather")
GLOBAL.ZERGCONFIG.DIFFICULTY=GetModConfigData("difficulty")

-- Let the game know Wod is a male, for proper pronouns during the end-game sequence.
-- Possible genders here are MALE, FEMALE, or ROBOT
--table.insert(GLOBAL.CHARACTER_GENDERS.FEMALE, "ker")


	

--local RECIPETABS = GLOBAL.RECIPETABS
GLOBAL.RECIPETABS['ZERG'] = {str = "ZERG", sort=0, icon = "zergtab.tex", icon_atlas = "images/inventoryimages/zergtab.xml"}
GLOBAL.STRINGS.TABS.ZERG="ZERG"

if GLOBAL.TheSim:GetGameID()=="DST" then 
AddRecipe("larva_drone", 
{Ingredient("meat", 1)}, 
GLOBAL.RECIPETABS.ZERG, GLOBAL.TECH.NONE, nil, nil, nil, nil, "kerrigan","images/inventoryimages/larva_drone.xml")
GLOBAL.STRINGS.RECIPE_DESC.LARVA_DRONE = "Spawn Drone."
AddRecipe("larva_overlord", 
{Ingredient("monstermeat", 4),Ingredient("purplegem", 1) }, 
GLOBAL.RECIPETABS.ZERG, GLOBAL.TECH.NONE, nil, nil, nil, nil, "kerrigan","images/inventoryimages/larva_overlord.xml")
GLOBAL.STRINGS.RECIPE_DESC.LARVA_OVERLORD = "Spawn Overlord."
AddRecipe("larva", 
{Ingredient("monstermeat", 1)}, 
GLOBAL.RECIPETABS.ZERG, GLOBAL.TECH.NONE, nil, nil, nil, nil, "kerrigan","images/inventoryimages/larva.xml")
GLOBAL.STRINGS.RECIPE_DESC.LARVA = "Spawn Zerglings."
AddRecipe("larva_hydra", 
{Ingredient("stinger", 5),Ingredient("monstermeat", 4)}, 
GLOBAL.RECIPETABS.ZERG, GLOBAL.TECH.NONE, nil, nil, nil, nil, "kerrigan","images/inventoryimages/larva_hydra.xml")
GLOBAL.STRINGS.RECIPE_DESC.LARVA_HYDRA = "Spawn Hydralisk."
else 
--DS
AddPrefabPostInit("ker",function(ker)

if ker.components and ker.components.leader and ker.components.leader.RemoveLandFollowers then 
ker.components.leader.RemoveLandFollowers =
function() 
 for k,v in pairs(ker.components.leader.followers) do
        if not k:HasTag("aquatic") and not k:HasTag("amphibious") and not k:HasTag("zerg")  then
            ker.components.leader:RemoveFollower(k)
        end
    end
end 
end 

                        local larva_recipe = Recipe("larva", {Ingredient("monstermeat", 1)}, GLOBAL.RECIPETABS.ZERG, GLOBAL.TECH.NONE)
	                    larva_recipe.sortkey = 3
	                    larva_recipe.atlas="images/inventoryimages/larva.xml"  
                        GLOBAL.STRINGS.RECIPE_DESC.LARVA = "Spawn Zerglings.."
						
						local larva_recipe = Recipe("larva_drone", {Ingredient("meat", 1)}, GLOBAL.RECIPETABS.ZERG, GLOBAL.TECH.NONE)
	                    larva_recipe.sortkey = 1
	                    larva_recipe.atlas="images/inventoryimages/larva_drone.xml"  
                        GLOBAL.STRINGS.RECIPE_DESC.LARVA_DRONE = "Spawn Drone."

						local larva_recipe = Recipe("larva_hydra", {Ingredient("stinger", 5)}, GLOBAL.RECIPETABS.ZERG, GLOBAL.TECH.NONE)
	                    larva_recipe.sortkey = 4
	                    larva_recipe.atlas="images/inventoryimages/larva_hydra.xml"  
                        GLOBAL.STRINGS.RECIPE_DESC.LARVA_HYDRA = "Spawn Hydralisk."


						local overlord_recipe = Recipe("larva_overlord", {Ingredient("monstermeat", 4),Ingredient("purplegem", 1) }, GLOBAL.RECIPETABS.ZERG, GLOBAL.TECH.NONE)
	                    overlord_recipe.sortkey = 2
	                    overlord_recipe.atlas="images/inventoryimages/larva_overlord.xml"
	                    --overlord_recipe.image="overlord.tex"				
                        GLOBAL.STRINGS.RECIPE_DESC.LARVA_OVERLORD = "Spawn Overlord"

					   end)
end

local attackorder = GetModConfigData("attackorder")
local hotkey
if attackorder=="R" then hotkey=GLOBAL.KEY_R end
if attackorder=="T" then hotkey=GLOBAL.KEY_T end
if attackorder=="Y" then hotkey=GLOBAL.KEY_Y end
if attackorder=="U" then hotkey=GLOBAL.KEY_U end
if attackorder=="G" then hotkey=GLOBAL.KEY_G end
if attackorder=="H" then hotkey=GLOBAL.KEY_H end
if attackorder=="J" then hotkey=GLOBAL.KEY_J end
if attackorder=="Z" then hotkey=GLOBAL.KEY_Z end
if attackorder=="X" then hotkey=GLOBAL.KEY_X end
if attackorder=="C" then hotkey=GLOBAL.KEY_C end
if attackorder=="V" then hotkey=GLOBAL.KEY_V end
if attackorder=="B" then hotkey=GLOBAL.KEY_B end
if attackorder=="N" then hotkey=GLOBAL.KEY_N end


local stopattackorder = GetModConfigData("stopattackorder")
local stophotkey
if stopattackorder=="R" then stophotkey=GLOBAL.KEY_R end
if stopattackorder=="T" then stophotkey=GLOBAL.KEY_T end
if stopattackorder=="Y" then stophotkey=GLOBAL.KEY_Y end
if stopattackorder=="U" then stophotkey=GLOBAL.KEY_U end
if stopattackorder=="G" then stophotkey=GLOBAL.KEY_G end
if stopattackorder=="H" then stophotkey=GLOBAL.KEY_H end
if stopattackorder=="J" then stophotkey=GLOBAL.KEY_J end
if stopattackorder=="Z" then stophotkey=GLOBAL.KEY_Z end
if stopattackorder=="X" then stophotkey=GLOBAL.KEY_X end
if stopattackorder=="C" then stophotkey=GLOBAL.KEY_C end
if stopattackorder=="V" then stophotkey=GLOBAL.KEY_V end
if stopattackorder=="B" then stophotkey=GLOBAL.KEY_B end
if stopattackorder=="N" then stophotkey=GLOBAL.KEY_N end
--[[if hotkey then
GLOBAL.TheInput:AddKeyDownHandler(hotkey, function()
local player=GLOBAL.ThePlayer
if player and player.prefab=="ker" then
local target = GLOBAL.TheInput:GetWorldEntityUnderMouse()
if target then
 print("sharing target")
    player.components.combat:ShareTarget(target, 20, function(dude) print(dude.prefab)
        return dude:HasTag("zergling")
               and not dude.components.health:IsDead()
               and dude.components.follower
               and dude.components.follower.leader == player
               and not(dude.components.follower.leader == target)
    end, 10)
	 player.components.talker:Say("Destroy them!", 2.5,true)
else player.components.talker:Say("Unacceptable command!", 2.5,true)
end

end 
end
)
end]]

local function ShareSwarmTarget(player,target)
	local num_helpers=0
	for k,v in pairs(player.components.leader.followers) do
        if  (k.prefab=="zergling" or k.prefab=="hydralisk")
			and not (k.components.health ~= nil and
                     k.components.health:IsDead())	
			and k.components.combat.target==nil
            and k.components.combat:CanTarget(target)
            then
			if k.prefab=="zergling" then 
			k.components.combat:SuggestTarget(target)
			num_helpers = num_helpers + 1
			elseif k.prefab=="hydralisk" and not (k.hydratarget and k.hydratarget~=nil) then 
			--k.SuggestHydraTarget(k,target)
			--k.hydratarget=target
			--k:DoTaskInTime(5,function(inst) if k.hydratarget and k.hydratarget~=nil then inst.components.combat:SuggestTarget(inst.hydratarget) end k.hydratarget=nil end)
			k.components.combat:SuggestTarget(target)
			num_helpers = num_helpers + 1
			end
            if num_helpers >= 5 then
                break
            end
        end
    end
 
	if math.random()<0.05 then player.SoundEmitter:PlaySound("kerrigan/kerrigan/attackorder")
	else 
	player.components.talker:Say("Destroy them!", 2.5,true,nil,nil,{ 150 / 255, 0/ 255, 200 / 255, 1 }) --{ r / 255, g / 255, b / 255, 1 }
	end
	end


local function StopSwarmTarget(player)

      for k,v in pairs(player.components.leader.followers) do
	  if k.components.combat then 
	  k.components.combat.target=nil
	  if k.hydratarget then k.hydratarget=nil end
	  end
	  end
	 player.components.talker:Say("Spare them!", 2.5,true,nil,nil,{ 0 / 255, 200 / 255, 0 / 255, 1 }) --{ r / 255, g / 255, b / 255, 1 }

	 end
	 
if GLOBAL.TheSim:GetGameID()=="DST" then 
AddModRPCHandler(modname, "ShareSwarmTarget", ShareSwarmTarget)
AddModRPCHandler(modname, "StopSwarmTarget", StopSwarmTarget)
end

if hotkey then
GLOBAL.TheInput:AddKeyDownHandler(hotkey, function()
local player
if GLOBAL.TheSim:GetGameID()=="DST" then  player=GLOBAL.ThePlayer else player=GLOBAL.GetPlayer() end
if player and player.prefab=="ker" 
	and not GLOBAL.IsPaused() and not GLOBAL.TheInput:IsKeyDown(GLOBAL.KEY_CTRL) and not GLOBAL.TheInput:IsKeyDown(GLOBAL.KEY_SHIFT)
	and not(GLOBAL.TheSim:GetGameID()=="DST" and (player.HUD:IsChatInputScreenOpen() or player.HUD:IsConsoleScreenOpen())) then
local target = GLOBAL.TheInput:GetWorldEntityUnderMouse()
if target and target~=player then
    if GLOBAL.TheSim:GetGameID()=="DST" then 
    SendModRPCToServer(MOD_RPC[modname]["ShareSwarmTarget"],target)
	else
	--DS
	ShareSwarmTarget(player,target)
	end
else player.components.talker:Say("Unacceptable command!", 2.5,true)
end

end 
end
)
end

if stophotkey then
GLOBAL.TheInput:AddKeyDownHandler(stophotkey, function()
local player
if GLOBAL.TheSim:GetGameID()=="DST" then  player=GLOBAL.ThePlayer else player=GLOBAL.GetPlayer() end
if player and player.prefab=="ker" 
	and not GLOBAL.IsPaused() and not GLOBAL.TheInput:IsKeyDown(GLOBAL.KEY_CTRL) and not GLOBAL.TheInput:IsKeyDown(GLOBAL.KEY_SHIFT)
	and not(GLOBAL.TheSim:GetGameID()=="DST" and (player.HUD:IsChatInputScreenOpen() or player.HUD:IsConsoleScreenOpen())) then
	if GLOBAL.TheSim:GetGameID()=="DST" then 
    SendModRPCToServer(MOD_RPC[modname]["StopSwarmTarget"])
	else
	--DS
	StopSwarmTarget(player)
	end
end 
end
)
end
--[[AddPrefabPostInit("ker",function(ker)
                        local larva_recipe = Recipe("larva", {Ingredient("monstermeat", 1)}, GLOBAL.RECIPETABS.ZERG, GLOBAL.TECH.NONE)
	                    larva_recipe.sortkey = 3
	                    larva_recipe.atlas="images/inventoryimages/larva.xml"  
                        GLOBAL.STRINGS.RECIPE_DESC.LARVA = "Spawn the Swarm."
						
						local larva_recipe = Recipe("larva_drone", {Ingredient("meat", 1)}, GLOBAL.RECIPETABS.ZERG, GLOBAL.TECH.NONE)
	                    larva_recipe.sortkey = 1
	                    larva_recipe.atlas="images/inventoryimages/larva_drone.xml"  
                        GLOBAL.STRINGS.RECIPE_DESC.LARVA_DRONE = "Spawn Drone."


						local overlord_recipe = Recipe("overlord", {Ingredient("monstermeat", 4),Ingredient("purplegem", 1) }, GLOBAL.RECIPETABS.ZERG, GLOBAL.TECH.NONE)
	                    overlord_recipe.sortkey = 2
	                    overlord_recipe.atlas="images/inventoryimages/overlord.xml"
	                    overlord_recipe.image="overlord.tex"				
                        GLOBAL.STRINGS.RECIPE_DESC.OVERLORD = "Spawn Overlord"
                    
					    

                        						
					   --print(GLOBAL.RECIPETABS)
					   end)]]
--[[AddPrefabPostInit("zergling",function(minion) if minion.components.swarmmind and minion.components.follower and minion.components.follower.leader 
                                            then minion.components.swarmmind:UpdateSanity(minion.components.follower.leader) end 
							end)]]
--[[AddPrefabPostInit("overlord",function(minion) 
                                            if minion.components.follower and not minion.components.follower.leader then player=FindEntity(minion, 5, function(minion) return  end) if player then print("posinitoverlord2") player.components.leader:AddFollower(minion) end else print("wtf") end 
                                            if minion.components.swarmmind and minion.components.follower and minion.components.follower.leader 
                                            then minion.components.swarmmind:UpdateSanity(minion.components.follower.leader) end 
							end)]]
--[[
AddPrefabPostInit("drone",function(minion) if minion.components.swarmmind and minion.components.follower and minion.components.follower.leader 
                                         then minion.components.swarmmind:UpdateSanity(minion.components.follower.leader) end 
							end)
							
		]]					
--AddMinimapAtlas("images/map_icons/minimapicon.xml")
AddMinimapAtlas("images/map_icons/kerriganminimapicon.xml")

--if act.target.components.combat.target==act.doer then print("target=doer") else print("no") end
--print(act.target.components.combat.target)



--[[GLOBAL.TheInput:AddKeyDownHandler(GLOBAL.KEY_R, function()
	local player = GLOBAL.GetPlayer()
	
	if player and player.prefab=="ker" then
	
		local TheInput = GLOBAL.TheInput

	if not GLOBAL.IsPaused() and not TheInput:IsKeyDown(GLOBAL.KEY_CTRL) and not TheInput:IsKeyDown(GLOBAL.KEY_SHIFT) then
	player:PushEvent("startfreezing")
  player.task = player:DoPeriodicTask(1, function(inst)
									inst.components.health:DoDelta(-2, false, "cold")
									end)


  
	end
	end
end)]]
AddModCharacter("ker","FEMALE")

--local Action = GLOBAL.Action
local SPAWNZERG= GLOBAL.Action(1,true,true)
SPAWNZERG.id="SPAWNZERG"
SPAWNZERG.str = "Spawn"
SPAWNZERG.fn= function(act)
    act.invobject.components.spawnable:Spawn(act)
	
	return true
end
AddAction(SPAWNZERG)

if GLOBAL.TheSim:GetGameID()=="DST" then 
AddComponentAction("INVENTORY", "spawnable", function(inst, doer, actions, right) table.insert(actions, GLOBAL.ACTIONS.SPAWNZERG)end)
end

--if GLOBAL.TheSim:GetGameID()=="DST" then 
local ACTIONS=GLOBAL.ACTIONS
if GetModConfigData("custompunch")==1 then
AddStategraphPostInit("wilson",function(stateself) 
  --local inst=stateself.inst
  --if inst.prefab=="ker" then
  if GLOBAL.TheSim:GetGameID()=="DST" then 
  local actionfn=stateself.actionhandlers[ACTIONS.ATTACK].deststate
  local customhandlerfn=
        function(inst, action)
            inst.sg.mem.localchainattack = not action.forced or nil
            if not inst.components.health:IsDead() and not inst.sg:HasStateTag("attack") then
                local equip = inst.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS)
                if inst.prefab=="ker" and not equip then
					return "kerpunch"
				else
                    return actionfn(inst,action)
                end
            end
        end
	stateself.actionhandlers[ACTIONS.ATTACK].deststate=customhandlerfn
  else
  local eventfn=stateself.events["doattack"].fn
    local customhandlerfn=
        function(inst) 
            if not inst.components.health:IsDead() and not inst.sg:HasStateTag("attack") then
                local equip = inst.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS)
                if inst.prefab=="ker" and not equip then
					inst.sg:GoToState("kerpunch")
				else
                    return eventfn(inst)
                end
            end
        end
	stateself.events["doattack"].fn=customhandlerfn
  end
  local state
  if GLOBAL.TheSim:GetGameID()=="DST" then 
	state=GLOBAL.State{
        name = "kerpunch",
        tags = { "attack", "notalking", "abouttoattack", "autopredict" },

        onenter = function(inst)
            local buffaction = inst:GetBufferedAction()
            local target = buffaction ~= nil and buffaction.target or nil
            local equip = inst.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS)
            inst.components.combat:SetTarget(target)
            inst.components.combat:StartAttack()
            inst.components.locomotor:Stop()
            local cooldown = inst.components.combat.min_attack_period + .5 * GLOBAL.FRAMES
            if not equip then
			    if inst.prefab=="ker" then
                inst.AnimState:SetBuild("kerpunch")
				inst.AnimState:PlayAnimation("kerpunch")
				else
			    inst.AnimState:PlayAnimation("punch")
				end
				--inst.AnimState:PushAnimation("atk", false)
                --inst.AnimState:PlayAnimation("punch")
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_whoosh", nil, nil, true)
                cooldown = math.max(cooldown, 24 * GLOBAL.FRAMES)
            end

            inst.sg:SetTimeout(cooldown)

            if target ~= nil then
                inst.components.combat:BattleCry()
                if target:IsValid() then
                    inst:FacePoint(target:GetPosition())
                    inst.sg.statemem.attacktarget = target
                end
            end
        end,

        timeline =
        {
            GLOBAL.TimeEvent(8 * GLOBAL.FRAMES, function(inst)
                inst:PerformBufferedAction()
                inst.sg:RemoveStateTag("abouttoattack")
            end),
        },

        ontimeout = function(inst)
            inst.sg:RemoveStateTag("attack")
            inst.sg:AddStateTag("idle")
        end,

       events =
        {
            GLOBAL.EventHandler("equip", function(inst)  inst.sg:GoToState("idle") end),
            GLOBAL.EventHandler("unequip", function(inst)   inst.sg:GoToState("idle") end),
            GLOBAL.EventHandler("animqueueover", function(inst) 
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
		    if inst.prefab=="ker" then
				inst.AnimState:SetBuild("ker")
				end
            inst.components.combat:SetTarget(nil)
            if inst.sg:HasStateTag("abouttoattack") then
                inst.components.combat:CancelAttack()
            end
        end,
    }
	else
	state=GLOBAL.State{
        name = "kerpunch",
        tags = {"attack", "notalking", "abouttoattack", "busy"},
        
        onenter = function(inst)
			--print(debugstack())

            local weapon = inst.components.combat:GetWeapon()
            local otherequipped = inst.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS)

            if (weapon and weapon:HasTag("gun")) or (otherequipped and otherequipped:HasTag("gun")) then
                inst.sg:GoToState("shoot")
                return
            end

            if weapon then
                inst.AnimState:PlayAnimation("atk")
				if weapon:HasTag("icestaff") then
                    inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_icestaff")
				elseif weapon:HasTag("shadow") then
                    inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_nightsword")
                elseif weapon:HasTag("firestaff") then
                    inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_firestaff")
                else
                    inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
                end
            elseif otherequipped and (otherequipped:HasTag("light") or otherequipped:HasTag("nopunch")) then
                inst.AnimState:PlayAnimation("atk")
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
            else
				inst.sg.statemem.slow = true
                if inst.prefab=="ker" then
                inst.AnimState:SetBuild("kerpunch")
				inst.AnimState:PlayAnimation("kerpunch")
				else
			    inst.AnimState:PlayAnimation("punch")
				end
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_whoosh")
            end
            
            if inst.components.combat.target then
                inst.components.combat:BattleCry()
                if inst.components.combat.target and inst.components.combat.target:IsValid() then
                    inst:FacePoint(Point(inst.components.combat.target.Transform:GetWorldPosition()))
                end
            end

            inst.sg.statemem.target = inst.components.combat.target
            inst.components.combat:StartAttack()
            inst.components.locomotor:Stop()
            
        end,
        
        timeline=
        {
            GLOBAL.TimeEvent(8*GLOBAL.FRAMES, function(inst) inst.components.combat:DoAttack(inst.sg.statemem.target) inst.sg:RemoveStateTag("abouttoattack") end),
            GLOBAL.TimeEvent(12*GLOBAL.FRAMES, function(inst) 
				inst.sg:RemoveStateTag("busy")
			end),				
            GLOBAL.TimeEvent(13*GLOBAL.FRAMES, function(inst)
				if not inst.sg.statemem.slow then
					inst.sg:RemoveStateTag("attack")
				end
            end),
            GLOBAL.TimeEvent(24*GLOBAL.FRAMES, function(inst)
				if inst.sg.statemem.slow then
					inst.sg:RemoveStateTag("attack")
				end
            end),
            
            
        },
        
        events=
        {
            GLOBAL.EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end ),
        },
		onexit = function(inst)
		    if inst.prefab=="ker" then
				inst.AnimState:SetBuild("ker")
				end
        end
    }
	end

--inst.sg
--GLOBAL.assert( state:is_a(GLOBAL.State),"Non-state added in state table!")
stateself.states["kerpunch"]=state
--end
end)
end

if GLOBAL.TheSim:GetGameID()=="DST" then 
if GetModConfigData("custompunch")==1 then
AddStategraphPostInit("wilson_client",function(stateself) 
  --local inst=stateself.inst
  --if inst.prefab=="ker" then
  local actionfn=stateself.actionhandlers[ACTIONS.ATTACK].deststate
  local customhandlerfn=function(inst)
            if not (inst.replica.health:IsDead() or inst.sg:HasStateTag("attack")) then
                local equip = inst.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS)
                if inst.prefab=="ker" and not equip  then
                   return "kerpunch"
                end
                return actionfn(inst)
            end
        end
	stateself.actionhandlers[ACTIONS.ATTACK].deststate=customhandlerfn
  
  
  local state=GLOBAL.State{
        name = "kerpunch",
        tags = { "attack", "notalking", "abouttoattack" },

        onenter = function(inst)
            local cooldown = 0
            if inst.replica.combat ~= nil then
                inst.replica.combat:StartAttack()
                cooldown = inst.replica.combat:MinAttackPeriod() + .5 * GLOBAL.FRAMES
            end
            inst.components.locomotor:Stop()
            local equip = inst.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS)
            if not equip then
			    if inst.prefab=="ker" then
                inst.AnimState:SetBuild("kerpunch")
				inst.AnimState:PlayAnimation("kerpunch")
				else
			    inst.AnimState:PlayAnimation("punch")
				end
                --inst.AnimState:PlayAnimation("punch")
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_whoosh", nil, nil, true)
                if cooldown > 0 then
                    cooldown = math.max(cooldown, 24 * GLOBAL.FRAMES)
                end
            end

            local buffaction = inst:GetBufferedAction()
            if buffaction ~= nil then
                inst:PerformPreviewBufferedAction()

                if buffaction.target ~= nil and buffaction.target:IsValid() then
                    inst:FacePoint(buffaction.target:GetPosition())
                    inst.sg.statemem.attacktarget = buffaction.target
                end
            end

            if cooldown > 0 then
                inst.sg:SetTimeout(cooldown)
            end
        end,

        timeline =
        {
            GLOBAL.TimeEvent(8 * GLOBAL.FRAMES, function(inst)
                inst:ClearBufferedAction()
                inst.sg:RemoveStateTag("abouttoattack")
            end),
        },

        ontimeout = function(inst)
            inst.sg:RemoveStateTag("attack")
            inst.sg:AddStateTag("idle")
        end,

        events =
        {
            GLOBAL.EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
		if inst.prefab=="ker" then
				inst.AnimState:SetBuild("ker")
				end
            if inst.sg:HasStateTag("abouttoattack") and inst.replica.combat ~= nil then
                inst.replica.combat:CancelAttack()
            end
        end,
    }

--inst.sg
stateself.states["kerpunch"]=state
--end
end)
end
end

AddPrefabPostInit("catcoon",function(cat) 
if GLOBAL.TheSim:GetGameID()=="DS" or GLOBAL.TheWorld.ismastersim then
if cat.components and cat.components.combat and cat.components.combat.targetfn then 
local oldfn=cat.components.combat.targetfn
cat.components.combat.targetfn=function(inst)
local target = oldfn(inst)
if target and not target:HasTag("zerg") then return target end
end
end
end
end)

--[[
local function SpawnSpider(player)
    local pos = GLOBAL.Vector3(player.Transform:GetWorldPosition())
    local offset = (GLOBAL.FindWalkableOffset(pos,math.random()*GLOBAL.PI*2,0.5,false))
    if offset == nil then
          if  player.components.talker then
          player.components.talker:Say("No Space!", 2.5)
          end
          return
    end
    pos=pos+offset
    local unit=GLOBAL.SpawnPrefab("hydralisk")
    unit.Transform:SetPosition(pos:Get())
    player.components.leader:AddFollower(unit) 
end
AddModRPCHandler(modname, "SpawnSpider", SpawnSpider)
 
GLOBAL.TheInput:AddKeyDownHandler(GLOBAL.KEY_X, function()
local player=GLOBAL.ThePlayer
if player and player.prefab=="ker"
    and not GLOBAL.IsPaused() and not GLOBAL.TheInput:IsKeyDown(GLOBAL.KEY_CTRL) and not GLOBAL.TheInput:IsKeyDown(GLOBAL.KEY_SHIFT)
    and not player.HUD:IsChatInputScreenOpen() and not player.HUD:IsConsoleScreenOpen()then
    SendModRPCToServer(MOD_RPC[modname]["SpawnSpider"])
end
end
)]]
