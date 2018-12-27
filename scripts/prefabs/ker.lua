
local MakePlayerCharacter = require "prefabs/player_common"


local assets = {

        Asset( "ANIM", "anim/player_basic.zip" ),
        Asset( "ANIM", "anim/player_idles_shiver.zip" ),
        Asset( "ANIM", "anim/player_actions.zip" ),
        Asset( "ANIM", "anim/player_actions_axe.zip" ),
        Asset( "ANIM", "anim/player_actions_pickaxe.zip" ),
        Asset( "ANIM", "anim/player_actions_shovel.zip" ),
        Asset( "ANIM", "anim/player_actions_blowdart.zip" ),
        Asset( "ANIM", "anim/player_actions_eat.zip" ),
        Asset( "ANIM", "anim/player_actions_item.zip" ),
        Asset( "ANIM", "anim/player_actions_uniqueitem.zip" ),
        Asset( "ANIM", "anim/player_actions_bugnet.zip" ),
        Asset( "ANIM", "anim/player_actions_fishing.zip" ),
        Asset( "ANIM", "anim/player_actions_boomerang.zip" ),
        Asset( "ANIM", "anim/player_bush_hat.zip" ),
        Asset( "ANIM", "anim/player_attacks.zip" ),
        Asset( "ANIM", "anim/player_idles.zip" ),
        Asset( "ANIM", "anim/player_rebirth.zip" ),
        Asset( "ANIM", "anim/player_jump.zip" ),
        Asset( "ANIM", "anim/player_amulet_resurrect.zip" ),
        Asset( "ANIM", "anim/player_teleport.zip" ),
        Asset( "ANIM", "anim/wilson_fx.zip" ),
        Asset( "ANIM", "anim/player_one_man_band.zip" ),
        Asset( "ANIM", "anim/shadow_hands.zip" ),
        Asset( "SOUND", "sound/sfx.fsb" ),
		--Asset( "SOUND", "DLC0001/sound/wathgrithr.fsb" ),
        Asset( "ANIM", "anim/beard.zip" ),
		Asset( "ANIM", "anim/ker.zip" ),

		-- Don't forget to include your character's custom assets!
        
		Asset( "ANIM", "anim/ghost_ker_build.zip" ),
		Asset( "IMAGE", "images/inventoryimages/larva.tex"),
        Asset( "ATLAS", "images/inventoryimages/larva.xml"),
		Asset( "ATLAS", "images/avatars/avatar_ker.xml"),
		Asset( "ATLAS", "images/avatars/avatar_ghost_ker.xml"),

}

local prefabs=
{
	"larva",
	"larva_drone",
	"larva_overlord",
	"purplegem",
	"monstermeat",
}

local start_inv =
{
    "larva",
	"larva",
	"larva_drone",
	"purplegem",
	--"larva_overlord",

}
 
 local function OnAttacked(inst, data)
	local target=data.attacker
	for k,v in pairs(inst.components.leader.followers) do
        if  (k.prefab=="zergling" or k.prefab=="hydralisk")
			and not (k.components.health ~= nil and
                     k.components.health:IsDead())	
			and k.components.combat.target==nil
            and k.components.combat:CanTarget(target)
            then
			if k.prefab=="zergling" then 
			k.components.combat:SuggestTarget(target)
			elseif k.prefab=="hydralisk" and not (k.hydratarget and k.hydratarget~=nil) then 
			--k.SuggestHydraTarget(k,target)
			--k.hydratarget=target
			--k:DoTaskInTime(5,function(inst) if k.hydratarget and k.hydratarget~=nil then inst.components.combat:SuggestTarget(inst.hydratarget) end k.hydratarget=nil end)
			k.components.combat:SuggestTarget(target)
			end
        end
    end
end



local function common_init(inst)
	inst.soundsname = "kerrigan"

	--inst.talker_path_override = "dontstarve_DLC001/characters/"

	inst.MiniMapEntity:SetIcon( "kerriganminimapicon.tex" )

	inst:AddTag("zerg")
	inst:AddTag("kerrigan")
	

	
end

