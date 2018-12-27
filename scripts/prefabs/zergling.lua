require "brains/zerglingbrain"
require "stategraphs/SGzergling"


local assets =
{
	--Asset("ANIM", "anim/ds_zergling_basic.zip"),
	Asset("ANIM", "anim/zergli_build.zip"),
	Asset("SOUND", "sound/zergling.fsb"),
   
}

local prefabs =
{
	"spidergland",
    "monstermeat",
    "silk",
}

SetSharedLootTable('zergling',
{
    {'monstermeat',             0.50},

})

local function NormalRetarget(inst)
    local targetDist = TUNING.SPIDER_TARGET_DIST
    if ZERGCONFIG.DIFFICULTY>0 and inst.components.follower and not inst.components.follower.leader 
	then targetDist = 20 end

    return FindEntity(inst, targetDist, 
        function(guy) 
		    if ZERGCONFIG.DIFFICULTY>0 and inst.components.follower and inst.components.follower.leader==nil and guy.prefab~="zergling" and guy.prefab~="overlord" and guy.prefab~="hydralisk" and inst.components.combat:CanTarget(guy)  then 
			return true
			end
            if inst.components.combat:CanTarget(guy)
               and not (inst.components.follower and inst.components.follower.leader == guy)
               --and not (inst.components.follower and inst.components.follower.leader == GetPlayer() and guy:HasTag("companion")) 
			   then
                return (not guy:HasTag("player")  and--[[guy:HasTag("character") and]] not guy:HasTag("zerg") and guy:HasTag("monster"))
            end
    end)
end

local function keeptargetfn(inst, target)
   return target
          and target.components.combat
          and target.components.health
          and not target.components.health:IsDead()
          and not (inst.components.follower and inst.components.follower.leader == target)
          --and not (inst.components.follower and inst.components.follower.leader == GetPlayer() and target:HasTag("companion"))
end


--[[local function ShouldWake(inst)
    local wakeRadius = TUNING.SPIDER_INVESTIGATETARGET_DIST*1.5

    return GetClock():IsDay()
           or (inst.components.combat and inst.components.combat.target)
           or (inst.components.burnable and inst.components.burnable:IsBurning() )
           or (FindEntity(inst, wakeRadius, function(...) return NormalRetarget(inst, ...) end ))
end

local function ShouldWakeUp(inst)
	local player = inst.components.follower.leader
	if player then
	local bf = Point(inst.Transform:GetWorldPosition())
    local pl = Point(player.Transform:GetWorldPosition())
	local dist = distsq(pl, bf)
	if dist > 400 then
		return true 
	end
	end
    return ShouldWake(inst)
end]]

--[[local function ShouldSleep(inst)
        if TheSim:GetGameID()=="DST" then 
		
		return not TheWorld.state.isday 
		       and not (inst.components.combat and inst.components.combat.target)
               and not (inst.components.burnable and inst.components.burnable:IsBurning() )
		else 
		return GetClock():IsNight() 
			   and not (inst.components.combat and inst.components.combat.target)
               and not (inst.components.burnable and inst.components.burnable:IsBurning() )
		end
		return true        
end]]

local WAKE_TO_FOLLOW_DISTANCE = 14
local SLEEP_NEAR_LEADER_DISTANCE = 7

local function ShouldSleep(inst)
    --print(inst, "ShouldSleep", DefaultSleepTest(inst), not inst.sg:HasStateTag("open"), inst.components.follower:IsNearLeader(SLEEP_NEAR_LEADER_DISTANCE))
    return DefaultSleepTest(inst) 
    and inst.components.follower:IsNearLeader(SLEEP_NEAR_LEADER_DISTANCE) 
end

local function ShouldWakeUp(inst)
    return DefaultWakeTest(inst) or not inst.components.follower:IsNearLeader(WAKE_TO_FOLLOW_DISTANCE)
end



local function OnAttacked(inst, data)

    inst.components.combat:SetTarget(data.attacker)
	
    inst.components.combat:ShareTarget(data.attacker, 80, function(dude) 
               return dude:HasTag("zerg")
		       --and not dude.inst == GetPlayer().inst
               and not dude.components.health:IsDead()
               and dude.components.follower
               and dude.components.follower.leader == inst.components.follower.leader
    end, 20)
	
end

local function StartDay(inst)
    inst.components.sleeper:WakeUp()
end

local function StartNight(inst)
	ShouldSleep(inst)
end

