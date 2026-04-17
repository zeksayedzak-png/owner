-- سكريبت: حذف أي Hitbox متحرك (باسمه أو بحركته)
local player = game.Players.LocalPlayer

-- 1. قائمة الأسماء المستهدفة
local targetNames = {"Hitbox", "Hitbox1", "Hitbox2"}

-- 2. وظيفة التحقق (الاسم أو الحركة)
local function isTargetHitbox(part)
    if not part:IsA("BasePart") then return false end
    
    -- فحص الاسم
    for _, name in ipairs(targetNames) do
        if part.Name == name then
            return true
        end
    end
    
    -- فحص الحركة (إذا كان غير مثبت أو يتحرك)
    if not part.Anchored then
        return true
    end
    
    return false
end

-- 3. وظيفة الحذف
local function deleteHitbox(part)
    if isTargetHitbox(part) then
        part:Destroy()
        print("🗑️ تم حذف Hitbox: " .. part:GetFullName())
        return true
    end
    return false
end

-- 4. مراقبة مستمرة (كل 0.2 ثانية)
local function continuousMonitoring()
    while true do
        for _, obj in ipairs(workspace:GetDescendants()) do
            deleteHitbox(obj)
        end
        wait(0.2)
    end
end

-- 5. حذف الموجود حالياً
for _, obj in ipairs(workspace:GetDescendants()) do
    deleteHitbox(obj)
end

-- 6. بدء المراقبة
coroutine.wrap(continuousMonitoring)()

print("✅ السكريبت يعمل: حذف أي Hitbox (باسمه أو المتحرك) بشكل مستمر")
