
wait()
local start = tick()
repeat task.wait() until game:isLoaded()
repeat task.wait() until game:GetService("Players")
repeat task.wait() until game:GetService("Players").LocalPlayer
repeat task.wait() until game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
repeat task.wait() until game:GetService("Players").LocalPlayer.PlayerGui.Main.Enabled
repeat task.wait() until game:GetService("Workspace"):FindFirstChild('__MAP')


    -- Pet Simulator Script!
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
local GameLibrary = require(game:GetService("ReplicatedStorage"):WaitForChild("Framework"):WaitForChild("Library"))
local Network = GameLibrary.Network
local Run_Service = game:GetService("RunService")
local rs = Run_Service.RenderStepped
local psxLib = require(game:GetService('ReplicatedStorage').Framework.Library)
local CurrencyOrder = {"Rainbow Coins","Tech Coins", "Fantasy Coins", "Coins",}
local Location = {}
for i,v in pairs(game:GetService("ReplicatedStorage").Game.Coins.Axolotl:GetChildren()) do
    table.insert(Location, v.Name)
end
    local IMightKillMyselfCauseOfThis = {
        --Misc
        ['VIP'] = {'VIP'};
        --Spawn
        ['Town'] = {'Town', 'Town FRONT'}; ['Forest'] = {'Forest', 'Forest FRONT'}; ['Beach'] = {'Beach', 'Beach FRONT'}; ['Mine'] = {'Mine', 'Mine FRONT'}; ['Winter'] = {'Winter', 'Winter FRONT'}; ['Glacier'] = {'Glacier', 'Glacier Lake'}; ['Desert'] = {'Desert', 'Desert FRONT'}; ['Volcano'] = {'Volcano', 'Volcano FRONT'};
        -- Fantasy init
        ['Enchanted Forest'] = {'Enchanted Forest', 'Enchanted Forest FRONT'}; ['Ancient'] = {'Ancient'}; ['Samurai'] = {'Samurai', 'Samurai FRONT'}; ['Candy'] = {'Candy'}; ['Haunted'] = {'Haunted', 'Haunted FRONT'}; ['Hell'] = {'Hell'}; ['Heaven'] = {'Heaven'};
        -- Tech
        ['Ice Tech'] = {'Ice Tech'}; ['Tech City'] = {'Tech City'; 'Tech City FRONT'}; ['Dark Tech'] = {'Dark Tech'; 'Dark Tech FRONT'}; ['Steampunk'] = {'Steampunk'; 'Steampunk FRONT'}, ['Alien Forest'] = {"Alien Forest"; "Alien Forest FRONT"}, ['Alien Lab'] = {"Alien Forest"; "Alien Lab FRONT"}, ['Glitch'] = {"Glitch";"Glitch FRONT"}, ["Hacker Portal"] = {"Hacker Portal", "Hacker Portal FRONT"};
        -- Axolotl
        ['Axolotl Ocean'] = {'Axolotl Ocean'; 'Axolotl Ocean FRONT'}; ['Axolotl Deep Ocean'] = {'Axolotl Deep Ocean'; 'Axolotl Deep Ocean FRONT'}; ['Axolotl Cave'] = {'Axolotl Cave'; 'Axolotl Cave FRONT'};
    }


    local AreaSpawn = {
        'All'; 'VIP';
        'Town'; 'Forest'; 'Beach'; 'Mine'; 'Winter'; 'Glacier'; 'Desert'; 'Volcano';
    }
    
    local AreaFantasy = {
        'Enchanted Forest'; 'Ancient'; 'Samurai'; 'Candy'; 'Haunted'; 'Hell'; 'Heaven';
    }
    local AreaTech = {
        'Ice Tech'; 'Tech City'; 'Dark Tech'; 'Steampunk'; 'Alien Lab'; 'Alien Forest';
        'Glitch'; 'Hacker Portal';
    }
    local AreaAxolotl = {
        'Axolotl Ocean';'Axolotl Deep Ocean';'Axolotl Cave';
    }
    local Chests = {
        "All";
        -- Spawn
        "Magma Chest",
        -- Fantasy
        "Enchanted Chest", "Hell Chest", "Haunted Chest", "Angel Chest", "Grand Heaven Chest",
        -- Tech
        "Giant Tech Chest"; "Giant Steampunk Chest"; "Giant Alien Chest";
        -- Axolotl
        "Giant Ocean Chest";
    }

