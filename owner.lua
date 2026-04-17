-- سكريبت: حذف كل Hitboxes (باسمها) ومنع spawnها (تلقائي)
local player = game.Players.LocalPlayer

-- 1. قائمة الأسماء المستهدفة (من التحليل السابق)
local targetNames = {"Hitbox", "Hitbox1", "Hitbox2"}

-- 2. وظيفة التحقق من أن الـ Part هو Hitbox (باسمه فقط)
local function isHitbox(part)
    if not part:IsA("BasePart") then return false end
    for _, name in ipairs(targetNames) do
        if part.Name == name then
            return true
        end
    end
    return false
end

-- 3. حذف الـ Hitbox
local function deleteHitbox(part)
    if isHitbox(part) then
        part:Destroy()
        print("🗑️ تم حذف Hitbox: " .. part:GetFullName())
        return true
    end
    return false
end

-- 4. حذف جميع الـ Hitboxes الموجودة حالياً
local function deleteAllExisting()
    local count = 0
    for _, obj in ipairs(workspace:GetDescendants()) do
        if deleteHitbox(obj) then
            count = count + 1
        end
    end
    print("✅ تم حذف " .. count .. " Hitbox (بداية تلقائية)")
    return count
end

-- 5. منع إعادة spawn (مراقبة الإضافات الجديدة)
local function blockRespawn()
    workspace.DescendantAdded:Connect(function(obj)
        if deleteHitbox(obj) then
            print("🚫 تم منع spawn Hitbox: " .. obj:GetFullName())
        end
    end)
end

-- 6. التشغيل الفوري
deleteAllExisting()
blockRespawn()

print("✅ السكريبت يعمل: حذف كل Hitboxes ومنع spawnها (بدون لمس الأجزاء الأخرى)")
