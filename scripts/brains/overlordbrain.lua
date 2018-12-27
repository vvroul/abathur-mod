require "behaviours/follow"
require "behaviours/wander"
require "behaviours/faceentity"
require "behaviours/panic"

local MIN_FOLLOW_DIST = 0
local MAX_FOLLOW_DIST = 11
local TARGET_FOLLOW_DIST = 10

local MAX_WANDER_DIST = 10

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


local OverlordBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

function OverlordBrain:OnStart()
    local root = 
    PriorityNode(
    {
        WhileNode( function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst)),
        RunAway(self.inst, "epic", 15, 20),
		Follow(self.inst, function() return self.inst.components.follower.leader end, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST),
        FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn),
        Wander(self.inst, GetFollowPos, MAX_WANDER_DIST),   
    }, .25)
    self.bt = BT(self.inst, root)
end

return OverlordBrain