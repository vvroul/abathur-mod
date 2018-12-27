local assets=
{
	Asset("ANIM", "anim/hydraliskmark.zip"),
}

local function init(inst) 
	
	--local pos = Vector3(inst.Transform:GetWorldPosition())
    local mark=CreateEntity()
	mark.entity:AddTransform()
	mark.entity:AddAnimState()
	mark.entity:AddSoundEmitter()
	if TheSim:GetGameID()=="DST" then 
	mark.entity:AddNetwork()
	end
	mark:AddTag("FX")
	mark:AddTag("NOCLICK")
	mark:AddTag("NOBLOCK")
	mark.AnimState:SetBank("hydraliskmark")
    mark.AnimState:SetBuild("hydraliskmark")
	if TheSim:GetGameID()=="DST" then 
	mark.entity:SetPristine()
    if not TheWorld.ismastersim then
        return mark
    end
	end
	mark.SoundEmitter:PlaySound("hydra/hydra/hydra_mark")
	--inst:AddComponent("locomotor")
	--inst:AddComponent("follower")
	--	local brain = require("brains/hydraliskbrain")
    --inst:SetBrain(brain)
	--inst:SetStateGraph("SGhydralisk")
    --mark.Transform:SetPosition(pos:Get())
	mark.AnimState:PlayAnimation("idle_pre")
	mark.AnimState:PushAnimation("idle",true)
	mark.persists=false
	--SetDebugEntity(mark) 
	--local follower = mark.entity:AddFollower()
    --    follower:FollowSymbol(inst.GUID, "body", 0, 0, 0)
	--	follower:FollowSymbol(inst.GUID, "body", pos.x, pos.y, pos.z)
    mark:DoTaskInTime(4,function(markinst) markinst:Remove() end)
	return mark
	end


return Prefab( "hydraliskmark", init, assets, nil)