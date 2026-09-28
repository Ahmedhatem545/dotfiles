local plugins = {}

local function add(mod)
   local ok, spec = pcall(require, mod)
   if not ok or spec == nil then
      return
   end

   if type(spec) == "table" and #spec > 0 then
      for _, v in ipairs(spec) do
         table.insert(plugins, v)
      end
   else
      table.insert(plugins, spec)
   end
end


add("plugins.lsp-config")
add("plugins.telescope")
add("plugins.treesitter")
add("plugins.neo-tree")
add("plugins.lualine")
add("plugins.non-ls")
add("plugins.autotag")
add("plugins.autoclose")
add("plugins.indent-blankline")
add("plugins.melange")
add("plugins.flutter")
add("bg.lua")
return plugins
