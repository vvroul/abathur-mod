require("stategraphs/commonstates")


local actionhandlers = 
{
    ActionHandler(ACTIONS.CHOP, "chop"),
	ActionHandler(ACTIONS.MINE, "mine"),
	ActionHandler(ACTIONS.PICKUP, "pickup"),
	ActionHandler(ACTIONS.GIVE, "give"),
	ActionHandler(ACTIONS.PICK, "pick"),
}

local events=
{
    CommonHandlers.OnSleep(),
    CommonHandlers.OnFreeze(),
    CommonHandlers.OnAttack(),
    CommonHandlers.OnAttacked(),
    CommonHandlers.OnDeath(),
	
    CommonHandlers.OnLocomote(true,false),
	  EventHandler("doaction", 
        function(inst, data) 
            if not inst.components.health:IsDead() and not inst.sg:HasStateTag("busy") then
                if data.action == ACTIONS.CHOP then
                    inst.sg:GoToState("chop", data.target)
                end
				
				if data.action == ACTIONS.MINE then
                    inst.sg:GoToState("mine", data.target)
                end
				if data.action == ACTIONS.PICKUP then
				    --print("goin to state pickup")
					--print(data.action)
					--print(data.target)
					--print(data.action)
					--print(data)
                    inst.sg:GoToState("pickup", data.target)
                end
				if data.action == ACTIONS.GIVE then
				    --print("goin to state pickup")
					--print(data.action)
					--print(data.target)
					--print(data.action)
					--print(data)
                    inst.sg:GoToState("give", data.target)
                end
				if data.action == ACTIONS.PICK then
				    --print("goin to state pickup")
					--print(data.action)
					--print(data.target)
					--print(data.action)
					--print(data)
                    inst.sg:GoToState("pick", data.target)
                end
            end
        end), 

}


