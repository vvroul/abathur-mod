require "behaviours/chaseandattack"
require "behaviours/runaway"
require "behaviours/wander"
require "behaviours/doaction"
require "behaviours/panic"

local RUN_AWAY_DIST = 10
local SEE_FOOD_DIST = 10
local SEE_TARGET_DIST = 6

local MIN_FOLLOW_DIST = 6--2
local TARGET_FOLLOW_DIST = 10
local MAX_FOLLOW_DIST = 12--8

local MAX_CHASE_TIME = 8
local MAX_WANDER_DIST = 32


local DAMAGE_UNTIL_SHIELD = 50
local SHIELD_TIME = 3
local AVOID_PROJECTILE_ATTACKS = false

local ZerglingBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)


local function EatFoodAction(inst)

    local target = FindEntity(inst, SEE_FOOD_DIST, function(item) return inst.components.eater:CanEat(item) and item:IsOnValidGround() end)
    if target then
        return BufferedAction(inst, target, ACTIONS.EAT)
    end
end



local function GetFaceTargetFn(inst)
    return inst.components.follower.leader
end

local function KeepFaceTargetFn(inst, target)
    return inst.components.follower.leader == target
end

local function GetFollowPos(inst)
    return inst.components.follower.leader and inst.components.follower.leader:GetPosition() or
    inst:GetPosition()
end

function ZerglingBrain:OnStart()
    local root =
        PriorityNode(
        {
            --WhileNode( function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst)),
			RunAway(self.inst, function(guy) return guy:HasTag"epic" or guy:HasTag"rook"  end, 10, 12),
            --AttackWall(self.inst),
			RunAway(self.inst, function(guy) return self.inst.components.health.currenthealth<=50 and guy.components.combat and guy.components.combat.target == self.inst --[[and guy == self.inst.components.combat.target]] and not (self.inst.components.follower and guy==self.inst.components.follower.leader) end, 5, 7 ),
			RunAway(self.inst, function(guy) return self.inst.components.combat.target==guy  end, 5, 7),
            ChaseAndAttack(self.inst, MAX_CHASE_TIME),
            Follow(self.inst, function() return self.inst.components.follower.leader end, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST),
            IfNode(function() return self.inst.components.follower.leader ~= nil end, "HasLeader",
				FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn )),            
            --DoAction(self.inst, function() return InvestigateAction(self.inst) end ),
        --    WhileNode(function() if TheSim:GetGameID()=="DST" then return not TheWorld.state.isday else return GetClock():IsNight() end end, "IsNight",
        --              DoAction(self.inst, function() return self.inst:ShouldSleep(self.inst) end ) ),
            Wander(self.inst, GetFollowPos, MAX_WANDER_DIST), 
			--Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("home") end, MAX_WANDER_DIST)            
        },1)
    
    
    self.bt = BT(self.inst, root)
    
         
end

return ZerglingBrain
