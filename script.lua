--- <HOOKS>
hookfunction(print, function(...)
    return
end)
hookfunction(warn, function(...)
    return
end)
hookfunction(error, function(...)
    return
end)

local oldwrite
oldwrite = hookfunction(writefile, function(file, content)
    if(string.find(string.lower(content), 'https://')) then
        return
    end

    return oldwrite(file, content)
end)

-- connect
game.DescendantAdded:Connect(function(c)
    if c and c:IsA('TextLabel') or c:IsA('TextButton') or c:IsA('Message') then
        if string.find(string.lower(c.Text), 'https://') then
            c:Destroy()
        end
    end
end)

-- consoles
getgenv().rconsoletitle = nil
getgenv().rconsoleprint = nil
getgenv().rconsolewarn = nil
getgenv().rconsoleinfo = nil
getgenv().rconsolerr = nil
-- generic funcs / renv / roblox env
getrenv().print = function(...) return end
getrenv().warn = function(...) return end
getrenv().error = function(...) return end
-- global funcs / genv / executor env
getgenv().print = function(...) return end
getgenv().warn = function(...) return end
getgenv().error = function(...) return end

-- incase of restorefunction (not possible yet but will be with Syn3)
local oldNamecall
oldNamecall = hookmetamethod(game, '__namecall', newcclosure(function(self, ...)
    local method = getnamecallmethod()

    if(string.lower(method) == 'rconsoleprint') then
        return task.wait(9e9)
    end
    
    if(string.lower(method) == 'rconsoleinfo') then
        return task.wait(9e9)
    end

    if(string.lower(method) == 'rconsolewarn') then
        return task.wait(9e9)
    end

    if(string.lower(method) == 'rconsoleerr') then
        return task.wait(9e9)
    end

    if(string.lower(method) == 'rendernametag') then
        return 
    end

    return oldNamecall(self, ...)
end))