local function OnDespawn(inst)
if inst.components.leader and inst.components.leader.followers then
    --inst.components.sanity.penalty=inst.components.leader.numfollowers*5

	local swarm={}
	local i=0
	for k,v in pairs(inst.components.leader.followers) do
	  
		i=i+1
	    if k:HasTag("zerg") then
		  
			if k.prefab=="overlord" then k.components.container:Close() --k.components.container:DropEverything()
			end
			--table.insert(swarm, k.prefab)--:GetSaveRecord())
			swarm[i] = k:GetSaveRecord()
			k:Remove()
	    end
	
    end

	inst.swarm=swarm
end
end

local function OnSave(inst, data)

if not inst.swarm and inst.components.leader.numfollowers>0 then  
   local swarm={}
	local i=0
   for k,v in pairs(inst.components.leader.followers) do
	    --print(k)
		i=i+1
	    if k:HasTag("zerg") then
		  
			if k.prefab=="overlord" then k.components.container:Close() --k.components.container:DropEverything()
			end
			--table.insert(swarm, k.prefab)--:GetSaveRecord())
			swarm[i] = k:GetSaveRecord()
			--print(k.prefab.." removed")
			--k:Remove()
	    end
	
    end
	if swarm then 
	data.swarm = swarm 
	--inst:DoTaskInTime(0,function(inst) print("loadtaskintime") inst.OnLoad(inst,inst) inst.swarm=nil end)
	end
end

if inst.swarm then
   data.swarm=inst.swarm
   end
end

local function WreckedOnSave(inst, data)
if inst.swarm then
data.swarm=inst.swarm
end
end


