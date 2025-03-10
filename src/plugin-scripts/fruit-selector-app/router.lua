local rootParent = nil
local defaultSection = nil
local sections = nil

local router = {}
function router.create(rParent, def, sec )
    rootParent = rParent    
    sections = sec
    defaultSection = sections[def]
end

function router.init()    
    defaultSection.Parent = rootParent
end

function router.goToSection(nameSection)
    for key, value in pairs(sections) do
        value.Parent = nil
    end
    
    local sectionToGo = sections[nameSection]
    sectionToGo.Parent = rootParent
end

return router