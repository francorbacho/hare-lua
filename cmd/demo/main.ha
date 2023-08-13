use lua;
use fmt;
use time;
use strings;

export fn main() void = {
    let l = lua::luaL_newstate();
    defer lua::lua_close(l);

    lua::luaL_openlibs(l);

    lua::luaL_loadstring(l, "print('hello friends 🥳')")!;
    lua::lua_pcall(l, 0, -1, 0)!;
    lua::lua_pop(l, lua::lua_gettop(l));
};
