local assets=
{
	--this is the name of the Spriter file.
	Asset("ANIM", "anim/hydralisk.zip"),
	--Asset("ANIM", "anim/hydraliskmark.zip"),
	Asset("SOUNDPACKAGE", "sound/hydra.fev"),
    Asset("SOUND", "sound/hydra.fsb"),
}

local prefabs = 
{
	"stinger",
}


SetSharedLootTable('hydralisk',
{
    {"stinger",            0.20},
	{"stinger",            0.20},
	{"stinger",            0.20},
	{"stinger",            0.20},
	{"stinger",            0.20},
})

local function EquipWeapon(inst)
    if inst.components.inventory and not inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
        local hydraspike = CreateEntity()
        --[[Non-networked entity]]
        hydraspike.entity:AddTransform()
        hydraspike:AddComponent("weapon")
        hydraspike:AddTag("sharp")
        hydraspike.components.weapon:SetDamage(inst.components.combat.defaultdamage)
        hydraspike.components.weapon:SetRange(inst.components.combat.attackrange-5,inst.components.combat.attackrange)
        hydraspike.components.weapon:SetProjectile("blowdart_walrus")
        hydraspike:AddComponent("inventoryitem")
        hydraspike.persists = false
        hydraspike.components.inventoryitem:SetOnDroppedFn(inst.Remove)
        hydraspike:AddComponent("equippable")
        
        inst.components.inventory:Equip(hydraspike)
    end
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

local function keeptargetfn(inst, target)
   return target
          and target.components.combat
          and target.components.health
          and not target.components.health:IsDead()
          and not (inst.components.follower and inst.components.follower.leader == target)
          --and not (inst.components.follower and inst.components.follower.leader == GetPlayer() and target:HasTag("companion"))
end

local function OnAttacked(inst, data)

    inst.components.combat:SuggestTarget(data.attacker)
	
    inst.components.combat:ShareTarget(data.attacker, 80, function(dude) 
               return dude:HasTag("zerg")
		       --and not dude.inst == GetPlayer().inst
               and not dude.components.health:IsDead()
               and dude.components.follower
               and dude.components.follower.leader == inst.components.follower.leader
    end, 20)
	
end

--[[local function HydraMark(inst) 
	inst.SoundEmitter:PlaySound("hydra/hydra/hydra_mark")
	local pos = Vector3(inst.Transform:GetWorldPosition())
    local mark=CreateEntity()
	mark.entity:AddTransform()
	mark.entity:AddAnimState()
	mark.entity:AddNetwork()
	mark:AddTag("FX")
	mark:AddTag("NOCLICK")
	mark:AddTag("NOBLOCK")
	mark.AnimState:SetBank("hydraliskmark")
    mark.AnimState:SetBuild("hydraliskmark")
    mark.Transform:SetPosition(pos:Get())
	mark.AnimState:PlayAnimation("idle_pre")
	mark.AnimState:PushAnimation("idle",true)
	mark.persists=false
	--local follower = mark.entity:AddFollower()
    --    follower:FollowSymbol(inst.GUID, inst.components.combat.hiteffectsymbol, 0, 0, 0)
	--	follower:FollowSymbol(inst.GUID, "body", pos.x, pos.y, pos.z)
    mark:DoTaskInTime(4,function(markinst) markinst:Remove() end)
	end]]

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
	
	MakeCharacterPhysics(inst, 10, .5)
	
    anim:SetBank("hydralisk")
    anim:SetBuild("hydralisk")
	
	
	inst.AnimState:PushAnimation("idle")
	
	inst:AddTag("scarytoprey")  
	inst:AddTag("zerg")
	
	if TheSim:GetGameID()=="DST" then 
	inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
	end
	
	inst:AddComponent("locomotor")
	inst.components.locomotor:SetSlowMultiplier( 1 )
	inst.components.locomotor:SetTriggersCreep(false)
    inst.components.locomotor.pathcaps = { ignorecreep = true }
	
	inst:AddComponent("follower")
	
	inst:AddComponent("health")
	
	inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "pig_torso"--"body"
    inst.components.combat:SetRange(TUNING.WALRUS_ATTACK_DIST)
    inst.components.combat:SetDefaultDamage(TUNING.WALRUS_DAMAGE)
    inst.components.combat:SetAttackPeriod(1)
	inst.components.combat:SetKeepTargetFunction(keeptargetfn)
	
	local oldsuggest=inst.components.combat.SuggestTarget
	function inst.components.combat:SuggestTarget(target)
	if inst.hydratarget==nil then
	inst.hydratarget=target
	inst:DoTaskInTime(math.random()*5+ 5,function(hinst) if hinst.hydratarget and hinst.hydratarget~=nil then oldsuggest(hinst.components.combat,target) end hinst.hydratarget=nil end)
	return true
	end
    --if inst.hydratarget and inst.hydratarget==target then oldsuggest(inst.components.combat,target) return true end
	end

    --inst.components.combat:SetKeepTargetFunction(keeptargetfn)
	
	inst:AddComponent("inventory")
	inst:DoTaskInTime(1, EquipWeapon)
	
	inst:AddComponent("inspectable")
	
	inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(2)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWakeUp)
	
	inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('hydralisk')
	
	inst:AddComponent("swarmmind")
	
	inst:ListenForEvent("newcombattarget", function(inst)
	local mark=SpawnPrefab("hydraliskmark")
	mark.Transform:SetPosition(inst.Transform:GetWorldPosition())
	--local follower = mark.entity:AddFollower()
   --     follower:FollowSymbol(inst.GUID, "swapa_torso", 0, 0, 0)
    mark.hydra=inst
    mark:DoPeriodicTask(FRAMES, function(markinst)  if markinst.hydra and not markinst.hydra.components.health:IsDead() then markinst.Transform:SetPosition(markinst.hydra.Transform:GetWorldPosition()) else markinst:Remove() end end)
	end)
	inst:ListenForEvent("attacked", OnAttacked)
	--inst:ListenForEvent("locomote", function(inst) if inst.hydramark and inst.hydramark~=nil then  inst.hydramark.Transform:SetPosition(inst.Transform:GetWorldPosition()) end end)
	--SetDebugEntity(inst) 
	local brain = require("brains/hydraliskbrain")
    inst:SetBrain(brain)
	inst:SetStateGraph("SGhydralisk")
   return inst
end

return Prefab( "common/creatures/hydralisk", init_prefab, assets, nil)