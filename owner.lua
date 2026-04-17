-- سكريبت: مراقبة مستمرة (كل 0.5 ثانية) لحذف أي Hitbox
local player = game.Players.LocalPlayer

-- 1. قائمة الأسماء المستهدفة
local targetNames = {"Hitbox", "Hitbox1", "Hitbox2"}

-- 2. وظيفة التحقق من أن الـ Part هو Hitbox
local function isHitbox(part)
    if not part:IsA("BasePart") then return false end
    for _, name in ipairs(targetNames) do
        if part.Name == name then
            return true
        end
    end
    return false
end

-- 3. وظيفة حذف الـ Hitbox
local function deleteHitbox(part)
    if isHitbox(part) then
        part:Destroy()
        print("🗑️ تم حذف Hitbox: " .. part:GetFullName())
        return true
    end
    return false
end

-- 4. مراقبة مستمرة (كل 0.5 ثانية) بدلاً من الاعتماد على "spawn"
local function continuousMonitoring()
    while true do
        for _, obj in ipairs(workspace:GetDescendants()) do
            deleteHitbox(obj)
        end
        wait(0.5)  -- انتظر نصف ثانية ثم أعد الفحص
    end
end

-- 5. حذف الموجود حالياً أولاً
for _, obj in ipairs(workspace:GetDescendants()) do
    deleteHitbox(obj)
end

-- 6. بدء المراقبة المستمرة (في كوروتين منفصل)
coroutine.wrap(continuousMonitoring)()

print("✅ السكريبت يعمل: مراقبة مستمرة (كل 0.5 ثانية) لحذف أي Hitbox")