workspace.__THINGS.__REMOTES.MAIN:FireServer("b", "buy egg")
workspace.__THINGS.__REMOTES.MAIN:FireServer("b", "join coin")
workspace.__THINGS.__REMOTES.MAIN:FireServer("a", "farm coin")
workspace.__THINGS.__REMOTES.MAIN:FireServer("a", "claim orbs")
workspace.__THINGS.__REMOTES.MAIN:FireServer("a", "change pet target")
workspace.__THINGS.__REMOTES.MAIN:FireServer("b", "redeem rank rewards")
workspace.__THINGS.__REMOTES.MAIN:FireServer("b", "redeem vip rewards")
workspace.__THINGS.__REMOTES.MAIN:FireServer("a", "activate boost")
workspace.__THINGS.__REMOTES.MAIN:FireServer("b", "convert to dark matter")
workspace.__THINGS.__REMOTES.MAIN:FireServer("b", "redeem dark matter pet")

--Farms a coin. It seems to work. That's fun
function FarmCoin(CoinID, PetID)
    game.workspace['__THINGS']['__REMOTES']["join coin"]:InvokeServer({[1] = CoinID, [2] = {[1] = PetID}})
    game.workspace['__THINGS']['__REMOTES']["farm coin"]:FireServer({[1] = CoinID, [2] = PetID})
end

function GetMyPets()
   local returntable = {}
   for i,v in pairs(GameLibrary.Save.Get().Pets) do
       if v.e then 
           table.insert(returntable, v.uid)
       end
   end
   return returntable
end

--returns all coins within the given area (area must be a table of conent)
function GetCoins(area)
    local returntable = {}
    local ListCoins = game.workspace['__THINGS']['__REMOTES']["get coins"]:InvokeServer({})[1]
    for i,v in pairs(ListCoins) do
        if FarmingArea == 'All' or table.find(IMightKillMyselfCauseOfThis[FarmingArea], v.a) then
            local shit = v
            shit["index"] = i
            table.insert(returntable, shit)
         end
    end
    return returntable
end

