local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Options = Fluent.Options
local plrCharacter = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
local plrMouse = game.Players.LocalPlayer:GetMouse()
local srvPlayers = game:GetService("Players")
local noClip = false
local espEnabled = false
local selectedPlayer = nil
local loopTeleportEnabled = false
local loopTeleportTarget = nil

local function tpPlayer()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = selectedPlayer.Character.HumanoidRootPart.CFrame
end

local function toggleLoopTeleport(state)
    loopTeleportEnabled = state

    while loopTeleportEnabled do
        if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = selectedPlayer.Character.HumanoidRootPart.CFrame
        end
        task.wait(0.1)
    end
end

local function updatePlayerList()
    local playerNames = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            table.insert(playerNames, player.Name)
        end
    end
    Options.PlayerDropdown:SetValues(playerNames)
end

local function toggleESP(state)
    espEnabled = state

    if espEnabled then
        for _, otherPlayer in pairs(game.Players:GetPlayers()) do
            if otherPlayer ~= game.Players.LocalPlayer and otherPlayer.Character then
                local head = otherPlayer.Character:FindFirstChild("Head")
                if head then
                    -- Create BillboardGui
                    local billboard = Instance.new("BillboardGui")
                    billboard.Name = "ESP_Billboard"
                    billboard.Adornee = head
                    billboard.Size = UDim2.new(2, 0, 2, 0) -- Size of ESP box
                    billboard.AlwaysOnTop = true -- Ensures it's visible through walls
                    billboard.LightInfluence = 0 -- Makes sure it isn't affected by lighting
                    billboard.StudsOffset = Vector3.new(0, 2, 0) -- Adjusts position above head
                    billboard.Parent = head

                    -- Create a frame inside the BillboardGui
                    local frame = Instance.new("Frame")
                    frame.Size = UDim2.new(1, 0, 1, 0)
                    frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Red ESP color
                    frame.BackgroundTransparency = 0.3 -- Adjust visibility
                    frame.BorderSizePixel = 0
                    frame.Parent = billboard

                    -- Remove ESP when player respawns
                    otherPlayer.CharacterAdded:Connect(function()
                        billboard:Destroy()
                    end)
                end
            end
        end
    else
        -- Remove ESP when disabled
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character then
                local head = player.Character:FindFirstChild("Head")
                if head then
                    local billboard = head:FindFirstChild("ESP_Billboard")
                    if billboard then
                        billboard:Destroy()
                    end
                end
            end
        end
    end
end

local function toggleNoClip(state)
    noClip = state
end

local function runNoClip()
    game:GetService("RunService").Stepped:Connect(function()
        if noClip and game.Players.LocalPlayer.Character then
            for _, part in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end

local function tpToolGive()
    if game.Players.LocalPlayer.Backpack:FindFirstChild("TeleportTool") then
        game.Players.LocalPlayer.Backpack:FindFirstChild("TeleportTool"):Destroy()
    end

    local tpTool = Instance.new("Tool")
    tpTool.Name = "Teleport Tool"
    tpTool.RequiresHandle = false
    tpTool.Parent = game.Players.LocalPlayer.Backpack

    tpTool.Activated:Connect(function()
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.p + Vector3.new(0, 3, 0))
        end
    end)
end

local Window = Fluent:CreateWindow({
    Title = "--//CRX -- Lite//--",
    SubTitle = "by crxsvxv",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Light",
    MinimizeKey = Enum.KeyCode.RightControl
})

