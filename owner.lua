-- سكريبت: نظام حفظ واستدعاء Blarants
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- 1. متغيرات التخزين
local savedBlarant = nil  -- سيحفظ المسار والبيانات
local isMonitoring = false

-- 2. إنشاء واجهة التحكم
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BlarantManager"
screenGui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 200)
frame.Position = UDim2.new(0.5, -125, 0.7, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.5
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(0, 255, 0)
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

-- زر تشغيل
local startButton = Instance.new("TextButton")
startButton.Size = UDim2.new(0, 100, 0, 30)
startButton.Position = UDim2.new(0.1, 0, 0.2, 0)
startButton.Text = "▶ تشغيل"
startButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
startButton.TextColor3 = Color3.fromRGB(0, 0, 0)
startButton.Font = Enum.Font.GothamBold
startButton.Parent = frame

-- زر إيقاف
local stopButton = Instance.new("TextButton")
stopButton.Size = UDim2.new(0, 100, 0, 30)
stopButton.Position = UDim2.new(0.55, 0, 0.2, 0)
stopButton.Text = "⏹ إيقاف"
stopButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
stopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
stopButton.Font = Enum.Font.GothamBold
stopButton.Parent = frame

-- زر حذف المعلومات
local deleteButton = Instance.new("TextButton")
deleteButton.Size = UDim2.new(0, 100, 0, 30)
deleteButton.Position = UDim2.new(0.1, 0, 0.5, 0)
deleteButton.Text = "🗑️ حذف المعلومات"
deleteButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
deleteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
deleteButton.Font = Enum.Font.GothamBold
deleteButton.Parent = frame

-- زر استدعاء
local summonButton = Instance.new("TextButton")
summonButton.Size = UDim2.new(0, 100, 0, 30)
summonButton.Position = UDim2.new(0.55, 0, 0.5, 0)
summonButton.Text = "🌀 استدعاء"
summonButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
summonButton.TextColor3 = Color3.fromRGB(255, 255, 255)
summonButton.Font = Enum.Font.GothamBold
summonButton.Parent = frame

-- حالة السكريبت
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0, 230, 0, 20)
statusLabel.Position = UDim2.new(0.5, -115, 0, 0.8)
statusLabel.Text = "⚪ غير نشط"
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
statusLabel.TextSize = 10
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = frame

-- 3. وظيفة حفظ الـ Blarant (الذي تم الضغط عليه)
local function saveBlarant(part)
    if not isMonitoring then return end
    if not part:IsA("BasePart") then return end
    
    -- حفظ بيانات الـ Blarant (مسار كامل، حجم، لون، مادة، إلخ)
    savedBlarant = {
        path = part:GetFullName(),
        size = part.Size,
        color = part.Color,
        material = part.Material,
        position = part.Position
    }
    statusLabel.Text = "✅ تم حفظ Blarant: " .. part.Name
    print("✅ تم حفظ Blarant:", savedBlarant.path)
end

-- 4. وظيفة استدعاء الـ Blarant المحفوظ
local function summonBlarant()
    if not savedBlarant then
        statusLabel.Text = "❌ لا يوجد Blarant محفوظ"
        return
    end
    
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then
        statusLabel.Text = "❌ لا يمكن تحديد موقع اللاعب"
        return
    end
    
    -- إنشاء نسخة جديدة من الـ Blarant (باستخدام البيانات المحفوظة)
    local newBlarant = Instance.new("Part")
    newBlarant.Size = savedBlarant.size
    newBlarant.Color = savedBlarant.color
    newBlarant.Material = savedBlarant.material
    newBlarant.Anchored = false
    newBlarant.CanCollide = false
    newBlarant.Parent = workspace
    
    -- وضعه أمام اللاعب
    newBlarant.CFrame = hrp.CFrame + Vector3.new(0, 3, 0)
    
    statusLabel.Text = "🌀 تم استدعاء Blarant أمامك"
    print("🌀 تم استدعاء Blarant")
end

-- 5. وظيفة حذف المعلومات المحفوظة
local function deleteSaved()
    savedBlarant = nil
    statusLabel.Text = "🗑️ تم حذف معلومات Blarant"
    print("🗑️ تم حذف المعلومات")
end

-- 6. مراقبة الضغط على Blarants (عند تفعيل المراقبة)
mouse.Button1Down:Connect(function()
    if not isMonitoring then return end
    local target = mouse.Target
    if target and target:IsA("BasePart") then
        saveBlarant(target)
    end
end)

-- 7. ربط الأزرار
startButton.MouseButton1Click:Connect(function()
    isMonitoring = true
    statusLabel.Text = "🟢 نشط (اضغط على أي Blarant لحفظه)"
    print("✅ بدء المراقبة")
end)

stopButton.MouseButton1Click:Connect(function()
    isMonitoring = false
    statusLabel.Text = "⚪ غير نشط"
    print("⏹️ إيقاف المراقبة")
end)

deleteButton.MouseButton1Click:Connect(deleteSaved)
summonButton.MouseButton1Click:Connect(summonBlarant)

print("✅ نظام إدارة Blarants جاهز")
