-- سكريبت: حذف نهائي لـ Hitboxes التسونامي (ومنع spawnها)
local player = game.Players.LocalPlayer

-- 1. قائمة بالصفات الفريدة لهذه الـ Hitboxes (من الكود الذي أرسلته)
local tsunamiParts = {
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

-- 2. وظيفة حذف أي Part يطابق الصفات
local function isTsunamiPart(part)
    if not part:IsA("BasePart") then return false end
    for _, data in ipairs(tsunamiParts) do
        if part.Size == data.size and part.Color == data.color and part.Material == data.material then
            return true
        end
    end
    return false
end

local function deletePart(part)
    if isTsunamiPart(part) then
        part:Destroy()
        print("🗑️ تم حذف: " .. part:GetFullName())
        return true
    end
    return false
end

-- 3. حذف جميع الـ Hitboxes الموجودة حالياً
local function deleteAllExisting()
    local count = 0
    for _, obj in ipairs(workspace:GetDescendants()) do
        if deletePart(obj) then
            count = count + 1
        end
    end
    print("✅ تم حذف " .. count .. " Hitbox")
    return count
end

-- 4. منع إعادة spawn (مراقبة الإضافات الجديدة)
local function blockRespawn()
    workspace.DescendantAdded:Connect(function(obj)
        if deletePart(obj) then
            print("🚫 تم منع spawn: " .. obj:GetFullName())
        end
    end)
end

-- 5. إنشاء واجهة التحكم
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TsunamiEraser"
screenGui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 80)
frame.Position = UDim2.new(0.5, -110, 0.8, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.5
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(255, 0, 0)
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local deleteButton = Instance.new("TextButton")
deleteButton.Size = UDim2.new(0, 140, 0, 40)
deleteButton.Position = UDim2.new(0.5, -70, 0.5, -20)
deleteButton.Text = "🗑️ حذف التسونامي"
deleteButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
deleteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
deleteButton.Font = Enum.Font.GothamBold
deleteButton.Parent = frame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0, 200, 0, 20)
statusLabel.Position = UDim2.new(0.5, -100, 0, 5)
statusLabel.Text = "⚪ غير نشط"
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
statusLabel.TextSize = 10
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = frame

-- 6. تشغيل الحذف والمنع
deleteButton.MouseButton1Click:Connect(function()
    local count = deleteAllExisting()
    blockRespawn()
    statusLabel.Text = "🟢 تم حذف " .. count .. " Hitbox (والمنع مفعل)"
    deleteButton.Text = "✅ تم"
    deleteButton.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
    print("✅ تم حذف " .. count .. " Hitbox، وتم منع إعادة spawn")
end)

print("✅ سكريبت محو التسونامي جاهز - اضغط الزر")
