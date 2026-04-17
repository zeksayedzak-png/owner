-- سكريبت: حذف نهائي لـ Hitboxes التسونامي (ومنع عودتهم)
local player = game.Players.LocalPlayer

-- 1. قائمة المسارات (من التحليل السابق)
local hitboxPaths = {
    "Workspace.ActiveTsunamis.LowWave.Hitbox",
    "Workspace.Wave4_Visual.Hitbox",
    "Workspace.Wave2_Visual.Hitbox",
    "Workspace.Wave3_Visual.Hitbox",
    "Workspace.WonkyWave_Visual.Hitbox",
    "Workspace.Wave5_Visual.Hitbox",
    "Workspace.SnakeWave_Visual.Hitbox"
}

-- 2. وظيفة حذف Hitbox (نهائياً)
local function deleteHitbox(path)
    local parts = {}
    for part in string.gmatch(path, "[^%.]+") do
        table.insert(parts, part)
    end
    
    local current = workspace
    for _, partName in ipairs(parts) do
        if current then
            current = current:FindFirstChild(partName)
        else
            break
        end
    end
    
    if current and current:IsA("BasePart") then
        current:Destroy()
        print("🗑️ تم حذف: " .. path)
        return true
    end
    return false
end

-- 3. منع إعادة spawn (بمراقبة الإضافة)
local function blockRespawn()
    local function onChildAdded(parent, child)
        for _, path in ipairs(hitboxPaths) do
            if string.find(child:GetFullName(), path) then
                child:Destroy()
                print("🚫 تم منع إعادة spawn: " .. child:GetFullName())
            end
        end
    end
    
    -- مراقبة `workspace` بالكامل
    workspace.ChildAdded:Connect(onChildAdded)
    -- مراقبة كل مجلد قد يظهر فيه Hitbox جديد
    for _, path in ipairs(hitboxPaths) do
        local parts = {}
        for part in string.gmatch(path, "[^%.]+") do
            table.insert(parts, part)
        end
        local current = workspace
        for i = 1, #parts - 1 do
            if current then
                current = current:FindFirstChild(parts[i])
            else
                break
            end
        end
        if current then
            current.ChildAdded:Connect(onChildAdded)
        end
    end
end

-- 4. إنشاء واجهة التحكم
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TsunamiEraser"
screenGui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 80)
frame.Position = UDim2.new(0.5, -100, 0.8, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.5
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(255, 0, 0)
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local deleteButton = Instance.new("TextButton")
deleteButton.Size = UDim2.new(0, 120, 0, 40)
deleteButton.Position = UDim2.new(0.5, -60, 0.5, -20)
deleteButton.Text = "🗑️ حذف التسونامي"
deleteButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
deleteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
deleteButton.Font = Enum.Font.GothamBold
deleteButton.Parent = frame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0, 180, 0, 20)
statusLabel.Position = UDim2.new(0.5, -90, 0, 5)
statusLabel.Text = "⚪ غير نشط"
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
statusLabel.TextSize = 10
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = frame

-- 5. تشغيل الحذف والمنع
deleteButton.MouseButton1Click:Connect(function()
    local count = 0
    for _, path in ipairs(hitboxPaths) do
        if deleteHitbox(path) then
            count = count + 1
        end
    end
    blockRespawn()  -- منع أي محاولة لإعادة spawn
    statusLabel.Text = "🟢 تم حذف " .. count .. " Hitbox (والمنع مفعل)"
    deleteButton.Text = "✅ تم"
    deleteButton.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
    print("✅ تم حذف " .. count .. " Hitbox، وتم منع إعادة spawn")
end)

print("✅ سكريبت محو التسونامي جاهز - اضغط الزر")