--Sexy man ( wYn#0001 ) made this for me. It works, not sure how, it does.
function GetCoinTable(area)
    local CoinTable = GetCoins(area)
    function getKeysSortedByValue(tbl, sortFunction)
        local keys = {}
        for key in pairs(tbl) do
            table.insert(keys, key)
        end
        table.sort(
            keys,
            function(a, b)
                return sortFunction(tbl[a].h, tbl[b].h)
            end
        )
        return keys
    end
    local sortedKeys = getKeysSortedByValue(CoinTable, function(a, b) return a > b end)
    local newCoinTable = {}

    for i,v in pairs(sortedKeys) do
        table.insert(newCoinTable, CoinTable[v])
    end
    
    return newCoinTable
end

--Not sure exactly why I did this
local AreaWorldTable = {}
for _, v in pairs(game:GetService("ReplicatedStorage").Game.Coins:GetChildren()) do
    for _, b in pairs(v:GetChildren()) do
        table.insert(AreaWorldTable, b.Name)
    end
    table.insert(AreaWorldTable, v.Name)
end

--Returns all the currently alive chests in the game  the same was getcoins does
function AllChests()
    local returntable = {}
    local ListCoins = game.workspace['__THINGS']['__REMOTES']["get coins"]:InvokeServer({})[1]
    for i,v in pairs(ListCoins) do
        local shit = v
        shit["index"] = i
        for aa,bb in pairs(AreaWorldTable) do
            if string.find(v.n, bb) then
                local thing = string.gsub(v.n, bb.." ", "")
                if table.find(Chests, thing) then
                    shit.n = thing
                    table.insert(returntable, shit)
                end
            end
        end
    end
    return returntable
end
local GameLibrary = require(game:GetService("ReplicatedStorage"):WaitForChild("Framework"):WaitForChild("Library"))
local IDToName = {}
local NameToID = {}
local PettoRarity = {}
local RarityTable = {}
local PetNamesTable = {}
local PetNamesTable = {}

for i,v in pairs(GameLibrary.Directory.Pets) do
    IDToName[i] = v.name
    NameToID[v.name] = i
    PettoRarity[i] = v.rarity
    if not table.find(RarityTable, v.rarity) then
        table.insert(RarityTable, v.rarity)
    end
    table.insert(PetNamesTable, v.name)
end
--[[
--the remote works like this. I'm too scared to test anything else out
function CollectOrbs()
    local ohTable1 = {[1] = {}}
    for i,v in pairs(game.workspace['__THINGS'].Orbs:GetChildren()) do
        ohTable1[1][i] = v.Name
    end
    game.workspace['__THINGS']['__REMOTES']["claim orbs"]:FireServer(ohTable1)
end
]]


if _G.MyConnection then _G.MyConnection:Disconnect() end
_G.MyConnection = game.Workspace.__THINGS.Orbs.ChildAdded:Connect(function(Orb)
    game.Workspace.__THINGS.__REMOTES["claim orbs"]:FireServer({{Orb.Name}})
end)


do
	local ui = game:GetService("CoreGui"):FindFirstChild("LuxtLibWisteria GUI")
	if ui then
		ui:Destroy()
	end
end

local Luxtl = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Luxware-UI-Library/main/Source.lua"))()

local Luxt = Luxtl.CreateWindow("Ghost Pet X", 6105620301)
------essential stuff
local essential = Luxt:Tab("Essential", 6087485864)
local Discord = essential:Section("Discord Link")
local Games = essential:Section("Game")
local AutoUse = essential:Section("Auto Use")
------Autofarm Stuff----
local Mains = Luxt:Tab("Autofarm", 6087485864)
local ToggleSettings = Mains:Section("Autofarm Toggles")
local AutoSettings = Mains:Section("Autofarm Settings")
------Pet Stuff----
local Pets = Luxt:Tab("Pet", 6087485864)
local HatchEgg = Pets:Section("Pet Hatcher")
local UpgradePet = Pets:Section("Rainbow & Golden")
local DarkMatter = Pets:Section("Dark Matter")
------Misc Stuff-----
local mISCS = Luxt:Tab("Miscs", 6087485864)
local MiscWindow = mISCS:Section("Misc Stuff")


Discord:Label("https://discord.gg/dZYzEuZE3H")
Discord:Button("Copy Invite Link", function()
    setclipboard("https://discord.gg/dZYzEuZE3H")
end)
Discord:Label("--] Credits [--")
Discord:Label("RyanRenolds#3857 || Owner/Dev")


Games:Button("Get Gamepasses", function()
    require(game:GetService("ReplicatedStorage").Framework.Modules.Client["5 | Gamepasses"]).Owns = function() return true end
end)
Games:Button("Stat Tracker", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/dPXXyp4A"))()
end)
Games:Button("Possible Anti-Lag", function()
    game:GetService("Players").LocalPlayer.PlayerScripts.Scripts.GUIs["Coin Rewards HUD"].Disabled = true
    if game:GetService("Workspace"):FindFirstChild("__DEBRIS") then
         game:GetService("Workspace")["__DEBRIS"]:Destroy()
    end
end)
AutoUse:Label("Loot Bags")
AutoUse:Toggle("Auto Collect Loot Bags", function(Val)
	LootBag = Val
end)
AutoUse:Label("Boosters")

AutoUse:Toggle("3x Damage", function(Vals)
    Damage = Vals
end)
AutoUse:Toggle("3x Coins", function(Vals)
    Coins = Vals
end)


spawn(function()
    while true do wait()
        if Damage then
            if not game:GetService("Players").LocalPlayer.PlayerGui.Main.Boosts:FindFirstChild("Triple Damage") then
                workspace.__THINGS.__REMOTES["activate boost"]:FireServer({[1] = "Triple Damage"})
            end
        end
    end
end)
spawn(function()
    while true do wait()
        if Coins then
            if not game:GetService("Players").LocalPlayer.PlayerGui.Main.Boosts:FindFirstChild("Triple Coins") then
                workspace.__THINGS.__REMOTES["activate boost"]:FireServer({[1] = "Triple Coins"})
            end
        end
    end
end)



ToggleSettings:Toggle("Start Farming",function(State)
	FarmingEnabled = State
end)
ToggleSettings:Toggle("Disable Notifications", function(State)
	Notification = State
end)
spawn(function()
	while true do wait()
		if Notification then
            local notif = game:GetService("Players").LocalPlayer.PlayerGui
                if notif.Main.Bottom.Inventory.Notification.Count.text > "998" then
                    notif.Inventory.Enabled = true
                    task.wait(1)
                    notif.Inventory.Enabled = false
                end
		end

	end
		
end)
ToggleSettings:Slider("Wait Time", 1, 10, function(Values)
    WaitTime = Values
end)

local CurrentFarmingPets = {}
spawn(function()
        while true and rs:wait() do wait(WaitTime)
		if FarmingEnabled then
			local pethingy = GetMyPets()
			if FarmingType == 'Normal' then
				local cointhiny = GetCoins(FarmingArea)
				for i = 1, #cointhiny do
					if game:GetService("Workspace")["__THINGS"].Coins:FindFirstChild(cointhiny[i].index) then
						for _, bb in pairs(pethingy) do
							if FarmingEnabled and game:GetService("Workspace")["__THINGS"].Coins:FindFirstChild(cointhiny[i].index) then
								spawn(function()
									FarmCoin(cointhiny[i].index, bb)
								end)
							end
						end
						repeat rs:wait() until not game:GetService("Workspace")["__THINGS"].Coins:FindFirstChild(cointhiny[i].index)
					end
				end

			elseif FarmingType == 'Chest' then
				for i,v in pairs(AllChests()) do
					if (v.n == FarmingSingleChest) or (FarmingSingleChest == 'All') then
						local starttick = tick()
						for a, b in pairs(pethingy) do
							pcall(function() FarmCoin(v.index, b) end)
						end
						repeat rs:wait() until not game:GetService("Workspace")["__THINGS"].Coins:FindFirstChild(v.index) or #game:GetService("Workspace")["__THINGS"].Coins[v.index].Pets:GetChildren() == 0
						warn(v.n .. " has been broken in", tick()-starttick)
					end
				end

			elseif FarmingType == 'Multi Target' then
				local cointhiny = GetCoins(FarmingArea)
				for i = 1, #cointhiny do
					if i%#pethingy == #pethingy-1 then wait() end
					if not CurrentFarmingPets[pethingy[i%#pethingy+1]] or CurrentFarmingPets[pethingy[i%#pethingy+1]] == nil then
						spawn(function()
							CurrentFarmingPets[pethingy[i%#pethingy+1]] = 'Farming'
							FarmCoin(cointhiny[i].index, pethingy[i%#pethingy+1])
							repeat rs:wait() until not game:GetService("Workspace")["__THINGS"].Coins:FindFirstChild(cointhiny[i].index) or #game:GetService("Workspace")["__THINGS"].Coins:FindFirstChild(cointhiny[i].index).Pets:GetChildren() == 0
							CurrentFarmingPets[pethingy[i%#pethingy+1]] = nil
						end)
					end
				end
		------------------------------
                elseif FarmingType == 'Nearest' then
                local NearestOne = nil
                local NearestDistance = math.huge
                for i,v in pairs(game:GetService("Workspace")["__THINGS"].Coins:GetChildren()) do
                    if (v.POS.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < NearestDistance then
                        NearestOne = v
                        NearestDistance = (v.POS.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                     end
                end
                for a,b in pairs(pethingy) do
                    spawn(function() FarmCoin(NearestOne.Name, b) end)
                end
                -----------------------
			elseif FarmingType == 'Highest Value' then
				local cointhiny = GetCoinTable(FarmingArea)
				for a,b in pairs(pethingy) do
					spawn(function() FarmCoin(cointhiny[1].index, b) end)
				end
				repeat rs:wait() until not game:GetService("Workspace")["__THINGS"].Coins:FindFirstChild(cointhiny[1].index) or #game:GetService("Workspace")["__THINGS"].Coins[cointhiny[1].index].Pets:GetChildren() == 0

			elseif FarmingType == 'Nearest' then
				local NearestOne = nil
				local NearestDistance = math.huge
				for i,v in pairs(game:GetService("Workspace")["__THINGS"].Coins:GetChildren()) do
					if (v.POS.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < NearestDistance then
						NearestOne = v
						NearestDistance = (v.POS.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
					end
				end
				for a,b in pairs(pethingy) do
					spawn(function() FarmCoin(NearestOne.Name, b) end)
				end
			end
		end
	end
end)
spawn(function()
    while wait(2) do
        if LootBag then
        local Running = {}
        while wait() and LootBag == true do
            for i, v in pairs(game:GetService("Workspace")["__THINGS"].Lootbags:GetChildren()) do
                spawn(function()
                    if v ~= nil and v.ClassName == 'MeshPart' then
                        if not Running[v.Name] then
                            Running[v.Name] = true
                            local StartTick = tick()
                            v.Transparency = 1
                            for a,b in pairs(v:GetChildren()) do
                                if not string.find(b.Name, "Body") then
                                    b:Destroy()
                                end
                            end
                            repeat task.wait()
                                v.CFrame = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
                            until v == nil or not v.Parent or tick() > StartTick + 3
                            Running[v.Name] = nil
                        end
                    end
                end)
            end
        end
        end
end
end)
AutoSettings:DropDown("Type",{'Normal', 'Chest', 'Multi Target', 'Highest Value', 'Nearest'}, function(Values)
	FarmingType = Values
end)
AutoSettings:DropDown("If chest", Chests, function(FarmChest)
	FarmingSingleChest = FarmChest
end)

local AxolotlTable = {}
for i,v in pairs(game:GetService("ReplicatedStorage").Game.Coins.Axolotl:GetChildren()) do
    table.insert(AxolotlTable, v.Name)
end

AutoSettings:DropDown("Area| Spawn", AreaSpawn, function(FarmArea)
    FarmingArea = FarmArea
end)
AutoSettings:DropDown("Area| Fantasy", AreaFantasy, function(FarmArea)
    FarmingArea = FarmArea
end)
AutoSettings:DropDown("Area| Tech", AreaTech, function(FarmArea)
    FarmingArea = FarmArea
end)
AutoSettings:DropDown("Area| Axolotl", AxolotlTable, function(FarmArea)
    FarmingArea = FarmArea
end)

UpgradePet:Toggle("Start Toggle", function(State)
	StartCombine = State
end)
UpgradePet:Toggle("Auto Golden",function(State)
	Golden = State
end)
UpgradePet:Toggle("Auto Rainbow", function(State)
	Rainbow = State
end)
UpgradePet:DropDown("Required",{ 1, 2, 3, 4, 5, 6 }, function(Requires)
	Required = Requires
end)

-----------------------------------------------------------------------------
---------------------------------------------------------------------------
----------------------------------------------------------------------------



-------------------------------------------------------------------------------------------------
--Dark Matter
DarkMatter:Button("Time Check", function()
    local PetList = {}
    for i,v in pairs(GameLibrary.Directory.Pets) do
    PetList[i] = v.name
    end

    local returnstring = ""
    for i,v in pairs(GameLibrary.Save.Get().DarkMatterQueue) do
        local timeleft = 'Ready.'
        if math.floor(v.readyTime - os.time()) > 0 then
            timeleft = SecondsToClock(math.floor(v.readyTime - os.time()))
        end
        local stringthing = PetList[v.petId] .." going to be ready in: ".. timeleft
        returnstring = returnstring .. stringthing .. "\n"
    end
    require(game:GetService("ReplicatedStorage").Framework.Modules.Client["5 | Message"]).New(returnstring)
end)


-------------------------------

DarkMatter:DropDown("Select pet to dark matter", PetNamesTable, function(value)

if value then
_G.NameOfPet = value
end
print("dark matter enabled", value)
end)

-------------------------------

DarkMatter:Label("Auto Dark Matter Button Wont Toggle, I'll Fix Later")
DarkMatter:Label("For Now Just Watch Your Damn Gems")
DarkMatter:Toggle("Auto DarkMatter", function(automakedarkmatters)

if automakedarkmatters == true then
_G.AutoMakeDarkMatter = true
elseif automakedarkmatters == false then
_G.AutoMakeDarkMatter = false
end


while task.wait() and _G.AutoMakeDarkMatter do
    local Save = GameLibrary.Save.Get()
    local Slots = Save.DarkMatterSlots
    local Queued = 0
    for a, b in pairs(Save.DarkMatterQueue) do
        Queued = Queued + 1 
    end
    local Slots = Slots - Queued
    for count = 1, Slots do
        if Slots - count >= 0 then
            local PetList = {}
            for i,v in pairs(GameLibrary.Save.Get().Pets) do
                if #PetList < _G.CountDarkMatterFunc1 and v.r and IDToName[v.id] == _G.NameOfPet then
                    table.insert(PetList, v.uid)
                end
            end
            if #PetList >= _G.CountDarkMatterFunc1 then
                local tablething = {[1] = {}}
                for eeek = 1, _G.CountDarkMatterFunc1 do
                    tablething[1][eeek] = PetList[eeek]
                end
                workspace.__THINGS.__REMOTES["convert to dark matter"]:InvokeServer(tablething)
            end
        end 
    end
    task.wait(15)
end
end)
-------------------------------
DarkMatter:Toggle("Auto Claim Pets", function(autoclaimdark)

    if autoclaimdark == true then
    _G.AutoClaimDarkMatter = true
    elseif autoclaimdark == false then
    _G.AutoClaimDarkMatter = false
    end
    
    spawn(function()
    while task.wait() and _G.AutoClaimDarkMatter do
        for i,v in pairs(GameLibrary.Save.Get().DarkMatterQueue) do
            if math.floor(v.readyTime - os.time()) < 0 then
                workspace.__THINGS.__REMOTES["redeem dark matter pet"]:InvokeServer({[1] = i})
            end
            end
        task.wait(15)
    end
    end)
    end)
    
DarkMatter:DropDown("Required",{1,2,3,4,5,6}, function(countdarkmatterfunc)
    if countdarkmatterfunc then
        _G.CountDarkMatterFunc1 = countdarkmatterfunc
    end
    --print("Selected Dark Matter Count: ", _G.CountDarkMatterFunc1)
    end)
    
    
    -------------------------------

-------------------------------------------------------------------------------------------------
--page3



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

local EggRainbow = {"Rainbow Coins"}
local EggTech = {"Tech Coins"}
local EggFantasy = {"Fantasy Coins"}
local EggCoins = {"Coins"}
local DataAxolotl = {}
local DataTech = {}
local DataFantasy = {}
local DataCoins = {}
-----------------Egg Data Lists
for i,v in pairs(EggRainbow) do
	table.insert(DataAxolotl, " ")
	table.insert(DataAxolotl, "-- "..v.." --")
	for a,b in pairs(MyEggData) do
		if b.Currency == v then
			table.insert(DataAxolotl, b.Name)
		end
	end
end
for i,v in pairs(EggTech) do
	table.insert(DataTech, " ")
	table.insert(DataTech, "-- "..v.." --")
	for a,b in pairs(MyEggData) do
		if b.Currency == v then
			table.insert(DataTech, b.Name)
		end
	end
end
for i,v in pairs(EggFantasy) do
	table.insert(DataFantasy, " ")
	table.insert(DataFantasy, "-- "..v.." --")
	for a,b in pairs(MyEggData) do
		if b.Currency == v then
			table.insert(DataFantasy, b.Name)
		end
	end
end
for i,v in pairs(EggCoins) do
	table.insert(DataCoins, " ")
	table.insert(DataCoins, "-- "..v.." --")
	for a,b in pairs(MyEggData) do
		if b.Currency == v then
			table.insert(DataCoins, b.Name)
		end
	end
end




local Library = require(game:GetService("ReplicatedStorage").Framework.Library)
local IDToName = {}
local NameToID = {}
for i,v in pairs(Library.Directory.Pets ) do
    IDToName[i] = v.name
    NameToID[v.name] = i
end

function GetPets()
    local MyPets = {}
    for i,v in pairs(Library.Save.Get().Pets) do
        local ThingyThingyTempTypeThing = (v.g and 'Gold') or (v.r and 'Rainbow') or (v.dm and 'Dark Matter') or 'Normal'
        local TempString = ThingyThingyTempTypeThing .. IDToName[v.id]
        if MyPets[TempString] then
            table.insert(MyPets[TempString], v.uid)
        else
            MyPets[TempString] = {}
            table.insert(MyPets[TempString], v.uid)
        end
    end
    return MyPets
end
spawn(function()
	while true do wait()
		if StartCombine then
			for i, v in pairs(GetPets()) do
				if #v >= Required and StartCombine then
					if string.find(i, "Normal") and StartCombine and Golden then
						local Args = {}
						for eeeee = 1, Required do
							Args[#Args+1] = v[#Args+1]
						end
						Library.Network.Invoke("use golden machine", Args)

					elseif string.find(i, "Gold") and StartCombine and Rainbow then
						local Args = {}
						for eeeee = 1, Required do
							Args[#Args+1] = v[#Args+1]
						end
						Library.Network.Invoke("use rainbow machine", Args)
					end
				end
			end
		end
	end
end)

HatchEgg:Toggle("Open Eggs",function(State)
	OpenEggs = State
end)
HatchEgg:Toggle("Triple Eggs", function(State)
	TripleEggs = State
end)
spawn(function()
	while true do wait()
		if OpenEggs then
			local ohTable1 = {
				[1] = SelectedEgg,
				[2] = TripleEggs
			}
			workspace.__THINGS.__REMOTES["buy egg"]:InvokeServer(ohTable1)
		end
	end
end)

HatchEgg:DropDown('Axolotl Eggs', DataAxolotl, function(EggsTable)
    SelectedEgg = EggsTable
end)
HatchEgg:DropDown('Tech Eggs', DataTech, function(EggsTable)
	SelectedEgg = EggsTable
end)
HatchEgg:DropDown('Fantasy Eggs', DataFantasy, function(EggsTable)
	SelectedEgg = EggsTable
end)
HatchEgg:DropDown('Coins Eggs', DataCoins, function(EggsTable)
	SelectedEgg = EggsTable
end)
HatchEgg:Button("Remove Animation", function()
	for i,v in pairs(getgc(true)) do
		if (typeof(v) == 'table' and rawget(v, 'OpenEgg')) then
			v.OpenEgg = function()
				return
			end
		end
	end
end)
