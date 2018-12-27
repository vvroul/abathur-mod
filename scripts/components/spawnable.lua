local Spawnable = Class(function(self, inst)
    self.inst = inst
    

end)
--[[
--local Action = GLOBAL.Action
local SPAWNLING= Action(1,true,true)
SPAWNLING.id="SPAWNLING"
SPAWNLING.str = "Spawn"
SPAWNLING.fn= function(act)
    if act.doer.components.sanity.penalty>40 and act.doer.components.talker then
	act.doer.components.talker:Say("Spawn more Overlords!", 2.5)
	elseif act.doer.components.sanity.current<60 and act.doer.components.talker then
	act.doer.components.talker:Say("Not enough energy!", 2.5)
	elseif act.doer.components.hunger.current<=100 and act.doer.components.talker then
	act.doer.components.talker:Say("We require more minerals!", 2.5)
	end
	if act.doer==GetPlayer() and act.doer.components.hunger.current>100 and act.doer.components.sanity.current>=60 then
		local pos = Vector3(act.doer.Transform:GetWorldPosition())
		local offset = (FindWalkableOffset(pos,math.random()*PI*2,0.5,false))
		if offset == nil then
		  if  act.doer.components.talker then
	      act.doer.components.talker:Say("Unacceptable command!", 2.5)
		  end
		  return
	    end
		pos=pos+offset
		act.doer.SoundEmitter:PlaySound("overlord/spawn/spawn")
	    SpawnPrefab("Zergling").Transform:SetPosition(pos:Get())
		SpawnPrefab("Zergling").Transform:SetPosition(pos:Get())
		
		GetPlayer().components.hunger.current=GetPlayer().components.hunger.current-75
		--GetPlayer().components.hunger:DoDelta(-75,1)
		if act.invobject.components.stackable and act.invobject.components.stackable.stacksize > 1 then
            act.invobject.components.stackable:Get():Remove()
		else
			act.invobject:Remove()
	    end
	end
	
	return true
end

local SPAWNDRONE= Action(1,true,true)
SPAWNDRONE.id="SPAWNDRONE"
SPAWNDRONE.str = "Spawn"
SPAWNDRONE.fn= function(act)
    if act.doer.components.sanity.penalty>40 and act.doer.components.talker then
	act.doer.components.talker:Say("Spawn more Overlords!", 2.5)
	elseif act.doer.components.sanity.current<60 and act.doer.components.talker then
	act.doer.components.talker:Say("Not enough energy!", 2.5)
	elseif act.doer.components.hunger.current<=100 and act.doer.components.talker then
	act.doer.components.talker:Say("We require more minerals!", 2.5)
	end
	if act.doer==GetPlayer() and act.doer.components.hunger.current>100 and act.doer.components.sanity.current>=60 then
		local pos = Vector3(act.doer.Transform:GetWorldPosition())
		local offset = (FindWalkableOffset(pos,math.random()*PI*2,0.5,false))
		if offset == nil then
		  if  act.doer.components.talker then
	      act.doer.components.talker:Say("Unacceptable command!", 2.5)
		  end
		  return
	    end
		pos=pos+offset
		act.doer.SoundEmitter:PlaySound("overlord/spawn/spawn")
		act.doer.SoundEmitter:PlaySound("overlord/drone/drone_idle")
	    SpawnPrefab("drone").Transform:SetPosition(pos:Get())
		
		GetPlayer().components.hunger.current=GetPlayer().components.hunger.current-50
		--GetPlayer().components.hunger:DoDelta(-75,1)
		if act.invobject.components.stackable and act.invobject.components.stackable.stacksize > 1 then
            act.invobject.components.stackable:Get():Remove()
			else
			act.invobject:Remove()
	    end
	end
	
	return true
end



--env.AddAction(SPAWNLING)

function Spawnable:CollectInventoryActions(doer, actions, right)
		if not (self.inst.components.equippable or right) and self.inst.prefab=="larva" then
			table.insert(actions, SPAWNLING)
			
		end
		if not (self.inst.components.equippable or right) and self.inst.prefab=="larva_drone" then
			table.insert(actions, SPAWNDRONE)
			
		end
end
]]
function Spawnable:Spawn(act)
    local hunger=0
	local penalty=0
	local health=0
	if act.invobject.prefab=="larva_drone" then 
	if ZERGCONFIG.DIFFICULTY>1 then health=40 end
	hunger=50 
	penalty=10 
	end
	if act.invobject.prefab=="larva" then 
	if ZERGCONFIG.DIFFICULTY>1 then health=10 end
	hunger=75 
	penalty=10 
	end
	if act.invobject.prefab=="larva_overlord" then 
	if ZERGCONFIG.DIFFICULTY>1 then health=60 end
	hunger=100 
	penalty=-50 
	end
	if act.invobject.prefab=="larva_hydra" then 
	if ZERGCONFIG.DIFFICULTY>1 then health=30 end
	hunger=100 
	penalty=10 
	end
    if ZERGCONFIG.DIFFICULTY>1 then hunger=hunger+25 end
	
	if act.doer.components.sanity.penalty>50-penalty and act.doer.components.talker then
	act.doer.components.talker:Say("Spawn more Overlords!", 2.5)
	elseif act.doer.components.sanity.current<50+penalty and act.doer.components.talker then
	act.doer.components.talker:Say("Not enough energy!", 2.5)
	elseif act.doer.components.hunger.current<=50+hunger and act.doer.components.talker then
	act.doer.components.talker:Say("We require more minerals!", 2.5)
	end
	if act.doer.prefab=="ker" and act.doer.components.hunger.current>50+hunger and act.doer.components.sanity.current>=50+penalty then
		local pos = Vector3(act.doer.Transform:GetWorldPosition())
		local offset = (FindWalkableOffset(pos,math.random()*PI*2,0.5,false))
		if offset == nil then
		  if  act.doer.components.talker then
	      act.doer.components.talker:Say("Unacceptable command!", 2.5)
		  end
		  return
	    end
		pos=pos+offset
		act.doer.SoundEmitter:PlaySound("overlord/spawn/spawn")
		if act.invobject.prefab=="larva_drone" then 
		local unit=SpawnPrefab("drone")
		unit.Transform:SetPosition(pos:Get())
		act.doer.components.leader:AddFollower(unit)
		if TheSim:GetGameID()=="DST" then unit.persists=false end
		unit.components.swarmmind:UpdateSanity(unit.components.follower.leader)
		end
		
		if act.invobject.prefab=="larva_hydra" then 
		local unit=SpawnPrefab("hydralisk")
		unit.Transform:SetPosition(pos:Get())
		act.doer.components.leader:AddFollower(unit)
		unit.SoundEmitter:PlaySound("hydra/hydra/hydra_idle")
		if TheSim:GetGameID()=="DST" then unit.persists=false end
		unit.components.swarmmind:UpdateSanity(unit.components.follower.leader)
		end
		
		if act.invobject.prefab=="larva" then 
		local unit=SpawnPrefab("zergling")
		unit.Transform:SetPosition(pos:Get())
		act.doer.components.leader:AddFollower(unit)
		if TheSim:GetGameID()=="DST" then unit.persists=false end
		unit.components.swarmmind:UpdateSanity(unit.components.follower.leader)
		unit=SpawnPrefab("zergling")
		unit.Transform:SetPosition(pos:Get())
		act.doer.components.leader:AddFollower(unit)
		if TheSim:GetGameID()=="DST" then unit.persists=false end
		unit.components.swarmmind:UpdateSanity(unit.components.follower.leader)
		end
		if act.invobject.prefab=="larva_overlord" then 
		local unit=SpawnPrefab("overlord")
		unit.Transform:SetPosition(pos:Get())
		act.doer.components.leader:AddFollower(unit)
		if TheSim:GetGameID()=="DST" then unit.persists=false end
		unit.components.swarmmind:UpdateSanity(unit.components.follower.leader)
		end
        
		
		act.doer.components.hunger.current=act.doer.components.hunger.current-hunger
		if act.doer.components.health.currenthealth <=health then health=act.doer.components.health.currenthealth-1 end
		act.doer.components.health:DoDelta(-1*health,true)
		if act.invobject.components.stackable and act.invobject.components.stackable.stacksize > 1 then
            act.invobject.components.stackable:Get():Remove()
		else
			act.invobject:Remove()
	    end
	end
	end
	

function Spawnable:CollectInventoryActions(doer, actions, right)
		if not (self.inst.components.equippable or right) then
			table.insert(actions, ACTIONS.SPAWNZERG)
		end
end


return Spawnable