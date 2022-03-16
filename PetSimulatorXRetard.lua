--[[
This source was from huge games SOME WHAT. Mostly their setting savers are stolen and their method for getting orbs.
I may have skidded when I first started LEARNING lua back in 2020 but i've moved away and actually learn good lua.
I will tell you what is not mine!
Auto Merchants - Huge Games
Autofarm AREA NAMES - Huge Games (Note: Just their way of getting areas was taken)
Send All Pets - Mine & Huge Games Tbh, I merged my method with it and ill give credits to both. Id have to say the lag isn't bad
for a total redo of my script. But I was hoping I could fix their script FULLY but I lost hope after crashing AGAIN
sorry, Ryan
]]--

local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

local Lib = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"))

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local Notify = getsenv(game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Admin Commands"):WaitForChild("Admin Cmds Client")).AddNotification


Connections = {}

local GameLibrary = require(game:GetService("ReplicatedStorage"):WaitForChild("Framework"):WaitForChild("Library"))
local Network = GameLibrary.Network
local Run_Service = game:GetService("RunService")
local rs = Run_Service.RenderStepped
        local CurrencyOrder = {"Rainbow Coins", "Tech Coins", "Fantasy Coins", "Coins"}
--Settings
getgenv().settings = {
saveVersion = saveFileVer,
autoFarming = {
    orbs = false,
    sendAll = false,
    areas = {},
    blacklist = {},
    farmMode = "Normal",
    antiCheatMode = "Wait",
    petSpeed = 10
},
game = {
    autoRankChest = false,
    autoVipChest = false,
    autoUseCoinsBoost = false,
    autoUseDamageBoost = false,
    autoUseLuck = false,
    autoUseSuperLuck = false,
    autoCollectBags = false,
    autoBuyMysterious3 = false,
    autoBuyMysterious2 = false,
    autoBuyMysterious1 = false,
    autoBuyNormal3 = false,
    autoBuyNormal2 = false,
    autoBuyNormal1 = false,
    unlockGamepasses = false,
    antiAfk = false,
    statTrackers = false,
    autoInterest = false,
    autoDepo = false
},
autoEggs = {
    OpenEggs = false,
    Triple = false,
    selectedEggs = {}
},
machines = {
    goldAmount = 6,
    goldString = "6 Pets, 100%",
    goldMythicals = false,
    rainbowAmount = 6,
    rainbowString = "6 Pets, 100%",
    rainbowMythicals = false,
    dmAmount = 6,
    dmString = "6 Pets, 100%",
    dmAutoClaim = false,
    dmEnabled = false,
    dmMythicals = false,
    selectedEnchants = {}
},
colection = {
    trippleHatch = false,
    ignoreDarkMatter = false,
    ignoreRainbow = false,
    ignoreGold = false,
    ignoreNormal = false,
    ignoreMythicals = false
},
guis = {
    keycodes = {}
}
}
local tempSettings
local function resetTempSettings()
tempSettings = {
    autoFarming = {
        enabled = false
    },
    autoEggs = {
        enabled = true
    },
    machines = {
        goldEnabled = false,
        rainbowEnabled = false,
        enchantingEquipped = false,
        enchantingNamed = false,
        autoFuse = false
    },
    colection = {
        deleteEnabled = false,
        openEnabled = false
    }
}
end
resetTempSettings()

--saving


function recurseTable(tbl, i1, i2)
for index, value in pairs(tbl) do
    if type(value) == 'table' then
        if i2 then
            getgenv().settings[i1][i2][index] = value
        elseif i1 then
            recurseTable(value, i1, index)
        elseif value then
            recurseTable(value, index)
        end
    else
        if i2 then
            getgenv().settings[i1][i2][index] = value
        elseif i1 then
            getgenv().settings[i1][index] = value
        end
    end
end
end

local function loadSettings()
if(isfile and readfile) then
    if(isfile("GhostHubBeta.json")) then
        data = HttpService:JSONDecode(readfile("GhostHubBeta.json"))
        recurseTable(data)
        Lib.Signal.Fire("Notification", "Loaded Data From Save File", {
            color = Color3.fromRGB(104, 244, 104)
        })
        if not (data["saveVersion"] == getgenv().settings["saveVersion"]) then
            writefile("PSX4lve.json", (HttpService:JSONEncode(getgenv().settings)))
            Lib.Signal.Fire("Notification", "Migrated Save File To Newer Version", {
                color = Color3.fromRGB(104, 244, 104)
            })
        end
    end
end
end
succ, err = pcall(loadSettings)
if err then
Notify("Could Not Load Save File")
print(err)
print(succ)
end

local function saveSettings()
if(writefile and isfile) then
    writefile("GhostHubBeta.json", (HttpService:JSONEncode(getgenv().settings))) 
end
end

local function deleteSettings()
if(isfile and delfile) then
    if(isfile("GhostHubBeta.json")) then
        delfile("PSX.json")
        Lib.Signal.Fire("Notification", "Successfully Deleted Save File", {
            color = Color3.fromRGB(104, 244, 104)
        })
    else
        Lib.Signal.Fire("Notification", "Save File Dosen't Exist", {
            color = Color3.fromRGB(237, 22, 22)
        })
    end
end
end

--Global Functions

local function deleteArrayValue(whichArray, itemName)
for i,v in pairs(whichArray) do
    if (v == itemName) then
        table.remove(whichArray, i)
        return true
    end
end
return false
end

local function deleteArrayValueThatIsTable(whichArray, itemName, path)
for i,v in pairs(whichArray) do
    if (v == itemName[path]) then
        table.remove(whichArray, i)
        return true
    end
end
return false
end
local function FindArrayValueThatIsTable(whichArray, itemName, path)
for i,v in pairs(whichArray) do
    if (v == itemName[path]) then
        return true
    end
end
return false
end

local function enchantArrayFind(whichArray, itemName)
for i,v in ipairs(whichArray) do
    if (v["Enchant"] == itemName["Enchant"] and v["Enchant Number"] == itemName["Enchant Number"]) then
        return true
    end
end
return false
end

local function enchantArrayRemove(whichArray, itemName)
for i,v in ipairs(whichArray) do
    if (v["Enchant"] == itemName["Enchant"] and v["Enchant Number"] == itemName["Enchant Number"]) then
        table.remove(whichArray, i)
        return true
    end
end
return false
end

local function getLengthOfTable(Table)
local counter = 0 
for _, v in pairs(Table) do
    counter = counter + 1
end
return counter
end



--Return Coins Array
function getCoinArray()
local coinData = {}
local CD = Lib.Network.Invoke("Get Coins")
for i, data in pairs(CD) do
    --check coins data matching
    matched = false
    for ie, ve in ipairs(getgenv().settings.autoFarming.areas) do
        if (ve == data.a) then
              matched = true
            break
        end
    end
    for ie, ve in ipairs(getgenv().settings.autoFarming.blacklist) do
        if (ve == data.n) then
            matched = false
            break
        end
    end
    if matched then
        table.insert(coinData, i)
    end
end

if (getgenv().settings.autoFarming.farmMode == "Highest Health") then
    --Max
    table.sort(coinData, function(a, b)
        return ((CD[a]["h"]) > (CD[b]["h"]))
    end)
    
elseif (getgenv().settings.autoFarming.farmMode == "Highest Max Health") then
    --Min
    table.sort(coinData, function(a, b)
        
        return (CD[a]["mh"] > CD[b]["mh"])
    end)
elseif (getgenv().settings.autoFarming.farmMode == "Diamonds First") then
    --Diamonds First
    table.sort(coinData, function(a, b)
        aNum = 0
        bNum = 0

        if string.match(CD[a]["n"], "Diamond") then
            aNum = 3
        end
        if string.match(CD[b]["n"], "Diamond") then
            bNum = 3
        end

        return (aNum > bNum)
    end)
end

return coinData
end


workspace.__THINGS.__REMOTES.MAIN:FireServer("b", "buy egg")
local allAreas = {}
--Update Areas Array
function getAreas()
allAreas = {}
worlds = game:GetService("ReplicatedStorage").Framework.Modules["1 | Directory"].Areas:GetChildren()
for i,v in ipairs(worlds) do
    for ie,ve in pairs(require(v)) do
        table.insert(allAreas, {
            ["area"] = ie,
            ["world"] = v.Name
        })
    end
end
end
getAreas()

--Update Equipped Pets Array
local equippedPets = {}
function getPets()
equippedPets = {}
local Pets = Lib.Save.Get().Pets
for i, v in pairs(Pets) do
    if v.e then
        table.insert(equippedPets, v.uid)
    end
end
end
getPets()

--Auto Orbs
spawn(function()
local orbsBuffer = {}
spawn(function()
    table.insert(Connections, Lib.Network.Fired("Orb Added"):Connect(function(orbID)
        if getgenv().settings.autoFarming.orbs then
            table.insert(orbsBuffer, orbID)
        end
    end))
end)
while wait(math.random(3,5)) do
    if ((#orbsBuffer > 0) and getgenv().settings.autoFarming.orbs) then
        Lib.Network.Fire("claim orbs", orbsBuffer)
        orbsBuffer = {}
    end
end
end)
--Send Pet Function
function sendPet(coinID, petID)
Lib.Network.Fire("change pet target", petID, "Coin", coinID)
Lib.Network.Fire("farm coin", coinID, petID)
end

local petsFarming = {}


--Auto Farm
function startAutoFarm()
getPets()
coinTargetNum = 1
coinTable = getCoinArray()
if getgenv().settings.autoFarming.sendAll then
    if coinTable[coinTargetNum] then
        if not petsFarming[equippedPets[1]] or not table.find(coinTable, petsFarming[equippedPets[1]]) then
            Lib.Network.Invoke("join coin", coinTable[coinTargetNum], equippedPets)
            for i,v in ipairs(equippedPets) do
                sendPet(coinTable[coinTargetNum], v)
                petsFarming[v] = coinTable[coinTargetNum]
            end
        end
    end
else
    if coinTable[coinTargetNum] then
        for i,v in ipairs(equippedPets) do
            if not petsFarming[v] or not table.find(coinTable, petsFarming[v]) then
                if (tempSettings.autoFarming.enabled) and coinTable[coinTargetNum] then
                    Lib.Network.Invoke("join coin", coinTable[coinTargetNum], {v})
                    sendPet(coinTable[coinTargetNum], v)
                    petsFarming[v] = coinTable[coinTargetNum]
                    coinTargetNum = coinTargetNum + 1
                    if not (getgenv().settings.autoFarming.antiCheatMode == "None") then
                        wait()
                    end
                end
            else

            end
        end
    end
end
end

-- Mercury Ui Lib Is Best
local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()

local ChooseGUI = Mercury:Create{
Name = "Mercury",
Size = UDim2.fromOffset(500, 300),
Theme = Mercury.Themes.Dark,
Link = "https://github.com/deeeity/mercury-lib"
}

ChooseGUI:Prompt{
Followup = false,
Title = "Prompt",
Text = "Prompts are cool",
Buttons = {
    FarmerVer = function()
        FarmerVer()
    end,
    FullVer = function()
        MainVers()
    end
}
}
function MainVers()
local GUI = Mercury:Create{
    Name = "Mercury",
    Size = UDim2.fromOffset(800, 500),
    Theme = Mercury.Themes.Dark,
    Link = "https://github.com/deeeity/mercury-lib"
}
local Essentials = GUI:Tab{
    Name = "Essentials",
    Icon = "rbxassetid://6035053288"
}
local Autofarm = GUI:Tab{
    Name = "Autofarm",
    Icon = "rbxassetid://6034837803"
}
local Areas = GUI:Tab{
    Name = "Select Areas",
    Icon = "rbxassetid://6035078913"
}
local Eggs = GUI:Tab{
    Name = "Pets",
    Icon = "rbxassetid://6034470803"
}


Essentials:Button{
    Name = "--Merchant Section--",
    Callback = function()
        print("")
    end
}
Essentials:Toggle{
    Name = "AutoBuy Mystery Merchant Tier 1",
    StartingState = getgenv().settings.game.autoBuyMysterious1,
    Callback = function(Vals)
        getgenv().settings.game.autoBuyMysterious1 = Vals
    end
}
spawn(function()
    while true do wait()
        table.insert(Connections, Lib.Network.Fired("Merchant Arrival"):Connect(function(isMysterious)
            if (getgenv().settings.game.autoBuyMysterious1) then
                if (isMysterious) then
                    for i = 1, 10 do
                        Lib.Network.Invoke("buy merchant item", 1)
                    end
                end
            end
        end))
    end
end)
Essentials:Toggle{
    Name = "AutoBuy Mystery Merchant Tier 2",
    StartingState = getgenv().settings.game.autoBuyMysterious2,
    Callback = function(Vals)
        getgenv().settings.game.autoBuyMysterious2 = Vals
    end
}
spawn(function()
    while true do wait()
        table.insert(Connections, Lib.Network.Fired("Merchant Arrival"):Connect(function(isMysterious)
            if (getgenv().settings.game.autoBuyMysterious2) then
                if (isMysterious) then
                    for i = 1, 10 do
                        Lib.Network.Invoke("buy merchant item", 2)
                    end
                end
            end
        end))
    end
end)
Essentials:Toggle{
    Name = "AutoBuy MysteryMerchant Tier 3",
    StartingState = getgenv().settings.game.autoBuyMysterious3,
    Callback = function(Vals)
        getgenv().settings.game.autoBuyMysterious3 = Vals
    end
}
spawn(function()
    while true do wait()
        table.insert(Connections, Lib.Network.Fired("Merchant Arrival"):Connect(function(isMysterious)
            if (getgenv().settings.game.autoBuyMysterious3) then
                if (isMysterious) then
                    for i = 1, 10 do
                        Lib.Network.Invoke("buy merchant item", 3)
                    end
                end
            end
        end))
    end
end)
Essentials:Button{
    Name = "--Normal Merchant--",
    Callback = function()
        print("")
    end
}
Essentials:Toggle{
    Name = "AutoBuy Merchant Tier 1",
    StartingState = getgenv().settings.game.autoBuyNormal1,
    Callback = function(Vals)
        getgenv().settings.game.autoBuyNormal1 = Vals
    end
}
spawn(function()
    while true do wait()
        table.insert(Connections, Lib.Network.Fired("Merchant Arrival"):Connect(function(isMysterious)
            if (getgenv().settings.game.autoBuyNormal1) then
                if (not isMysterious) then
                    for i = 1, 10 do
                        Lib.Network.Invoke("buy merchant item", 1)
                    end
                end
            end
        end))
    end
end)

Essentials:Toggle{
Name = "AutoBuy Merchant Tier 2",
StartingState = getgenv().settings.game.autoBuyNormal2,
Callback = function(Vals)
    getgenv().settings.game.autoBuyNormal2 = Vals
end
}
spawn(function()
while true do wait()
    table.insert(Connections, Lib.Network.Fired("Merchant Arrival"):Connect(function(isMysterious)
        if (getgenv().settings.game.autoBuyNormal2) then
            if (not isMysterious) then
                for i = 1, 10 do
                    Lib.Network.Invoke("buy merchant item", 2)
                end
            end
        end
    end))
end
end)
Essentials:Toggle{
Name = "AutoBuy Merchant Tier 3",
StartingState = getgenv().settings.game.autoBuyNormal3,
Callback = function(Vals)
    getgenv().settings.game.autoBuyNormal3 = Vals
end
}
spawn(function()
while true do wait()
    table.insert(Connections, Lib.Network.Fired("Merchant Arrival"):Connect(function(isMysterious)
        if (getgenv().settings.game.autoBuyNormal3) then
            if (not isMysterious) then
                for i = 1, 10 do
                    Lib.Network.Invoke("buy merchant item", 3)
                end
            end
        end
    end))
end
end)
Essentials:Button{
Name = "-- Buy Once From Merchants --"
}
Essentials:Button{
Name = "Buy All Tier 1",
Callback = function()
    for i = 1, 10 do
        Lib.Network.Invoke("buy merchant item", 1)
    end
end
}
Essentials:Button{
Name = "Buy All Tier 2",
Callback = function()
    for i = 1, 10 do
        Lib.Network.Invoke("buy merchant item", 2)
    end
end
}
Essentials:Button{
Name = "Buy All Tier 3",
Callback = function()
    for i = 1, 10 do
        Lib.Network.Invoke("buy merchant item", 3)
    end
end
}
Essentials:Button{
Name = "-- Auto Boosts --"
}
--Auto Use Booost
Essentials:Toggle{
    Name = "3x Coin Boost",
    StartingState = getgenv().settings.game.autoUseCoinsBoost,
    Callback = function(Vals)
        getgenv().settings.game.autoUseCoinsBoost = Vals
    end
}
spawn(function()
    while true do wait(0.2)
        if getgenv().settings.game.autoUseCoinsBoost then
            if Lib.Save.Get()["Boosts"]["Triple Coins"] then
                if Lib.Save.Get()["Boosts"]["Triple Coins"] < 60 then
                    Lib.Network.Fire("activate boost", "Triple Coins")
                    wait(5)
                end
            else
                Lib.Network.Fire("activate boost", "Triple Coins")
                wait(5)
            end
            wait(1)
        end
    end
end)
Essentials:Toggle{
    Name = "3x Damage Boost",
    StartingState = getgenv().settings.game.autoUseDamageBoost,
    Callback = function(Vals)
        getgenv().settings.game.autoUseDamageBoost = Vals
    end
}
spawn(function()
    while true do wait()
        if getgenv().settings.game.autoUseDamageBoost then
            if Lib.Save.Get()["Boosts"]["Triple Damage"] then
                if Lib.Save.Get()["Boosts"]["Triple Damage"] < 61 then
                    Lib.Network.Fire("activate boost", "Triple Damage")
                    wait(5)
                end
            else
                Lib.Network.Fire("activate boost", "Triple Damage")
                wait(5)
            end
        end
    end
end)
Essentials:Toggle{
    Name = "Normal Luck Booster",
    StartingState = getgenv().settings.game.autoUseLuck,
    Callback = function(Vals)
        getgenv().settings.game.autoUseLuck = Vals
    end
}
spawn(function()
    while true do wait()
        if  getgenv().settings.game.autoUseLuck then
            if Lib.Save.Get()["Boosts"]["Super Lucky"] then
                if Lib.Save.Get()["Boosts"]["Super Lucky"] < 61 then
                    Lib.Network.Fire("activate boost", "Super Lucky")
                    wait(5)
                end
            else
                Lib.Network.Fire("activate boost", "Super Lucky")
                wait(5)
            end
        end
    end
end)
Essentials:Toggle{
    Name = "Ultra Luck Boost",
    StartingState = getgenv().settings.game.autoUseSuperLuck,
    Callback = function(Vals)
        getgenv().settings.game.autoUseSuperLuck = Vals
    end
}
spawn(function()
    while true do wait()
        if getgenv().settings.game.autoUseSuperLuck then
            if Lib.Save.Get()["Boosts"]["Ultra Lucky"] then
                if Lib.Save.Get()["Boosts"]["Ultra Lucky"] < 61 then
                    Lib.Network.Fire("activate boost", "Ultra Lucky")
                    wait(5)
                end
            else
                Lib.Network.Fire("activate boost", "Ultra Lucky")
                wait(5)
            end
            wait(1)
        end
    end
end)



Autofarm:Toggle{
Name = "Autofarm",
StartingState = tempSettings.autoFarming.enabled,
Callback = function(Vals)
    tempSettings.autoFarming.enabled = Vals
end
}
spawn(function()
while true do wait()
    if tempSettings.autoFarming.enabled then
        startAutoFarm()
    else
        petsFarming = {}
    end
end
end)
Autofarm:Toggle{
    Name = "Collect Loot Bags",
    StartingState = getgenv().settings.game.autoCollectBags,
    Callback = function(Vals)
        getgenv().settings.game.autoCollectBags = Vals
    end
}
spawn(function()
while true do wait(0.2)
    if getgenv().settings.game.autoCollectBags then
        for i,v in pairs(game:GetService("Workspace")["__THINGS"].Lootbags:GetChildren()) do
            if(v:GetAttribute("ReadyForCollection")) then
                if not v:GetAttribute("Collected") then
                    getsenv(game:GetService("Players").LocalPlayer.PlayerScripts.Scripts.Game.Lootbags).Collect(v)
                end
            end
        end
    end
end
end)
Autofarm:Toggle{
Name = "Collect Orbs",
StartingState = getgenv().settings.autoFarming.orbs,
Callback = function(Vals)
    getgenv().settings.autoFarming.orbs = Vals
end
}
spawn(function()
game:GetService("Players").LocalPlayer.PlayerScripts.Scripts.Game.Orbs.Disabled = true
if getgenv().settings.autoFarming.orbs then
    --Disable Script
    game:GetService("Players").LocalPlayer.PlayerScripts.Scripts.Game.Orbs.Disabled = true
    wait(2)
    --Claim All Existing Orbs
    Lib.Network.Fire("claim orbs", (game:GetService("Workspace")["__THINGS"].Orbs:GetChildren()))
    for i,v in pairs(game:GetService("Workspace")["__THINGS"].Orbs:GetChildren()) do
        v:Destroy()
    end
    for i,v in pairs(game:GetService("Workspace")["__DEBRIS"]:GetChildren()) do
        if(v.name == "RewardBillboard") then
            v:Destroy()
        end
    end
else
    game:GetService("Players").LocalPlayer.PlayerScripts.Scripts.Game.Orbs.Disabled = true
end
end)
--Send All Pets
Autofarm:Toggle{
Name = "Full Team Send",
StartingState = getgenv().settings.autoFarming.sendAll,
Callback = function(Vals)
    getgenv().settings.autoFarming.sendAll = Vals
end
}
if getgenv().settings.autoFarming.sendAll then
getgenv().settings.autoFarming.sendAll = true
else
getgenv().settings.autoFarming.sendAll = false
end
Autofarm:Dropdown{
Name = "Farming Type",
StartingText = getgenv().settings.autoFarming.farmMode,
Description = nil,
Items = {"Normal", "Highest Health", "Highest Max Health", "Diamonds First"},
Callback = function(Mode)
    getgenv().settings.autoFarming.farmMode = Mode
end
}
Autofarm:Button{
Name = "-- Using Save Settings Effects ALL SETTINGS FOR ALL VERSIONS --"
}
Autofarm:Button{
Name = "Save Settings",
Callback = function()
    saveSettings()
end
}
--AutoFarm Areas

table.sort(allAreas, function(a, b)
    return a.area < b.area
end)

tempAreaArray = {}
for i,v in ipairs(allAreas) do
    if not (tempAreaArray[v.world]) then
        Areas:Toggle{
            Name = v.area, FindArrayValueThatIsTable((getgenv().settings.autoFarming.areas), v, "area"),
            Callback = function(isToggled)
            if isToggled then
                deleteArrayValueThatIsTable(getgenv().settings.autoFarming.areas, v, "area")
                table.insert(getgenv().settings.autoFarming.areas, v.area)
            end
        end
    }
    else
        Areas:Toggle{
            Name = v.area, FindArrayValueThatIsTable((getgenv().settings.autoFarming.areas), v, "area"), 
            Callback = function(isToggled)
            if isToggled then
                deleteArrayValueThatIsTable(getgenv().settings.autoFarming.areas, v, "area")
                table.insert(getgenv().settings.autoFarming.areas, v.area)
            end
            end
    }
    end
end

    Eggs:Button{
        Name = "-- Hatching Section --"
    }


local MyEggData = {}
local littleuselesstable = {}
local GameLibrary = require(game:GetService("ReplicatedStorage"):WaitForChild("Framework"):WaitForChild("Library"))
for i,v in pairs(GameLibrary.Directory.Eggs) do
    local temptable = {}
    temptable['Name'] = i
    temptable['Currency'] = v.currency
    temptable['Price'] = v.cost
    table.insert(MyEggData, temptable)
end

table.sort(MyEggData, function(a, b)
    return a.Price < b.Price
end)

local EggData = {}
for i,v in pairs(CurrencyOrder) do
    table.insert(EggData, " ")
    table.insert(EggData, "-- "..v.." --")
    for a,b in pairs(MyEggData) do
        if b.Currency == v then
            table.insert(EggData, b.Name)
        end
    end
end
Eggs:Toggle{
    Name = "Open Eggs",
    StartingState = getgenv().settings.autoEggs.OpenEggs,
    Callback = function(Vals)
        getgenv().settings.autoEggs.OpenEggs = Vals
    end
}
spawn(function()
	while true do wait()
		if getgenv().settings.autoEggs.OpenEggs then
        local ohTable1 = {
            [1] = getgenv().settings.autoEggs.selectedEggs,
            [2] = getgenv().settings.autoEggs.Triple
        }
        workspace.__THINGS.__REMOTES["buy egg"]:InvokeServer(ohTable1)
        wait (0.5)
	end
end
end)
Eggs:Toggle{
    Name = "Triple - Requires Gp",
    StartingState = getgenv().settings.autoEggs.Triple,
    Callback = function(Vals)
        getgenv().settings.autoEggs.Triple = Vals
    end
}
Eggs:Textbox{
	Name = "Textbox",
	Callback = function(text)
		getgenv().settings.autoEggs.selectedEggs = text
	end	
}
Eggs:Button{
	Name = " To Get Goldens, Put Golden In Front Of The Egg Name "
}

Eggs:Button{
    Name = "Remove Egg Animation",
    Callback = function()
        for i,v in pairs(getgc(true)) do
            if (typeof(v) == 'table' and rawget(v, 'OpenEgg')) then
                v.OpenEgg = function()
                    return
                end
            end
        end
    end
}


    end
function FarmerVer()

local GUI = Mercury:Create{
Name = "Mercury",
Size = UDim2.fromOffset(1000, 500),
Theme = Mercury.Themes.Dark,
Link = "https://github.com/deeeity/mercury-lib"
}
local Autofarm = GUI:Tab{
Name = "Autofarm",
Icon = "rbxassetid://6034837803"
}
local Areas = GUI:Tab{
Name = "Select Areas",
Icon = "rbxassetid://6035078913"
}

Autofarm:Toggle{
    Name = "Collect Loot Bags",
    StartingState = getgenv().settings.game.autoCollectBags,
    Callback = function(Vals)
        getgenv().settings.game.autoCollectBags = Vals
    end
}
spawn(function()
while true do wait(0.2)
    if getgenv().settings.game.autoCollectBags then
        for i,v in pairs(game:GetService("Workspace")["__THINGS"].Lootbags:GetChildren()) do
            if(v:GetAttribute("ReadyForCollection")) then
                if not v:GetAttribute("Collected") then
                    getsenv(game:GetService("Players").LocalPlayer.PlayerScripts.Scripts.Game.Lootbags).Collect(v)
                end
            end
        end
    end
end
end)


Autofarm:Toggle{
Name = "Autofarm",
StartingState = tempSettings.autoFarming.enabled,
Callback = function(Vals)
    tempSettings.autoFarming.enabled = Vals
end
}
spawn(function()
while true do wait()
    if tempSettings.autoFarming.enabled then
        startAutoFarm()
    else
        petsFarming = {}
    end
end
end)
Autofarm:Toggle{
Name = "Collect Orbs",
StartingState = getgenv().settings.autoFarming.orbs,
Callback = function(Vals)
    getgenv().settings.autoFarming.orbs = Vals
end
}
spawn(function()
    game:GetService("Players").LocalPlayer.PlayerScripts.Scripts.Game.Orbs.Disabled = true
if getgenv().settings.autoFarming.orbs then
    --Disable Script
    game:GetService("Players").LocalPlayer.PlayerScripts.Scripts.Game.Orbs.Disabled = true
    wait(2)
    --Claim All Existing Orbs
    Lib.Network.Fire("claim orbs", (game:GetService("Workspace")["__THINGS"].Orbs:GetChildren()))
    for i,v in pairs(game:GetService("Workspace")["__THINGS"].Orbs:GetChildren()) do
        v:Destroy()
    end
    for i,v in pairs(game:GetService("Workspace")["__DEBRIS"]:GetChildren()) do
        if(v.name == "RewardBillboard") then
            v:Destroy()
        end
    end
else
    game:GetService("Players").LocalPlayer.PlayerScripts.Scripts.Game.Orbs.Disabled = true
end
end)
--Send All Pets
Autofarm:Toggle{
Name = "Full Team Send",
StartingState = getgenv().settings.autoFarming.sendAll,
Callback = function(Vals)
    getgenv().settings.autoFarming.sendAll = Vals
end
}
if getgenv().settings.autoFarming.sendAll then
getgenv().settings.autoFarming.sendAll = true
else
getgenv().settings.autoFarming.sendAll = false
end
Autofarm:Dropdown{
Name = "Farming Type",
StartingText = getgenv().settings.autoFarming.farmMode,
Description = nil,
Items = {"Normal", "Highest Health", "Highest Max Health", "Diamonds First"},
Callback = function(Mode)
    getgenv().settings.autoFarming.farmMode = Mode
end
}
Autofarm:Button{
Name = "-- Using Save Settings Effects ALL SETTINGS FOR ALL VERSIONS --"
}
Autofarm:Button{
Name = "Save Settings",
Callback = function()
    saveSettings()
end
}
--AutoFarm Areas

table.sort(allAreas, function(a, b)
    return a.area < b.area
end)

tempAreaArray = {}
for i,v in ipairs(allAreas) do
    if not (tempAreaArray[v.world]) then
        Areas:Toggle{
            Name = v.area, FindArrayValueThatIsTable((getgenv().settings.autoFarming.areas), v, "area"),
            Callback = function(isToggled)
            if isToggled then
                deleteArrayValueThatIsTable(getgenv().settings.autoFarming.areas, v, "area")
                table.insert(getgenv().settings.autoFarming.areas, v.area)
            end
        end
    }
    else
        Areas:Toggle{
            Name = v.area, FindArrayValueThatIsTable((getgenv().settings.autoFarming.areas), v, "area"), 
            Callback = function(isToggled)
            if isToggled then
                deleteArrayValueThatIsTable(getgenv().settings.autoFarming.areas, v, "area")
                table.insert(getgenv().settings.autoFarming.areas, v.area)
            end
            end
    }
    end
end
end