local states=
{	State{
        name = "run_start",
        tags = { "moving", "running", "canrotate" },

        onenter = function(inst)
            inst.components.locomotor:RunForward()
            inst.AnimState:PlayAnimation("run")
        end,

        events =
        {
            EventHandler("animover", function(inst) if inst.AnimState:AnimDone() then inst.sg:GoToState("run") end end),
        },
    },
	State
    {
        name = "run",
        tags = { "moving", "running", "canrotate" },

        onenter = function(inst)
            inst.components.locomotor:RunForward()
            inst.AnimState:PlayAnimation("run", true)
            --inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength())
        end,


        --ontimeout = function(inst) inst.sg:GoToState("run") end
		events=
            {   
                EventHandler("animover", function(inst) inst.sg:GoToState("run") end ),        
            },
    },
	State
    {
        name = "run_stop",
        tags = { "idle" },

        onenter = function(inst) 
            inst.components.locomotor:StopMoving()
            inst.AnimState:PlayAnimation("run")
            
        end,
        events =
        {
            EventHandler("animover", function(inst) if inst.AnimState:AnimDone() then inst.sg:GoToState("idle") end end),
        },
    },
   --[[ State{
        name = "moving",
        tags = {"moving", "canrotate"},
        
        onenter = function(inst)
            inst.components.locomotor:RunForward()
            inst.AnimState:PushAnimation("run")
        end,
        
        timeline=
        {
        
            TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound(SoundPath(inst, "walk_spider")) end),
            TimeEvent(3*FRAMES, function(inst) inst.SoundEmitter:PlaySound(SoundPath(inst, "walk_spider")) end),
            TimeEvent(7*FRAMES, function(inst) inst.SoundEmitter:PlaySound(SoundPath(inst, "walk_spider")) end),
            TimeEvent(12*FRAMES, function(inst) inst.SoundEmitter:PlaySound(SoundPath(inst, "walk_spider")) end),
        },
        
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("moving") end),
        },
        
    }, ]]    
	State{
        name = "pickup",
        tags = {"idle", "busy", "pickup"},
        
        onenter = function(inst)
		--print("pickup")
		
		local target=inst.bufferedaction and inst.bufferedaction.target
		--print(target)
            if target then 
                inst.Physics:Stop()
                inst.AnimState:PlayAnimation("atk")
                --inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/dragonfly/suckup")
                if target and not target:HasTag("INLIMBO") then 
				target=target.components.stackable:Get(1)
				target:RemoveFromScene()
				inst.carrieditem = target
                end
            else
                inst.sg:GoToState("idle")
            end
        end,

        onexit = function(inst)
			if inst.pickuptarget then inst.pickuptarget=nil end
            if inst.bufferedaction then
			   inst:ClearBufferedAction()
               --[[inst.bufferedaction:Succeed()
			   inst:PushEvent("actionsuccess", {action = inst.bufferedaction})
               inst.bufferedaction = nil
			   print("pickuponexitworks")]]
		    end
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },

    },
	State{
        name = "give",
        tags = {"idle", "busy", "give"},
        
        onenter = function(inst)
		    --print("onenter state give")
            if inst.carrieditem and inst.components.follower and inst.components.follower.leader and inst.components.follower.leader.components.inventory 
				--and not inst.components.follower.leader.components.inventory:IsFull() 
				and inst.components.follower.leader.components.inventory:CanAcceptCount(inst.carrieditem, inst.carrieditem.components.stackable.stacksize)>0
				then 
                inst.Physics:Stop()
                inst.AnimState:PlayAnimation("atk")
                --inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/dragonfly/suckup")
				inst.SoundEmitter:PlaySound("overlord/drone/drone_deliver")
                if inst.carrieditem and inst.components.follower and inst.components.follower.leader then 
				if TheSim:GetGameID()=="DST" then
				inst.components.follower.leader.components.inventory:GiveItem(inst.carrieditem,nil,inst:GetPosition())
				else
				inst.components.follower.leader.components.inventory:GiveItem(inst.carrieditem,nil,Vector3(TheSim:GetScreenPos(inst.Transform:GetWorldPosition())))
				end
				inst.carrieditem = nil
				--print("given")
                end
            else
                inst.sg:GoToState("idle")
            end
        end,

        onexit = function(inst)
            if inst.bufferedaction then
			   inst:ClearBufferedAction()
               --[[inst.bufferedaction:Succeed()
			   inst:PushEvent("actionsuccess", {action = inst.bufferedaction})
               inst.bufferedaction = nil
			   print("giveonexitworks")]]
		    end
        end,

        events=
        {
            EventHandler("animover", function(inst)  inst.sg:GoToState("idle") end),
        },

    },
	State{
        name = "pick",
        tags = {"idle", "busy", "picking"},
        
        onenter = function(inst)
		inst.sg:SetTimeout(2)
		--print("pickup")
		local target=inst.bufferedaction and inst.bufferedaction.target
		--print(target)
            if target and target.components.pickable:CanBePicked() then 
                inst.Physics:Stop()
                inst.AnimState:PlayAnimation("atk")
				
                --inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/dragonfly/suckup")
                
            else 
			    inst:ClearBufferedAction()
				if inst.pickuptarget then inst.pickuptarget=nil end
                inst.sg:GoToState("idle")
            end
        end,


        events=
        {
            EventHandler("animover", function(inst)  local target=inst.bufferedaction and inst.bufferedaction.target
													if target.components.pickable:CanBePicked() then
													if  inst:PerformBufferedAction() then 
																						local loot=target.prefab=="sapling" and "twigs" or "cutgrass"
																			            if inst.carrieditem then 
																			            target.components.lootdropper:SpawnLootPrefab(loot)
																			            else 
																			            inst.carrieditem=SpawnPrefab(loot)
																						if inst.carrieditem then inst.carrieditem:RemoveFromScene() end
																		                end 
													else
													inst:ClearBufferedAction()
													end 
													end
													inst:ClearBufferedAction()
													if inst.pickuptarget then inst.pickuptarget=nil end
													inst.sg:GoToState("idle") 
									end),
        },

    },
	    State{
        name = "chop",
        tags = {"chopping"},
        
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("atk")
        end,
        
       --[[ timeline=
        {
            
            TimeEvent(13*FRAMES, function(inst) print("timeline13") inst:PerformBufferedAction() end ),
        },]]
        
        events=
        {
            EventHandler("animover", function(inst)  inst:PerformBufferedAction() inst.sg:GoToState("idle") end),
        },
    },
	
	    State{
        name = "mine",
        tags = {"mining"},
        
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("atk")
        end,
        
       --[[ timeline=
        {
            
            TimeEvent(13*FRAMES, function(inst) print("timeline13") inst:PerformBufferedAction() end ),
        },]]
        
        events=
        {
            EventHandler("animover", function(inst)  inst.SoundEmitter:PlaySound("overlord/mine_rock/mine_rock") inst:PerformBufferedAction() inst.sg:GoToState("idle") end),
        },
    },
	
	State
	{
		name = "idle",
		tags = {"idle"},

		onenter = function(inst)
		--print("actualidle")
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("idle",true)
			
		end,

	},

	State{
        name = "frozen",
        tags = {"busy", "frozen"},
        
        onenter = function(inst)
            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end
            inst.AnimState:PlayAnimation("idle")
            inst.SoundEmitter:PlaySound("dontstarve/common/freezecreature")
            inst.AnimState:OverrideSymbol("swap_frozen", "frozen", "frozen")
        end,
        
        onexit = function(inst)
            inst.AnimState:ClearOverrideSymbol("swap_frozen")
        end,
        
        events=
        {   
            EventHandler("onthaw", function(inst) inst.sg:GoToState("thaw") end ),        
        },
    },

    State{
        name = "thaw",
        tags = {"busy", "thawing"},
        
        onenter = function(inst) 
            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end
            inst.AnimState:PlayAnimation("idle", true)
            inst.SoundEmitter:PlaySound("dontstarve/common/freezethaw", "thawing")
            inst.AnimState:OverrideSymbol("swap_frozen", "frozen", "frozen")
            StopFlap(inst)
        end,
        
        onexit = function(inst)
            inst.SoundEmitter:KillSound("thawing")
            inst.AnimState:ClearOverrideSymbol("swap_frozen")
        end,

        events =
        {   
            EventHandler("unfreeze", function(inst)
                if inst.sg.sg.states.hit then
                    inst.sg:GoToState("hit")
                else
                    inst.sg:GoToState("idle")
                end
            end ),
        },
    }, 
   --[[ State{
            name = "sleep",
            tags = {"busy", "sleeping"},
            
            onenter = function(inst) 
			
                inst.components.locomotor:StopMoving()
                inst.AnimState:PlayAnimation("sleep")
              
            end,

            events=
            {   
                EventHandler("animover", function(inst) inst.sg:GoToState("sleep") end ),        
                EventHandler("onwakeup", function(inst) inst.sg:GoToState("idle") end),
            },
    },]]

}

