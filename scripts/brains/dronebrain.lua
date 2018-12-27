require "behaviours/follow"
require "behaviours/wander"
require "behaviours/faceentity"
require "behaviours/panic"
require "behaviours/runaway"
require "behaviours/doingaction"

local MIN_FOLLOW_DIST = 2
local MAX_FOLLOW_DIST = 10
local TARGET_FOLLOW_DIST = 9

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

local function StartWorkingCondition(inst)
    return inst.components.follower.leader and inst.components.follower.leader.sg and (inst.components.follower.leader.sg:HasStateTag("chopping") or inst.components.follower.leader.sg:HasStateTag("mining") )
end

local function KeepWorkingAction(inst)
    --if  (inst.components.follower.leader and inst.components.follower.leader:GetDistanceSqToInst(inst) <= 15*15) then print("keep") else print("failkeep") end
    return inst.components.follower.leader and inst.components.follower.leader:GetDistanceSqToInst(inst) <= 15*15
end

local function IsSwarmTarget(inst,target)
    if ZERGCONFIG.DRONE_TARGET==0 then return false end
    if inst.components.follower.leader then
    for k,v in pairs(inst.components.follower.leader.components.leader.followers) do
            if k.pickuptarget and k.pickuptarget==target then
			return true 
			end
    end
	end
    return false
end

local function FindWorkAction(inst)
    --deliver
	--inst.pickuptarget=nil
	
	if inst.carrieditem and inst.components.follower and inst.components.follower.leader and inst.components.follower.leader.components.inventory 
						--and not inst.components.follower.leader.components.inventory:IsFull() 
						and inst.components.follower.leader.components.inventory:CanAcceptCount(inst.carrieditem, inst.carrieditem.components.stackable.stacksize)>0
		then 
	   return BufferedAction(inst, inst.components.follower.leader, ACTIONS.GIVE)
	end
	--findwork
    local work = FindEntity(inst, 15, function(item) return (item.components.workable and (item.components.workable.action == ACTIONS.CHOP or item.components.workable.action == ACTIONS.MINE) and item.components.workable.workleft>0)
	                                                        or ((item.prefab=="grass" or item.prefab=="sapling")  and item.components.pickable:CanBePicked() and not IsSwarmTarget(inst,item))
                                                            or (not inst.carrieditem and (item.prefab == "log" or item.prefab == "rocks" or item.prefab == "pinecone" or item.prefab ==  "acorn" or item.prefab ==  "goldnugget" or item.prefab ==  "flint" or item.prefab ==  "cutgrass"  ) and item.components.inventoryitem and not IsSwarmTarget(inst,item))	end)
    
	if work and  (work.prefab=="grass" or work.prefab=="sapling") then inst.pickuptarget=work return BufferedAction(inst, work, ACTIONS.PICK) 
			end
	if work then
			if work.components.workable  then 
			return BufferedAction(inst, work, work.components.workable.action)
			else
		
		inst.pickuptarget=work
		return BufferedAction(inst, work, ACTIONS.PICKUP)
		end
    end
	
end



local function CollectAction(inst)
    if inst.sg:HasStateTag("sleeping") or inst.sg:HasStateTag("busy") then return false end
		if inst.carrieditem and inst.components.follower and inst.components.follower.leader and inst.components.follower.leader.components.inventory 
		--and not inst.components.follower.leader.components.inventory:IsFull() 
		and inst.components.follower.leader.components.inventory:CanAcceptCount(inst.carrieditem, inst.carrieditem.components.stackable.stacksize)>0
		then 
	          return BufferedAction(inst, inst.components.follower.leader, ACTIONS.GIVE)
		elseif inst.carrieditem then return false end
	if ZERGCONFIG.DRONE_GATHER==0 then return false end
    --local action = nil

    --local pt = inst:GetPosition()
    local target = FindEntity(inst, 10, function(guy) return (guy.prefab == "log" or guy.prefab == "rocks" or guy.prefab == "pinecone" or guy.prefab ==  "acorn" or guy.prefab ==  "goldnugget"  or guy.prefab ==  "flint") and guy.components.inventoryitem and not IsSwarmTarget(inst,guy) end )
    
	
	if target then
	    inst.pickuptarget=target
        return BufferedAction(inst, target, ACTIONS.PICKUP)
	else
	local target = FindEntity(inst, 10,function(item) return (item.prefab=="grass" or item.prefab=="sapling") and item.components.pickable:CanBePicked() and not IsSwarmTarget(inst,item) end )
		if target then
		inst.pickuptarget=target 
		return BufferedAction(inst, target, ACTIONS.PICK) 
		end
    end
end

local DroneBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

function DroneBrain:OnStart()
    local root = 
    PriorityNode(
    {
        WhileNode( function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst)),
		RunAway(self.inst, "epic", 15, 20),
		RunAway(self.inst, function(guy) return guy.components.combat and guy.components.combat.target == self.inst --[[and guy == self.inst.components.combat.target]] and not (self.inst.components.follower and guy==self.inst.components.follower.leader) end, 5, 10 ),
		--WhileNode( function() return self.inst.components.combat and self.inst.components.combat.target and self.inst.components.combat.target.components.combat and self.inst.components.combat.target.components.combat.target==self.inst end, "Attacked", RunAway(self.inst, self.inst.components.combat.target, 10, 20) ),
        IfNode(function() return StartWorkingCondition(self.inst) end, "work", 
                WhileNode(function() return KeepWorkingAction(self.inst) end, "keep working",
                    LoopNode{ 
                            DoingAction(self.inst, FindWorkAction )})),

		DoAction(self.inst, CollectAction),
		Follow(self.inst, function() return self.inst.components.follower.leader end, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST),
        
		FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn),
        Wander(self.inst, GetFollowPos, MAX_WANDER_DIST),   
    }, .25)
    self.bt = BT(self.inst, root)
end

return DroneBrain