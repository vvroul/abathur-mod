require("brains/dronebrain")
require "stategraphs/SGdrone"

--Here we list any assets required by our prefab.
local assets=
{
	--this is the name of the Spriter file.
	Asset("ANIM", "anim/drone.zip"),
	Asset("SOUNDPACKAGE", "sound/overlord.fev"),
    Asset("SOUND", "sound/overlord.fsb"),
}
SetSharedLootTable('drone',
{
    {'meat',             1.00},

})

local function keeptargetfn(inst, target)
   return target
          and target.components.combat
          and target.components.health
          and not target.components.health:IsDead()
          and not (inst.components.follower and inst.components.follower.leader == target)
		  --and target.components.combat.target==inst
end

local function OnAttacked(inst, data)
    --inst.hasbeenhit=inst.hasbeenhit+1
	--inst:DoTaskInTime(5, function() inst.hasbeenhit=inst.hasbeenhit-1 end)
    inst.components.combat:SetTarget(data.attacker)

    inst.components.combat:ShareTarget(data.attacker, 80, function(dude) 
               return dude:HasTag("zerg")
		       --and not dude.inst == GetPlayer().inst
               and not dude.components.health:IsDead()
               and dude.components.follower
               and dude.components.follower.leader == inst.components.follower.leader
    end, 20)

	
end

local WAKE_TO_FOLLOW_DISTANCE = 14
local SLEEP_NEAR_LEADER_DISTANCE = 7

local function ShouldWakeUp(inst)
    return DefaultWakeTest(inst) or not inst.components.follower:IsNearLeader(WAKE_TO_FOLLOW_DISTANCE)
end

local function ShouldSleep(inst)
    --print(inst, "ShouldSleep", DefaultSleepTest(inst), not inst.sg:HasStateTag("open"), inst.components.follower:IsNearLeader(SLEEP_NEAR_LEADER_DISTANCE))
    return DefaultSleepTest(inst) 
    and inst.components.follower:IsNearLeader(SLEEP_NEAR_LEADER_DISTANCE) 
end

local function init_prefab()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddDynamicShadow()
	inst.DynamicShadow:SetSize(2, .75)
	if TheSim:GetGameID()=="DST" then 
	inst.entity:AddNetwork()
	end
	inst.Transform:SetFourFaced()
	
    anim:SetBank("drone")
    anim:SetBuild("drone")
	
	inst.AnimState:PlayAnimation("idle")
	
	inst:AddTag("zerg")
	
	if TheSim:GetGameID()=="DST" then 
	inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
	end
	
	inst:AddComponent("inspectable")
	inst:AddComponent("follower")
	--GetPlayer().components.leader:AddFollower(inst)
	
	inst:AddComponent("health")
	
	--inst.hasbeenhit=0
	inst:AddComponent("combat")
	inst.components.combat:SetKeepTargetFunction(keeptargetfn)
	inst:AddComponent("knownlocations")
	inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('drone')
	
    inst:AddComponent("locomotor")

    inst.components.locomotor.runspeed = 7

    MakeCharacterPhysics(inst, 10, .5)

    inst.Transform:SetScale(0.5,0.5,0.5)--rescale
	
	inst:AddComponent("swarmmind")
	
	inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(2)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWakeUp)

	inst.OnSave = function(inst)
	    if  inst.carrieditem then
	    local pos = Vector3(inst.Transform:GetWorldPosition())
		inst.carrieditem.Transform:SetPosition(pos:Get())
		end
        --[[if  inst.carrieditem and inst.carrieditem.persists  then
			data.carrieditem = inst.carrieditem:GetSaveRecord()
			inst.carrieditem:Remove()
		end]]
    end        
    
   --[[ inst.OnLoad = function(inst, data)
        if data and data.carrieditem then
				inst.carrieditem=SpawnSaveRecord(data.carrieditem)
				inst.carrieditem:RemoveFromScene()
	    end 
    end]]
	
    local brain = require("brains/dronebrain")
    inst:SetBrain(brain)
    inst:SetStateGraph("SGdrone")
	
	
	inst:ListenForEvent("stopfollowing", function(inst) inst.persists=true end)
	
	inst:ListenForEvent("attacked", OnAttacked)
	
    return inst
end

--Here we register our new prefab so that it can be used in game.
return Prefab( "common/creatures/drone", init_prefab, assets, nil)
