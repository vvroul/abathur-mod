DoingAction = Class(BehaviourNode, function(self, inst, getactionfn, name, run)
    BehaviourNode._ctor(self, name or "DoingAction")
    self.inst = inst
    self.shouldrun = run
    self.action = nil
    self.getactionfn = getactionfn
end)

function DoingAction:OnFail()
    self.pendingstatus = SUCCESS
end

function DoingAction:OnSucceed()
    self.pendingstatus = SUCCESS
end


function DoingAction:Visit()
    
    if self.status == READY then
        local action = self.getactionfn(self.inst)
        --if not action then print("noaction in DoingAction") end
        if action then
            action:AddFailAction(function() self:OnFail() end)
            action:AddSuccessAction(function() self:OnSucceed() end)
            self.pendingstatus = nil
            self.inst.components.locomotor:PushAction(action, self.shouldrun)
            self.action = action;
            self.status = RUNNING
        else
		--if action.action then print(action.action) end
		--print("failed first check")
            self.status = FAILED
        end
    end
    
    if self.status == RUNNING then
        if self.pendingstatus then
            self.status = self.pendingstatus
        elseif not self.action:IsValid() then
		--if action.action then print(action.action) end
		--print("failed is valid in do action")
            self.status = SUCCESS
        end
    end
    
end

