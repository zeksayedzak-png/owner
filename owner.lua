-- سكريبت: استدعاء بلوك الحظ (Spawn Lucky Block)
local player = game.Players.LocalPlayer

-- 1. إنشاء واجهة التحكم
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LuckyBlockSpawner"
screenGui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 80)
frame.Position = UDim2.new(0.5, -100, 0.8, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.5
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(0, 255, 0)
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local spawnButton = Instance.new("TextButton")
spawnButton.Size = UDim2.new(0, 140, 0, 40)
spawnButton.Position = UDim2.new(0.5, -70, 0.5, -20)
spawnButton.Text = "🎲 استدعاء بلوك الحظ"
spawnButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
spawnButton.TextColor3 = Color3.fromRGB(0, 0, 0)
spawnButton.Font = Enum.Font.GothamBold
spawnButton.Parent = frame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0, 180, 0, 20)
statusLabel.Position = UDim2.new(0.5, -90, 0, 5)
statusLabel.Text = "⚪ اضغط الزر لاستدعاء البلوك"
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
statusLabel.TextSize = 10
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = frame

-- 2. وظيفة استدعاء بلوك الحظ (نسخ الكائن الأصلي)
local function spawnLuckyBlock()
    -- البحث عن بلوك الحظ الأصلي (المصدر)
    local originalBlock = workspace:FindFirstChild("ActiveLuckyBlocks")
    if not originalBlock then
        statusLabel.Text = "❌ لم يتم العثور على بلوك الحظ الأصلي"
        return
    end
    
    -- استنساخ البلوك
    local newBlock = originalBlock:Clone()
    newBlock.Parent = workspace
    
    -- وضعه أمام اللاعب مباشرة
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        newBlock:SetPrimaryPartCFrame(hrp.CFrame + Vector3.new(0, 3, 0))
    end
    
    statusLabel.Text = "✅ تم استدعاء بلوك الحظ أمامك"
    print("✅ تم استنساخ بلوك الحظ")
end

-- 3. ربط الزر
spawnButton.MouseButton1Click:Connect(spawnLuckyBlock)

print("✅ سكريبت استدعاء بلوك الحظ جاهز - اضغط الزر")
