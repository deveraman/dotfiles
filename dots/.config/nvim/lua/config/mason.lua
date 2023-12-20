local registry = require("mason-registry")

local plugins = {
    'black',
    'pylint',
    'prettier',
}

function Setup()
    for _, plugin in ipairs(plugins) do
        local ok, pkg = pcall(registry.get_package, plugin)
        if ok then
            if not pkg:is_installed() then
                pkg:install()
            end
        end
    end
end

return {
    setup = Setup
}
