require("stategraphs/commonstates")



local events=
{   CommonHandlers.OnSleep(),
	CommonHandlers.OnDeath(),
	CommonHandlers.OnAttacked(),
    EventHandler("doattack", function(inst, data) 
        if not inst.components.health:IsDead() and not inst.sg:HasStateTag("busy") and data and data.target  then 
                inst.sg:GoToState("attack", data.target) 
        end 
    end),
    EventHandler("death", function(inst) inst.sg:GoToState("death") end),
    CommonHandlers.OnLocomote(true,false),
    --CommonHandlers.OnFreeze(),
}

local function sleeponanimover(inst)
    if inst.AnimState:AnimDone() then
        inst.sg:GoToState("sleeping")
    end
end

local function onwakeup(inst)
    inst.sg:GoToState("wake")
end

local function idleonanimover(inst)
    if inst.AnimState:AnimDone() then
        inst.sg:GoToState("idle")
    end
end

local states=
{
    
    
    State{
        name = "death",
        tags = {"busy"},
        
        onenter = function(inst)
		    --GetPlayer():UpdateSanity()
            inst.AnimState:PlayAnimation("death")
            inst.Physics:Stop()
            RemovePhysicsColliders(inst)  
			inst.SoundEmitter:PlaySound("hydra/hydra/hydra_death")
            inst.components.lootdropper:DropLoot(Vector3(inst.Transform:GetWorldPosition()))            
        end,

    },    
  
    State{
        name = "idle",
        tags = {"idle", "canrotate"},
        
        onenter = function(inst, start_anim)
            inst.Physics:Stop()
            local animname = "idle"
            
                if start_anim then
                    inst.AnimState:PlayAnimation(start_anim)
                    inst.AnimState:PushAnimation("idle", true)
                else
                    inst.AnimState:PlayAnimation("idle", true)
                end
            
        end,
    },

    State{
        name = "attack",
        tags = {"attack", "busy"},
        
        onenter = function(inst, target)
            --[[inst.Physics:Stop()
			print("pre")
            inst.components.combat:StartAttack()
			print("post")
            inst.AnimState:PlayAnimation("atk")
            inst.sg.statemem.target = target
			]]
			
			inst.sg.statemem.target = target
            inst.Physics:Stop()
            inst.components.combat:StartAttack()
            --inst.AnimState:PlayAnimation("atk_pre")
            inst.AnimState:PlayAnimation("atk", true)
        end,
        
        timeline=
        {   --TimeEvent(9*FRAMES, function(inst) print("line9") end),
            --TimeEvent(10*FRAMES, function(inst) inst.SoundEmitter:PlaySound(SoundPath(inst, "Attack")) end),
			--TimeEvent(10*FRAMES, function(inst) print("line10") end),
            --TimeEvent(10*FRAMES, function(inst) inst.SoundEmitter:PlaySound(SoundPath(inst, "attack_grunt")) end),
			--TimeEvent(11*FRAMES, function(inst) print("line11") end),
			--TimeEvent(11*FRAMES, function(inst) print("line24") end),
            TimeEvent(12*FRAMES, function(inst) inst.components.combat:DoAttack(inst.sg.statemem.target) end),
			--TimeEvent(26*FRAMES, function(inst) print("line12") end),
        },
        
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State{
        name = "hit",
        
        onenter = function(inst)
            inst.AnimState:PlayAnimation("hit")
            inst.Physics:Stop()     
			inst.SoundEmitter:PlaySound("hydra/hydra/hydra_hit")			
        end,
        
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },    
    
    State{
        name = "hit_stunlock",
        tags = {"busy"},
        
        onenter = function(inst)
            --inst.SoundEmitter:PlaySound(SoundPath(inst, "hit_response"))
            inst.AnimState:PlayAnimation("hit")
			inst.SoundEmitter:PlaySound("hydra/hydra/hydra_hit")
            inst.Physics:Stop()            
        end,
        
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },  
    State{
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
	State
    {
        name = "sleep",
        tags = { "busy", "sleeping" },

        onenter = function(inst)
            if inst.components.locomotor ~= nil then
                inst.components.locomotor:StopMoving()
            end
            inst.AnimState:PlayAnimation("sleep_pre")
        end,

        --timeline = timelines ~= nil and timelines.starttimeline or nil,

        events =
        {
            EventHandler("animover", sleeponanimover),
            EventHandler("onwakeup", onwakeup),
        },
    },
	State
    {
        name = "sleeping",
        tags = { "busy", "sleeping","noattack" },

        onenter = function(inst)
		inst.AnimState:PlayAnimation("sleep_loop")
		
		inst.Physics:ClearCollisionMask()
		inst.Physics:CollidesWith(COLLISION.WORLD)
        inst.Physics:CollidesWith(COLLISION.OBSTACLES)
		
		end,
		onexit=function(inst) ChangeToCharacterPhysics(inst) end,
        --timeline = timelines ~= nil and timelines.sleeptimeline or nil,

        events =
        {
            EventHandler("animover", sleeponanimover),
            EventHandler("onwakeup", onwakeup),
        },
    },
	State
    {
        name = "wake",
        tags = { "busy", "waking" },

        onenter = function(inst)
            if inst.components.locomotor ~= nil then
                inst.components.locomotor:StopMoving()
            end
            inst.AnimState:PlayAnimation("sleep_pst")
            if inst.components.sleeper ~= nil and inst.components.sleeper:IsAsleep() then
                inst.components.sleeper:WakeUp()
            end

        end,

        --timeline = timelines ~= nil and timelines.waketimeline or nil,

        events =
        {
            EventHandler("animover", idleonanimover),
        },
    }
}


--CommonStates.AddFrozenStates(states)

return StateGraph("hydralisk", states, events, "idle", nil)--actionhandlers)