local function OnLoad(inst, data)

    --inst.components.sanity.penalty=inst.components.leader.numfollowers*5
	local swarm=data.swarm
	--print(#swarm)
	if swarm then
	local pos = Vector3(inst.Transform:GetWorldPosition())
	local radius= 10
	local offset =Vector3(radius,0,0)
	if IsDLCEnabled(CAPY_DLC) then  
	local angletmp=0
	local function IsWater(p)
	    local tile = GetVisualTileType(p.x, p.y, p.z)
		if tile ~= GROUND.OCEAN_SHALLOW and tile ~= GROUND.OCEAN_MEDIUM and tile ~= GROUND.OCEAN_DEEP and
        tile ~= GROUND.OCEAN_CORAL and tile ~= GROUND.MANGROVE and tile ~= GROUND.OCEAN_SHIPGRAVEYARD then
            return false
        end
		return true
	end
	local function IsGround(p)
	    local tile = GetVisualTileType(p.x, p.y, p.z)
        if tile == GROUND.IMPASSABLE or tile == GROUND.OCEAN_SHORE or tile >= GROUND.UNDERGROUND or
        tile == GROUND.OCEAN_SHALLOW or tile == GROUND.OCEAN_MEDIUM or tile == GROUND.OCEAN_DEEP or
        tile == GROUND.OCEAN_CORAL or tile == GROUND.MANGROVE or tile == GROUND.OCEAN_CORAL_SHORE or
        tile == GROUND.MANGROVE_SHORE or tile == GROUND.OCEAN_SHIPGRAVEYARD then
            --print("\tfailed, unwalkable ground.")
            return false
        end
		return true
	end
	local check_angle=0
	while not IsWater(pos+offset) and check_angle<2*PI do
	offset=Vector3(radius * math.cos( check_angle ), 0, -radius * math.sin( check_angle ))
	check_angle=check_angle+2*PI/100
	end
	while not IsGround(pos+offset) and check_angle<4*PI do
	offset=Vector3(radius * math.cos( check_angle ), 0, -radius * math.sin( check_angle ))
	check_angle=check_angle+2*PI/100
	end
	angletmp=check_angle
	while IsGround(pos+offset) and check_angle<6*PI do
	offset=Vector3(radius * math.cos( check_angle ), 0, -radius * math.sin( check_angle ))
	check_angle=check_angle+2*PI/100
	end
	check_angle=angletmp+(check_angle-angletmp)/2
	offset=Vector3(radius * math.cos( check_angle ), 0, -radius * math.sin( check_angle ))
	pos=pos+offset
    end
	
	for k,v in pairs(swarm) do
            
			local unit=SpawnSaveRecord(v)
			inst.components.leader:AddFollower(unit)
			unit.persists=false
		    if IsDLCEnabled(CAPY_DLC) then  
			 unit.persists=true
			 --[[
			 local pos = Vector3(inst.Transform:GetWorldPosition())
		     local offset = (FindGroundOffset(pos,math.random()*PI*2,math.random(0.5, math.min(maxoffset,30) ),36))
			 local tries = 0
			 while (offset==Vector3(0,0,0) or unit:GetIsOnWater(pos.x+offset.x, pos.y+offset.y, pos.z+offset.z)) and tries<30 do maxoffset=maxoffset+0.5 offset = (FindGroundOffset(pos,math.random()*PI*2,math.random(1, math.min(maxoffset,30)),36))  tries=tries+1 end
			 ]]
		     inst.SoundEmitter:PlaySound("overlord/spawn/spawn")
		     unit.Transform:SetPosition(pos:Get())
			end
	    
    end
	inst.components.swarmmind:UpdateSanity(inst)
	end
	
    --inst.swarm=nil
end

local NYDUSPERIOD = ZERGCONFIG.DIFFICULTY>1 and 7 or 14

local function SpawnNydus(inst)
inst.SoundEmitter:PlaySound("dontstarve/creatures/worm/distant")
local age
if TheSim:GetGameID()=="DST" then
age=inst.components.age:GetAgeInDays()
else 
age=GetClock().numcycles
end
    local pos=Vector3(inst.Transform:GetWorldPosition())
    local theta = math.random() * 2 * PI
    local radius = 30
	local offset = FindWalkableOffset(pos, theta, radius, 12, true)
	if offset then
		pos=pos+offset
	end
	for i=1,math.floor(age/NYDUSPERIOD)+4 do
	local unit=SpawnPrefab("zergling")
	unit.Transform:SetPosition(pos:Get())  
	end
end

local function NydusAttack(inst,delay)
local age
if TheSim:GetGameID()=="DST" then
age=inst.components.age:GetAgeInDays()
else 
age=GetClock().numcycles
end
print(age)
delay=delay~=nil and delay or (NYDUSPERIOD-(age%NYDUSPERIOD))
inst:DoTaskInTime(delay*TUNING.TOTAL_DAY_TIME, function(inst) SpawnNydus(inst) NydusAttack(inst,1) end)
end

local function master_init(inst)
	
	inst:AddComponent("swarmmind")
	
	inst.components.sanity:SetMax(100)
	inst.components.health:SetMaxHealth(150) 
	inst.components.combat.defaultdamage =60
	--inst.components.combat.min_attack_period=0.1
	if ZERGCONFIG.DIFFICULTY>1 then 
	inst.components.hunger:SetMax(200)
	inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE*1,6)
	else
	inst.components.hunger:SetMax(300)
	inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE*1,3)
	end
	
	--inst.components.locomotor.walkspeed = TUNING.WILSON_WALK_SPEED*1.3
	inst.components.locomotor.runspeed = TUNING.WILSON_RUN_SPEED*1.3
	--inst:ListenForEvent("locomote", function(inst)
--[[	local larva_recipe = Recipe("larva", {Ingredient("monstermeat", 1)}, RECIPETABS.ZERG, TECH.NONE)
	larva_recipe.sortkey = 1
	larva_recipe.atlas="images/inventoryimages/larva.xml"
	STRINGS.RECIPE_DESC.LARVA = "Spawn the Swarm."]]
	if TheSim:GetGameID()=="DST" then 
	inst.OnDespawn = OnDespawn
	inst.OnSave = OnSave
    inst.OnLoad = OnLoad
    else
	inst:DoTaskInTime(0, function(inst) inst.components.swarmmind:UpdateSanity(inst) end)
	end
	
	if IsDLCEnabled(CAPY_DLC) then 
	inst.OnSave= WreckedOnSave 
	inst.OnLoad = OnLoad
	end
	
	inst:ListenForEvent("mountboat", function(inst) OnDespawn(inst) end)
	
	inst:ListenForEvent("dismountboat",  
	 function(inst)  
	     inst:DoTaskInTime(1, 
		                     function(inst) 
							                if inst.swarm then local stuff = {} stuff.swarm = inst.swarm OnLoad(inst, stuff) 
											end 
											inst.swarm = nil
							end
						) 
	 end)
	
	if TheSim:GetGameID()=="DST" then 
    inst:WatchWorldState("isfullmoon", function(inst) inst.components.talker:Say({Line("This radiation may help my overlords grow!",4,true),Line("A lot of monstermeat should do as biomass!",4,true)}, 2.5,true,nil,nil,{ 150 / 255, 0/ 255, 200 / 255, 1 }) end)
	else
	inst:ListenForEvent("nighttime", function() if GetClock():GetMoonPhase() == "full" then  inst.components.talker:Say({Line("This radiation may help my overlords grow!",4,true),Line("A lot of monstermeat should do as biomass!",4,true)}, 2.5,true,nil,nil,{ 150 / 255, 0/ 255, 200 / 255, 1 }) end end, GetWorld())
	end
	inst:ListenForEvent("attacked", OnAttacked)
	if TheSim:GetGameID()=="DST" then 
	inst:ListenForEvent("entity_death", function() inst.components.swarmmind:UpdateSanity(inst) end,TheWorld)
	else
	inst:ListenForEvent("entity_death", function() inst.components.swarmmind:UpdateSanity(inst) end,GetWorld())
	end

	--DS inventory doesnt have this function yet
	if TheSim:GetGameID()=="DS" and not inst.components.inventory.CanAcceptCount then --DS
	inst.components.inventory.CanAcceptCount = 
	function(self,item, maxcount)
    local stacksize = math.max(maxcount or 0, item.components.stackable ~= nil and item.components.stackable.stacksize or 1)
    if stacksize <= 0 then
        return 0
    end

    local acceptcount = 0

    --check for empty space in the container
    for k = 1, self.maxslots do
        local v = self.itemslots[k]
        if v ~= nil then
            if v.prefab == item.prefab and v.components.stackable ~= nil then
                acceptcount = acceptcount + v.components.stackable:RoomLeft()
                if acceptcount >= stacksize then
                    return stacksize
                end
            end
        elseif self:CanTakeItemInSlot(item, k) then
            if self.acceptsstacks or stacksize <= 1 then
                return stacksize
            end
            acceptcount = acceptcount + 1
            if acceptcount >= stacksize then
                return stacksize
            end
        end
    end

    --check for empty space in our backpack
	local overflowitem = self:GetEquippedItem(EQUIPSLOTS.BODY)
    local overflow = overflowitem ~= nil and overflowitem.components.container or nil
    if overflow ~= nil then
        for k = 1, overflow.numslots do
            local v = overflow.slots[k]
            if v ~= nil then
                if v.prefab == item.prefab and v.components.stackable ~= nil then
                    acceptcount = acceptcount + v.components.stackable:RoomLeft()
                    if acceptcount >= stacksize then
                        return stacksize
                    end
                end
            elseif overflow:CanTakeItemInSlot(item, k) then
                if overflow.acceptsstacks or stacksize <= 1 then
                    return stacksize
                end
                acceptcount = acceptcount + 1
                if acceptcount >= stacksize then
                    return stacksize
                end
            end
        end
    end

    if item.components.stackable ~= nil then
        --check for equip stacks that aren't full
        for k, v in pairs(self.equipslots) do
            if v.prefab == item.prefab and v.components.equippable.equipstack and v.components.stackable ~= nil then
                acceptcount = acceptcount + v.components.stackable:RoomLeft()
                if acceptcount >= stacksize then
                    return stacksize
                end
            end
        end
    end

    return acceptcount
end

end

--nydusattacks:
if ZERGCONFIG.DIFFICULTY>1  then 
inst:DoTaskInTime(0,function(inst) NydusAttack(inst,0) end)
elseif ZERGCONFIG.DIFFICULTY>0  then 
inst:DoTaskInTime(0,NydusAttack)
end

end

	


if TheSim:GetGameID()=="DST" then 
return MakePlayerCharacter("ker", prefabs, assets, common_init,master_init, start_inv)
else
return MakePlayerCharacter("ker", prefabs, assets, function(inst)common_init(inst) master_init(inst) end, start_inv)
end