CommonStates.AddSimpleActionState(states, "action", "idle", FRAMES*5, {"busy"})
CommonStates.AddCombatStates(states,
{
	hittimeline = 
	{
		--TimeEvent(0, function(inst) StartFlap(inst) end),
		TimeEvent(0, function(inst)	inst.SoundEmitter:PlaySound("overlord/drone/drone_hit") end)
	},
	deathtimeline = 
	{
		TimeEvent(0, function(inst) if inst.carrieditem then 
                                        local pos = Vector3(inst.Transform:GetWorldPosition())
			                            inst.carrieditem.Transform:SetPosition(pos:Get())
			                            if inst.carrieditem.components.inventoryitem then
			                            	inst.carrieditem.components.inventoryitem:OnDropped(true)
										end
										inst:PushEvent("dropitem", {item = inst.carrieditem})
									end
					end),
		TimeEvent(0, function(inst) inst.SoundEmitter:PlaySound("overlord/drone/drone_die") end),
		--TimeEvent(10*FRAMES, function(inst) StopFlap(inst) end),
	},
}
)

--CommonStates.AddSimpleRunStates(states, "run_loop")
CommonStates.AddSleepStates(states,
{

	waketimeline = {
		TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("overlord/drone/drone_idle") end ),
	},
})


  
return StateGraph("drone", states, events, "idle",actionhandlers)