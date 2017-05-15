minetest.register_entity("customentity:entity01", {
    physical = false,
    visual = "mesh",
    textures = { "entity01_texture0.png" },
    mesh= "entity01.obj",
    visual_size = {x = 1, y = 1, z = 1},
    groups = { immortal=1, },

    on_rightclick = function(self, clicker)
            self.object:remove()
        end

})


minetest.register_chatcommand("addEntity", {
    params = "<entity name> <entity param>",
    description = "Add an entity with parameters",
    func = function(user, args)

        if args == "" then
            return false, "Parameters required."
        end

        local structureName, structureParam = args:match("^(%S+)%s(%S+)$")

        if not structureParam then
            return false, "Entity parameters required"
        end

        local player = minetest.get_player_by_name(user)
        if not player then
            return false, "Player not found"
        end

        local fmt = "Add an %s entity at: (%.2f,%.2f,%.2f)"

        local pos = player:getpos()

        -- /addEntity entity01 1
        if structureName == "entity01" then
            minetest.chat_send_player(user, "Add entity  " .. structureParam)
            minetest.add_entity({x=pos.x + 2, y=pos.y + 1, z=pos.z }, "customentity:entity01")

        else
            return false, "No entity added"
        end

        return true, fmt:format(args, pos.x, pos.y, pos.z)
    end
})

