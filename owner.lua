-- سكريبت: القوة المطلقة (صفات + مسارات + منع spawn)
local player = game.Players.LocalPlayer

-- 1. قائمة المسارات (من التحليل السابق)
local tsunamiPaths = {
    "Workspace.ActiveTsunamis.LowWave.Hitbox",
    "Workspace.Wave4_Visual.Hitbox",
    "Workspace.Wave2_Visual.Hitbox",
    "Workspace.Wave3_Visual.Hitbox",
    "Workspace.WonkyWave_Visual.Hitbox",
    "Workspace.Wave5_Visual.Hitbox",
    "Workspace.SnakeWave_Visual.Hitbox"
}

-- 2. قائمة الصفات (للاستخدام الاحتياطي)
local tsunamiTraits = {
    { size = Vector3.new(2.8, 3.1, 260.0), color = Color3.new(0.64, 0.64, 0.65), material = Enum.Material.Plastic },
    { size = Vector3.new(25.5, 19.7, 260.0), color = Color3.new(0.64, 0.64, 0.65), material = Enum.Material.Plastic },
    { size = Vector3.new(25.5, 51.2, 260.0), color = Color3.new(0.64, 0.64, 0.65), material = Enum.Material.Plastic },
    { size = Vector3.new(25.5, 28.8, 86.7), color = Color3.new(0.64, 0.64, 0.65), material = Enum.Material.Plastic },
    { size = Vector3.new(25.5, 34.1, 260.0), color = Color3.new(0.64, 0.64, 0.65), material = Enum.Material.Plastic },
    { size = Vector3.new(25.5, 18.1, 260.0), color = Color3.new(0.64, 0.64, 0.65), material = Enum.Material.Plastic },
    { size = Vector3.new(25.5, 33.0, 260.0), color = Color3.new(0.64, 0.64, 0.65), material = Enum.Material.Plastic },
    { size = Vector3.new(25.5, 18.5, 260.0), color = Color3.new(0.64, 0.64, 0.65), material = Enum.Material.Plastic },
    { size = Vector3.new(25.5, 19.2, 260.0), color = Color3.new(0.64, 0.64, 0.65), material = Enum.Material.Plastic },
    { size = Vector3.new(25.5, 28.8, 260.0), color = Color3.new(0.64, 0.64, 0.65), material = Enum.Material.Plastic },
    { size = Vector3.new(25.5, 24.4, 260.0), color = Color3.new(0.64, 0.64, 0.65), material = Enum.Material.Plastic },
    { size = Vector3.new(25.5, 28.2, 260.0), color = Color3.new(0.64, 0.64, 0.65), material = Enum.Material.Plastic },
    { size = Vector3.new(25.5, 70.8, 260.0), color = Color3.new(0.64, 0.64, 0.65), material = Enum.Material.Plastic },
    { size = Vector3.new(25.5, 29.2, 260.0), color = Color3.new(0.64, 0.64, 0.65), material = Enum.Material.Plastic },
    { size = Vector3.new(25.5, 28.8, 112.7), color = Color3.new(0.64, 0.64, 0.65), material = Enum.Material.Plastic }
}

-- 3. قائمة الأسماء (احتياطي أخير)
local targetNames = {"Hitbox", "Hitbox1", "Hitbox2"}

-- 4. وظيفة الحصول على Part من مسار
local function getPartFromPath(path)
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
    return current
end

-- 5. التحقق من الصفات
local function matchesTraits(part)
    for _, trait in ipairs(tsunamiTraits) do
        if part.Size == trait.size and part.Color == trait.color and part.Material == trait.material then
            return true
        end
    end
    return false
end

-- 6. التحقق من الاسم
local function matchesName(part)
    for _, name in ipairs(targetNames) do
        if part.Name == name then
            return true
        end
    end
    return false
end

-- 7. وظيفة الحذف الشاملة
local function isTsunamiPart(part)
    if not part:IsA("BasePart") then return false end
    return matchesTraits(part) or matchesName(part)
end

local function deletePart(part)
    if isTsunamiPart(part) then
        part:Destroy()
        print("🗑️ تم حذف: " .. part:GetFullName())
        return true
    end
    return false
end

-- 8. حذف كل الموجود (بالمسارات + بالصفات)
local function deleteAllExisting()
    local count = 0
    -- حذف بالمسارات
    for _, path in ipairs(tsunamiPaths) do
        local part = getPartFromPath(path)
        if deletePart(part) then
            count = count + 1
        end
    end
    -- حذف بالصفات (لأي Part لم يغطه المسار)
    for _, obj in ipairs(workspace:GetDescendants()) do
        if deletePart(obj) then
            count = count + 1
        end
    end
    print("✅ تم حذف " .. count .. " Hitbox")
    return count
end

-- 9. منع إعادة spawn
local function blockRespawn()
    workspace.DescendantAdded:Connect(function(obj)
        if deletePart(obj) then
            print("🚫 تم منع spawn: " .. obj:GetFullName())
        end
    end)
end

-- 10. واجهة التحكم
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TsunamiEraserUltimate"
screenGui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 90)
frame.Position = UDim2.new(0.5, -125, 0.8, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.5
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(255, 0, 0)
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local deleteButton = Instance.new("TextButton")
deleteButton.Size = UDim2.new(0, 180, 0, 40)
deleteButton.Position = UDim2.new(0.5, -90, 0.5, -20)
deleteButton.Text = "💀 حذف التسونامي (نهائي)"
deleteButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
deleteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
deleteButton.Font = Enum.Font.GothamBold
deleteButton.Parent = frame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0, 230, 0, 20)
statusLabel.Position = UDim2.new(0.5, -115, 0, 5)
statusLabel.Text = "⚪ غير نشط"
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
statusLabel.TextSize = 10
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = frame

-- 11. التشغيل
deleteButton.MouseButton1Click:Connect(function()
    local count = deleteAllExisting()
    blockRespawn()
    statusLabel.Text = "🟢 تم حذف " .. count .. " Hitbox (والمنع مفعل)"
    deleteButton.Text = "✅ تم"
    deleteButton.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
    print("✅ تم حذف " .. count .. " Hitbox، وتم منع إعادة spawn")
end)

print("✅ السكريبت النهائي (صفات + مسارات) جاهز - اضغط الزر")