local function create_common(Sim)
	local inst = CreateEntity()
	
	
	--inst.OnEntitySleep = OnEntitySleep
	
    inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddLightWatcher()
	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1.5, .5 )
	if TheSim:GetGameID()=="DST" then 
	inst.entity:AddNetwork()
	end
    inst.Transform:SetFourFaced()
    
    
     -----
	--inst:AddTag("catcoon")--i love cats! but it doesnt help T-T
    inst:AddTag("zerg")
	inst:AddTag("zergling")
	--inst:AddTag("monster")
    --inst:AddTag("hostile")
	inst:AddTag("scarytoprey")    
    --inst:AddTag("canbetrapped")
    inst:AddTag("smallcreature")    
    
    MakeCharacterPhysics(inst, 10, .5)

    
    --inst:AddTag("spider")
    inst.AnimState:SetBank("hound")
	inst.AnimState:SetBuild("zergli_build")
    inst.AnimState:PlayAnimation("idle")
    
	if TheSim:GetGameID()=="DST" then 
	inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
	end
	
    -- locomotor must be constructed before the stategraph!
    inst:AddComponent("locomotor")
	inst.components.locomotor:SetSlowMultiplier( 1 )
	inst.components.locomotor:SetTriggersCreep(false)
    inst.components.locomotor.pathcaps = { ignorecreep = true }
  
    inst:SetStateGraph("SGzergling")
    
    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('zergling')
    
    inst:AddComponent("follower")
	--GetPlayer().components.leader:AddFollower(inst)
	
	inst:AddComponent("swarmmind")
    --inst.components.swarmmind:UpdateSanity(GetPlayer())
	
	
    ---------------------        
    MakeMediumBurnableCharacter(inst, "body")
    MakeMediumFreezableCharacter(inst, "body")
    inst.components.burnable.flammability = TUNING.SPIDER_FLAMMABILITY
    ---------------------       
    
    
    ------------------
    inst:AddComponent("health")

    ------------------
    
    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "body"
    inst.components.combat:SetKeepTargetFunction(keeptargetfn)
  
	
    
    ------------------
    
    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(2)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWakeUp)
    ------------------
    
    inst:AddComponent("knownlocations")

    ------------------
    
    inst:AddComponent("eater")
	
	if TheSim:GetGameID()=="DST" then 
		inst.components.eater:SetDiet({ FOODTYPE.MEAT }, { FOODTYPE.MEAT })
	 else 
        inst.components.eater:SetCarnivore()
	end

    inst.components.eater:SetCanEatHorrible()
    inst.components.eater.strongstomach = true -- can eat monster meat!
	inst.components.eater:SetOnEatFn(function(ling,food) ling.components.health.currenthealth=ling.components.health.maxhealth end )
	
    
    ------------------
    
    inst:AddComponent("inspectable")
    
    ------------------
    if ZERGCONFIG.DIFFICULTY==0 then 
	inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = 0.5
	end
    
    
    local brain = require "brains/zerglingbrain"
    inst:SetBrain(brain)
    
	
	inst:ListenForEvent("stopfollowing", function(inst) inst.persists=true 	end)
	
    inst:ListenForEvent("attacked", OnAttacked)
	if TheSim:GetGameID()=="DST" then 
    inst:ListenForEvent("daytime", function() StartDay(inst) end, TheWorld)
	else 
	inst:ListenForEvent("daytime", function() StartDay(inst) end, GetWorld())
	end
    --inst:ListenForEvent( "nighttime", function(i, data) StartNight( inst ) end, GetWorld())	
	
    return inst
end

local function create_zergling(Sim)
    local inst = create_common(Sim)
 
    
	
	if TheSim:GetGameID()=="DST" then 
    if not TheWorld.ismastersim then
        return inst
    end
	end
	
    inst.components.health:SetMaxHealth(TUNING.SPIDER_HEALTH)

    inst.components.combat:SetDefaultDamage(TUNING.SPIDER_DAMAGE)
    inst.components.combat:SetAttackPeriod(1)
    inst.components.combat:SetRetargetFunction(3, NormalRetarget)
    inst.components.combat:SetHurtSound("dontstarve/creatures/spider/hit_response")
    --inst.components.combat:SetRange(3*2,3*2)--compensation for rescale
    inst.components.locomotor.walkspeed = TUNING.SPIDER_WALK_SPEED*1.5*2--compensation for rescale
    inst.components.locomotor.runspeed = TUNING.SPIDER_RUN_SPEED*1.5*2--compensation for rescale
    inst.Transform:SetScale(0.5,0.5,0.5)--rescale
    return inst
end



return Prefab( "forest/monsters/zergling", create_zergling, assets, prefabs)
