require "prefabutil"
require("brains/overlordbrain")
require "stategraphs/SGoverlord"



local assets=
{
	Asset("ANIM", "anim/overlord.zip"),
	Asset( "IMAGE", "images/inventoryimages/overlord.tex"),
    Asset( "ATLAS", "images/inventoryimages/overlord.xml"),
    Asset("SOUNDPACKAGE", "sound/overlord.fev"),
    Asset("SOUND", "sound/overlord.fsb"),
	
	
}

local prefabs = 
{
	"monstermeat",
	"purplegem",
}


SetSharedLootTable('overlord',
{
    {"purplegem",            1.00},

})

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

local function CalcSanityAura(inst, observer)
	return TUNING.SANITYAURA_TINY
end

local function keeptargetfn(inst, target)
   return target
          and target.components.combat
          and target.components.health
          and not target.components.health:IsDead()
          and not (inst.components.follower and inst.components.follower.leader == target)
		  --and target.components.combat.target==inst
end
--[[
local function OnSpawnFuel(inst, fuel)
	inst.sg:GoToState("goo", fuel)
end]]
local function OnAttacked(inst, data)

    inst.components.combat:ShareTarget(data.attacker, 60, function(dude) 
               return dude:HasTag("zerg")
		       --and not dude.inst == GetPlayer().inst
               and not dude.components.health:IsDead()
               and dude.components.follower
               and dude.components.follower.leader == inst.components.follower.leader
    end, 20)
	
end


local overlordslot =
{
    widget =
    {
        slotpos = {	Vector3(0,64+32+8+4,0), 
					--Vector3(0,32+4,0),
					--Vector3(0,-(32+4),0), 
					--Vector3(0,-(64+32+8+4),0)
					},
        animbank = "ui_cookpot_1x4",
        animbuild = "ui_cookpot_1x4",
        pos = Vector3(200,0,0)
    },
    --issidewidget = true,
    type = "chest",
}
if TheSim:GetGameID()=="DST" then 
local containers = require("containers")
local widgetsetup_old = containers.widgetsetup
function containers.widgetsetup(container, prefab, data, ...)

 if container.inst.prefab == "overlord" or prefab == "overlord" then
  
      for k, v in pairs(overlordslot) do
            container[k] = v
        end
        container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
        return
  
  end
      return widgetsetup_old(container, prefab, data, ...)
end
end

local function Breed(inst) 
	local item=inst.components.container:GetItemInSlot(1)
	local breed=20
	if inst.components.follower and inst.components.follower.leader and item and item.prefab=="monstermeat" and item.components.stackable:StackSize()>=breed then
	if item.components.stackable:StackSize()==breed then
	inst.components.container:DestroyContents()
	else item.components.stackable:Get(breed):Remove()
	end
	local pos = Vector3(inst.Transform:GetWorldPosition())
	local offset = (FindWalkableOffset(pos,math.random()*PI*2,0.5,false))
	if offset == nil then
		  return
	    end
	pos=pos+offset
	local unit=SpawnPrefab("overlord")
	inst.SoundEmitter:PlaySound("overlord/spawn/spawn")
	unit.Transform:SetPosition(pos:Get())
	inst.components.follower.leader.components.leader:AddFollower(unit)
	unit.components.swarmmind:UpdateSanity(unit.components.follower.leader)
	end
end


local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddDynamicShadow()
	if TheSim:GetGameID()=="DST" then 
	inst.entity:AddNetwork()
	end
	inst.DynamicShadow:SetSize(2, .75)
	inst.Transform:SetFourFaced()

 	MakeGhostPhysics(inst, 1, .5)

 	--[[local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("glommer.png")
	minimap:SetPriority(5)]]

    inst.AnimState:SetBank("glommer")
    inst.AnimState:SetBuild("overlord")
	
    inst.AnimState:PlayAnimation("idle_loop")
	inst.SoundEmitter:PlaySound("overlord/overlord/overlord_idle")

    --inst:AddTag("companion")
	inst:AddTag("zerg")
	inst:AddTag("flying")
    --inst:AddTag("cattoyairborne")

	if TheSim:GetGameID()=="DST" then 
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    end
	
	inst:AddComponent("inspectable")
	inst:AddComponent("follower")
	--inst:AddComponent("leader")
	--GetPlayer().components.leader:AddFollower(inst)
	--ThePlayer.components.leader:AddFollower(inst)
	inst:AddComponent("swarmmind")
    --inst.components.swarmmind:UpdateSanity(GetPlayer())
	
	inst:AddComponent("health")
	inst:AddComponent("combat")
	inst.components.combat:SetKeepTargetFunction(keeptargetfn)
	inst:AddComponent("knownlocations")
	inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('overlord')

	if TheSim:GetGameID()=="DST" then 
	inst:AddComponent("container")
	inst.components.container:WidgetSetup("overlord", overlordslot)
    else
    inst:AddComponent("container")
    inst.components.container:SetNumSlots(1)
    inst.components.container.widgetslotpos = {Vector3(0,64+32+8+4,0)}
	inst.components.container.widgetanimbank = "ui_cookpot_1x4"
	inst.components.container.widgetanimbuild = "ui_cookpot_1x4"
	inst.components.container.widgetpos = Vector3(200,0,0)
	inst.components.container.side_align_tip = 100
	end

	
	inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(3)
    inst.components.sleeper.testperiod = GetRandomWithVariance(6, 2)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWakeUp)

	if ZERGCONFIG.DIFFICULTY==0 then 
    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aurafn = CalcSanityAura
	end

	inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = 6

    --[[inst:AddComponent("periodicspawner")
    inst.components.periodicspawner:SetOnSpawnFn(OnSpawnFuel)
    inst.components.periodicspawner.prefab = "glommerfuel"
    inst.components.periodicspawner.basetime = TUNING.TOTAL_DAY_TIME * 2
    inst.components.periodicspawner.randtime = TUNING.TOTAL_DAY_TIME * 2
    inst.components.periodicspawner:Start()]]
	
	
	
    local brain = require("brains/overlordbrain")
    inst:SetBrain(brain)
    inst:SetStateGraph("SGoverlord")

    if TheSim:GetGameID()=="DST" then
	inst:WatchWorldState("isfullmoon", Breed)
	inst:ListenForEvent("onclose", function() if TheWorld.state.isfullmoon then Breed(inst) end end)
	inst:ListenForEvent("itemget", function() if TheWorld.state.isfullmoon then Breed(inst) end end)
	inst:ListenForEvent("containergotitem", function() if TheWorld.state.isfullmoon then Breed(inst) end end)
	else 
	inst:ListenForEvent("nighttime", function() if GetClock():GetMoonPhase() == "full" then Breed(inst) end end , GetWorld())
	inst:ListenForEvent("onclose", function() if GetClock():GetMoonPhase() == "full" then Breed(inst) end end)
	inst:ListenForEvent("itemget", function() if GetClock():GetMoonPhase() == "full" then Breed(inst) end end)
	inst:ListenForEvent("containergotitem", function() if GetClock():GetMoonPhase() == "full" then Breed(inst) end end)
	end
	
	inst:ListenForEvent("stopfollowing", function(inst) inst.persists=true end)
	
	inst:ListenForEvent("attacked", OnAttacked)

	return inst
end


return Prefab("common/creatures/overlord", fn, assets, prefabs)