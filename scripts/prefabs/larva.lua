local assets=
{
	Asset("ANIM", "anim/larva.zip"),
	Asset( "IMAGE", "images/inventoryimages/larva.tex"),
    Asset( "ATLAS", "images/inventoryimages/larva.xml"),
	Asset( "IMAGE", "images/inventoryimages/larva_drone.tex"),
    Asset( "ATLAS", "images/inventoryimages/larva_drone.xml"),
	Asset( "IMAGE", "images/inventoryimages/larva_overlord.tex"),
    Asset( "ATLAS", "images/inventoryimages/larva_overlord.xml"),
	Asset( "IMAGE", "images/inventoryimages/larva_hydra.tex"),
    Asset( "ATLAS", "images/inventoryimages/larva_hydra.xml"),
}



--[[local function SpawnLing()
--if inst==GetPlayer() then
	    SpawnPrefab("Zergling").Transform:SetPosition(act.doer.Transform:GetWorldPosition())
	--end
	return true
end]]



local function fn()
local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	if TheSim:GetGameID()=="DST" then 
	inst.entity:AddNetwork()
	end
    MakeInventoryPhysics(inst)
    
	--inst.AnimState:SetBank("pan_flute")
    --inst.AnimState:SetBuild("pan_flute")
	
    inst.AnimState:SetBank("larva")
    inst.AnimState:SetBuild("larva")
    inst.AnimState:PlayAnimation("idle",true)
	
	if TheSim:GetGameID()=="DST" then 
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	end
	
    inst:AddComponent("inspectable")
    
    inst:AddComponent("stackable")
    
    inst:AddComponent("inventoryitem")

    return inst
end

local function zergling()
local inst=fn()
    if TheSim:GetGameID()=="DST" then 
    if not TheWorld.ismastersim then
        return inst
    end
	end
inst.components.inventoryitem.atlasname = "images/inventoryimages/larva.xml"
inst:AddComponent("spawnable")
return inst
end

local function drone()
local inst=fn()
	if TheSim:GetGameID()=="DST" then 
    if not TheWorld.ismastersim then
        return inst
    end
	end
inst.components.inventoryitem.atlasname = "images/inventoryimages/larva_drone.xml"
inst:AddComponent("spawnable")
return inst
end

local function overlord()
local inst=fn()
	if TheSim:GetGameID()=="DST" then 
    if not TheWorld.ismastersim then
        return inst
    end
	end
inst.components.inventoryitem.atlasname = "images/inventoryimages/larva_overlord.xml"
inst:AddComponent("spawnable")
return inst
end

local function hydralisk()
local inst=fn()
	if TheSim:GetGameID()=="DST" then 
    if not TheWorld.ismastersim then
        return inst
    end
	end
inst.components.inventoryitem.atlasname = "images/inventoryimages/larva_hydra.xml"
inst:AddComponent("spawnable")
return inst
end


return Prefab( "common/inventory/larva", zergling, assets),
       Prefab( "common/inventory/larva_drone", drone, assets),
	   Prefab( "common/inventory/larva_hydra", hydralisk, assets),
	   Prefab( "common/inventory/larva_overlord", overlord, assets)
	   

