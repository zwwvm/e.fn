local games = {
    path = "https://raw.githubusercontent.com/zwwvm/e.fn/refs/heads/main/games/",
    ["fpv_drone_game"] = {
        placeid = 108780627652357,
        executors = { "any" },
        executor_not_supported_warning = false
    }
}

print("test")

for i, v in pairs(games) do
    if tostring(i) == "path" then return end
    print(game.PlaceId, i, v.placeid)
    if game.PlaceId == v.placeid then
        for _, z in ipairs(v.executors) do
            if z.name == identifyexecutor() or not v.executor_not_supported_warning then
                if z.needs_custom_drawing then
                    local a = tick()
                    warn("Executor needs custom drawing...")
                    loadstring(game:HttpGet("print('drawing')"))()
                    local b = tick() - a
                    warn("Custom drawing loaded! | Time took: " .. string.format("%.3f", b) .. "s")
                end

                local a = tick()
                warn("Loading script...")
                loadstring(game:HttpGet(games.path .. i .. "/main.luau"))()
                local b = tick() - a
                warn("Script loaded! | Time took: " .. string.format("%.3f", b) .. "s")

                break
            else
                if getgenv().not_supported then
                     loadstring(game:HttpGet(games.path .. i .. "/main.lua"))()
                else
                    getgenv().not_supported = true
                    warn("Executor not supported. Please execute again if you want to continue anyway.")
                end
                break
            end
        end
    end
end
