local Fusion = require(script.Parent.Parent.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.Parent.Parent.packages.OnyxUI)

return function(Scope: Fusion.Scope<any>, Props)
	local Util = OnyxUI.Util
	local InnerScope = Fusion.innerScope
	local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
    local peek = Fusion.peek

    local titleSlot = Scope:Frame {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Blue["500"],
        [Fusion.Children] = {
            Props.Title
        }
    }

    local messageSlot = Scope:Frame {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 30),
        BackgroundColor3 = Util.Colors.Blue["500"],
        PaddingLeft = UDim.new(0, 20),
        [Fusion.Children] = Scope:Computed(function(use)
            if peek(use(Props.ShowConfirm)) then
                return { Props.ConfirmMessage }
            elseif peek(use(Props.ShowComplete)) then
                return { Props.CompleteMessage }
            else
                return { }
            end
        end)
    }

    local parentFrame = Scope:Frame {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Blue["500"],
        PaddingLeft = UDim.new(0, 20),
        [Fusion.Children] = {
            titleSlot,
            messageSlot
        }
    }

	return parentFrame
end
