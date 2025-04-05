local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Options = Fluent.Options
local description = ""
local image = ""
local accent = Color3.new(1,1,1)
local primary = Color3.new(1,1,1)
local mcDescription = ""

local function updBooth()
    local args = {
        [1] = {
            ["primaryColor"] = primary,
            ["image"] = image,
            ["accentColor"] = accent,
            ["desc"] = description
        }
    }

    game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("UpdateBooth", 9e9):FireServer(unpack(args))
end

local function modCall()
    local args = {
        [1] = {
            ["desc"] = mcDescription;
        };
    }

    game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("ModCall", 9e9):FireServer(unpack(args))
end

local function spoofPC()
    local args = {
        [1] = "rbxassetid://12684119225";
    }

    workspace:WaitForChild("crxsvxvx", 9e9):WaitForChild("Head", 9e9):WaitForChild("Title", 9e9):WaitForChild("PlatformIndicator", 9e9):WaitForChild("platformConfig", 9e9):FireServer(unpack(args))
end

local function spoofMobile()
    local args = {
        [1] = "rbxassetid://13021320268";
    }

    workspace:WaitForChild("crxsvxvx", 9e9):WaitForChild("Head", 9e9):WaitForChild("Title", 9e9):WaitForChild("PlatformIndicator", 9e9):WaitForChild("platformConfig", 9e9):FireServer(unpack(args))
end

local function spoofConsole()
    local args = {
        [1] = "rbxassetid://11894535915";
    }

    workspace:WaitForChild("crxsvxvx", 9e9):WaitForChild("Head", 9e9):WaitForChild("Title", 9e9):WaitForChild("PlatformIndicator", 9e9):WaitForChild("platformConfig", 9e9):FireServer(unpack(args))
end

local function spoofAnonim()
    local args = {
        [1] = nil;
    }

    workspace:WaitForChild("crxsvxvx", 9e9):WaitForChild("Head", 9e9):WaitForChild("Title", 9e9):WaitForChild("PlatformIndicator", 9e9):WaitForChild("platformConfig", 9e9):FireServer(unpack(args))
end

local Window = Fluent:CreateWindow({
    Title = "-- CRX Game : Rate My Avatar 2 --",
    SubTitle = "by crxsvxv",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.RightControl
})

local Tabs = {
    Info = Window:AddTab({ Title = "Info", Icon = "info" }),
    Main = Window:AddTab({ Title = "Main", Icon = "file-code" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

Tabs.Main:AddSection("Booth")

Tabs.Main:AddInput("Input", {
    Title = "Description",
    Description = "Change your booth's description.",
    Default = "",
    Placeholder = "Description",
    Numeric = false,
    Finished = false,
    Callback = function(Value)
        description = Value
    end
})

Tabs.Main:AddInput("Input", {
    Title = "Image",
    Description = "Change your booth's image.",
    Default = "",
    Placeholder = "Decal ID",
    Numeric = false,
    Finished = false,
    Callback = function(Value)
        image = Value
    end
})

local primColorPicker = Tabs.Main:AddColorpicker("Colorpicker", {
    Title = "Primary Color",
    Description = "Change your booth's primary color.",
    Default = Color3.fromRGB(255, 255, 255)
})

primColorPicker:OnChanged(function(Value)
    primary = Value
end)

local accColorPicker = Tabs.Main:AddColorpicker("Colorpicker", {
    Title = "Accent Color",
    Description = "Change your booth's accent color.",
    Default = Color3.fromRGB(255, 255, 255)
})

accColorPicker:OnChanged(function(Value)
    accent = Value
end)

Tabs.Main:AddButton({
    Title = "Update Booth",
    Description = "Apply changes to your booth.",
    Callback = function()
        updBooth()
    end
})

Tabs.Main:AddSection("Platform Spoofing")

Tabs.Main:AddButton({
    Title = "Spoof PC",
    Description = "Spoofs your platform icon to PC.",
    Callback = function()
        spoofPC()
    end
})

Tabs.Main:AddButton({
    Title = "Spoof Mobile",
    Description = "Spoof your platform icon to Mobile.",
    Callback = function()
        spoofMobile()
    end
})

Tabs.Main:AddButton({
    Title = "Spoof Console",
    Description = "Spoof your platform icon to Console.",
    Callback = function()
        spoofConsole()
    end
})

Tabs.Main:AddButton({
    Title = "Spoof Anonim",
    Description = "Spoof your platform icon to none.",
    Callback = function()
        spoofAnonim()
    end
})

Tabs.Main:AddSection("Mod Call")

Tabs.Main:AddInput("Input", {
    Title = "Description",
    Description = "Change mod call description.",
    Default = "",
    Placeholder = "Description",
    Numeric = false,
    Finished = false,
    Callback = function(Value)
        mcDescription = Value
    end
})

Tabs.Main:AddButton({
    Title = "Call",
    Description = "Call a mod with the description.",
    Callback = function()
        modCall()
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
    Title = "CRX Game",
    Content = "Interface loaded, have fun!",
    Duration = 8
})
