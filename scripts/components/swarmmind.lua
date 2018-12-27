local SwarmMind = Class(function(self, inst)
    self.inst = inst
    

end)



function SwarmMind:UpdateSanity(inst)
    if inst.components.leader and inst.components.leader.followers then
    --inst.components.sanity.penalty=inst.components.leader.numfollowers*5
	local penalty=0
	local healthpenalty=0
	for k,v in pairs(inst.components.leader.followers) do
            if k.prefab=="zergling" then penalty=penalty+5 
			end
			if k.prefab=="overlord" then penalty=penalty-50
            if ZERGCONFIG.DIFFICULTY>0 then healthpenalty=healthpenalty+1/4 end		
			end
			if k.prefab=="drone" then penalty=penalty+10
			end
			if k.prefab=="hydralisk" then penalty=penalty+10
			end
    end
    penalty=math.max(penalty,0)
	penalty=math.min(penalty,50)
	inst.components.sanity.penalty=penalty
	if TheSim:GetGameID()=="DST" then
	inst.components.health.penalty = healthpenalty + inst.components.health.numrevives * TUNING.REVIVE_HEALTH_PENALTY_AS_MULTIPLE_OF_EFFIGY
    else
	inst.components.health:RecalculatePenalty()
	inst.components.health.penalty = healthpenalty + inst.components.health.penalty
    end
	
	
	inst.components.sanity:DoDelta(0)
	inst.components.health:DoDelta(0)
	--print(penalty)
			--numfollowers

    end
   end

return SwarmMind