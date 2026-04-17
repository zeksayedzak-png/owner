-- سكريبت: خلق Blarant جديد (بخصائص مطابقة للأصلي)
local player = game.Players.LocalPlayer

-- 1. خصائص Blarant (من التحليل السابق)
local blarantSize = Vector3.new(3.252685070037842, 6.6088786125183105, 7.616645812988281)
local blarantColor = Color3.new(0.639216, 0.635294, 0.647059)
local blarantMaterial = Enum.Material.Plastic

-- 2. إنشاء واجهة التحكم
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BlarantCreator"
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

local createButton = Instance.new("TextButton")
createButton.Size = UDim2.new(0, 180, 0, 40)
createButton.Position = UDim2.new(0.5, -90, 0.5, -20)
createButton.Text = "✨ خلق Blarant جديد"
createButton.BackgroundColor3 = Color3.fromRGB(200, 0, 200)
createButton.TextColor3 = Color3.fromRGB(255, 255, 255)
createButton.Font = Enum.Font.GothamBold
createButton.Parent = frame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0, 200, 0, 20)
statusLabel.Position = UDim2.new(0.5, -100, 0, 5)
statusLabel.Text = "⚪ اضغط لخلق Blarant"
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(255, 0, 255)
statusLabel.TextSize = 10
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = frame

-- 3. وظيفة خلق Blarant
local function createBlarant()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then
        statusLabel.Text = "❌ لا يمكن تحديد موقع اللاعب"
        return
    end
    
    -- إنشاء Part جديد (شكل Blarant)
    local newBlarant = Instance.new("Part")
    newBlarant.Size = blarantSize
    newBlarant.Color = blarantColor
    newBlarant.Material = blarantMaterial
    newBlarant.Anchored = false
    newBlarant.CanCollide = false
    newBlarant.Parent = workspace
    
    -- وضعه أمام اللاعب
    newBlarant.CFrame = hrp.CFrame + Vector3.new(0, 3, 0)
    
    -- إضافة ClickDetector (لجعله قابلاً للإمساك)
    local detector = Instance.new("ClickDetector")
    detector.Parent = newBlarant
    
    -- ربط حدث الإمساك (محاكاة الإمساك بـ Blarant)
    detector.MouseClick:Connect(function()
        newBlarant:Destroy()
        statusLabel.Text = "🎉 تم الإمساك بـ Blarant (حصلت على جائزة)"
        -- هنا يمكن إضافة كود منح الجائزة (عملات، خبرة، إلخ)
    end)
    
    statusLabel.Text = "✅ تم خلق Blarant أمامك"
    print("✅ تم خلق Blarant جديد")
end

-- 4. ربط الزر
createButton.MouseButton1Click:Connect(createBlarant)

print("✅ سكريبت خلق Blarant جاهز - اضغط الزر")