local Tabs = {
    Info = Window:AddTab({ Title = "Info", Icon = "info" }),
    Local = Window:AddTab({ Title = "Local", Icon = "user" }),
    Players = Window:AddTab({ Title = "Players", Icon = "users" }),
    Scripts = Window:AddTab({ Title = "Scripts", Icon = "file-code" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}







Tabs.Info:AddParagraph({
    Title = "Welcome",
    Content = "Welcome to CRX Lite! If you're actually reading this info paragraph, then thank you so much. I spent a lot of time on it. In here, you will learn about your limitations, abilities, and the community. Let's get started, shall we?"
})

Tabs.Info:AddParagraph({
    Title = "Abilities",
    Content = "There's so many things you can do with scripting and exploiting like teleporting to places, flying, acting like an admin and much more. Although when you hear these it might seem like you have no limitations, trust me, there is alot of limitations. Here's why:"
})

Tabs.Info:AddParagraph({
    Title = "Limitations",
    Content = "This is the negative part of exploiting. Since the anti-cheat called Byfron got added to Roblox, many exploiters were desperate. Most of them quit, including a ton of content creators. There's two terms you need to know about: Client and Server. There is things you can do that get replicated to the server, and things that no one can see you doing. For example, your movement is replicated to the server, so everyone can see you when you fly or teleport. But for example, if you try to spawn a ban hammer and kill people out of nowhere, it does not get replicated, because it's definitely not a feature that the developers of the game has added."
})

Tabs.Info:AddParagraph({
    Title = "The Community",
    Content = "This is the bad, but somehow the fun part about exploiting. You see, people can judge exploiters by many things, resulting them into getting called things like: Chill Exploiter, Evil Exploiter, Scary Exploiter and much more stupid terms. In fact, there is only 3 real words you can call an exploiter by: Scripters, Casuals, Skids. Casuals are exploiters that mostly complain because of how hard it is to find scripts, and they never think about how real people are making them, and they can make one too. They always copy and paste scripts. Scripters are the ones who make their own scripts. It doesn't matter if they're a pro developer, or a beginner. Some scripters publish their scripts to the public for free, some make profit out of them with advertising websites or paid keys, and some have really secret and powerful scripts, that they are afraid of getting popular with it and getting targeted. So they keep it private. Now skids... they are disgusting as hell. Some of them have no idea what LuaU (the scripting language of roblox) even is, and those who know use it for stealing scripts, modifying them and getting credit. Some wannabes also think that they're a part of team c00lkidd and dream of destroying a game, not knowing that roblox has insane security now."
})

local humanoidSection = Tabs.Local:AddSection("Player Values")

local wsInput = Tabs.Local:AddInput("Input", {
    Title = "Walk Speed",
    Description = "Changes your walk speed.",
    Default = 16,
    Placeholder = "Input",
    Numeric = true,
    Finished = false,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

local jpInput = Tabs.Local:AddInput("Input", 
{
    Title = "Jump Power",
    Description = "Changes your jump power.",
    Default = 50,
    Placeholder = "Input",
    Numeric = true,
    Finished = false,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end
})

local sitToggle = Tabs.Local:AddToggle("MyToggle", 
{
    Title = "Sit", 
    Description = "Makes you sit / stand.",
    Default = false,
    Callback = function(state)
        game.Players.LocalPlayer.Character.Humanoid.Sit = state
    end
})

local cheatsSection = Tabs.Local:AddSection("Cheats")

Tabs.Local:AddButton({
    Title = "Teleport Tool",
    Description = "Click to teleport!",
    Callback = function()
        tpToolGive()
    end
})

local noclipToggle = Tabs.Local:AddToggle("MyToggle", 
{
    Title = "No Clip", 
    Description = "Makes you go through walls.",
    Default = false,
    Callback = function(state)
        toggleNoClip(state)
    end 
})

local espToggle = Tabs.Local:AddToggle("MyToggle", 
{
    Title = "ESP", 
    Description = "Highlights players.",
    Default = false,
    Callback = function(state)
        toggleESP(state)
    end 
})

local plrdSection = Tabs.Players:AddSection("Select Player")

local playerDropdown = Tabs.Players:AddDropdown("PlayerDropdown", {
    Title = "Select Player",
    Values = {},
    Multi = false,
    Default = nil,
    Callback = function(value)
        selectedPlayer = game.Players:FindFirstChild(value)
    end
})

local actSection = Tabs.Players:AddSection("Actions")

local ltpToggle = Tabs.Players:AddToggle("MyToggle", 
{
    Title = "Loop Teleport", 
    Description = "Constantly teleport to the selecter player.",
    Default = false,
    Callback = function(state)
    toggleLoopTeleport(state)
    end 
})

Tabs.Players:AddButton({
    Title = "Teleport",
    Description = "Teleoprt to the selected player.",
    Callback = function()
        tpPlayer()
    end
})

Tabs.Scripts:AddButton({
    Title = "Infinite Yield",
    Callback = function()
     loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end
})

Tabs.Scripts:AddButton({
    Title = "Dex Explorer",
    Callback = function()
     loadstring(game:HttpGet("https://raw.githubusercontent.com/nuIIism/scripts/main/dex.lua"))()
    end
})


Tabs.Scripts:AddButton({
    Title = "UNC Test",
    Callback = function()
     loadstring(game:HttpGet('https://github.com/ltseverydayyou/uuuuuuu/blob/main/UNC%20test?raw=true'))()
    end
})











SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
Window:SelectTab(1)

Fluent:Notify({
    Title = "CRX Lite",
    Content = "Interface loaded, have fun learning!",
    Duration = 8
})

SaveManager:LoadAutoloadConfig()

game.Players.PlayerAdded:Connect(updatePlayerList)
game.Players.PlayerRemoving:Connect(updatePlayerList)

updatePlayerList()
runNoClip()