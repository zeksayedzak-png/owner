-- سكريبت: استدعاء Blarant (يظهر أمام اللاعب)
local player = game.Players.LocalPlayer

-- 1. المسار الثابت للـ Blarant الأصلي (من التحليل السابق)
local originalBlarant = workspace:FindFirstChild("ActiveBrainrots")
if originalBlarant then
    originalBlarant = originalBlarant:FindFirstChild("Common")
    if originalBlarant then
        originalBlarant = originalBlarant:FindFirstChild("RenderedBrainrot")
        if originalBlarant then
            originalBlarant = originalBlarant:FindFirstChild("Lirili Larila")
            if originalBlarant then
                originalBlarant = originalBlarant:FindFirstChild("ModelExtents")
            end
        end
    end
end

if not originalBlarant then
    warn("❌ لم يتم العثور على الـ Blarant الأصلي")
    return
end

-- 2. إنشاء واجهة التحكم
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BlarantSpawner"
screenGui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 80)
frame.Position = UDim2.new(0.5, -110, 0.8, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.5
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(255, 0, 255)
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local spawnButton = Instance.new("TextButton")
spawnButton.Size = UDim2.new(0, 160, 0, 40)
spawnButton.Position = UDim2.new(0.5, -80, 0.5, -20)
spawnButton.Text = "🌀 استدعاء Blarant"
spawnButton.BackgroundColor3 = Color3.fromRGB(200, 0, 200)
spawnButton.TextColor3 = Color3.fromRGB(255, 255, 255)
spawnButton.Font = Enum.Font.GothamBold
spawnButton.Parent = frame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0, 200, 0, 20)
statusLabel.Position = UDim2.new(0.5, -100, 0, 5)
statusLabel.Text = "⚪ اضغط لاستدعاء Blarant"
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(255, 0, 255)
statusLabel.TextSize = 10
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = frame

-- 3. وظيفة استدعاء Blarant
local function spawnBlarant()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then
        statusLabel.Text = "❌ لا يمكن تحديد موقع اللاعب"
        return
    end
    
    -- استنساخ الـ Blarant
    local newBlarant = originalBlarant:Clone()
    newBlarant.Parent = workspace
    
    -- وضعه أمام اللاعب (على الأرض)
    newBlarant.CFrame = hrp.CFrame + Vector3.new(0, 3, 0)
    
    statusLabel.Text = "✅ تم استدعاء Blarant أمامك"
    print("✅ تم استنساخ Blarant")
end

-- 4. ربط الزر
spawnButton.MouseButton1Click:Connect(spawnBlarant)

print("✅ سكريبت استدعاء Blarant جاهز - اضغط الزر")
