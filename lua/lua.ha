use types::c;
use types::c::{ char };

export type lua_State = void;
export type lua_CFunction = nullable *void;
export type harefunc = fn(l: *lua_State) void;

export @symbol("luaL_newstate") fn luaL_newstate() *lua_State;
export @symbol("lua_close") fn lua_close(l: *lua_State) void;
export @symbol("lua_settop") fn lua_settop(l: *lua_State, idx: int) void;
export @symbol("lua_gettop") fn lua_gettop(l: *lua_State) int;

export @symbol("luaL_openlibs") fn luaL_openlibs(l: *lua_State) void;

@symbol("luaL_loadstring") fn _luaL_loadstring(l: *lua_State, code: *char) int;
@symbol("luaL_loadfilex") fn _luaL_loadfilex(l: *lua_State, filename: *char, mode: nullable *char) int;

@symbol("lua_pushcclosure") fn _lua_pushcclosure(l: *lua_State, _fn: lua_CFunction, n: int) void;

@symbol("lua_setglobal") fn _lua_setglobal(l: *lua_State, name: *const char) void;

@symbol("lua_pcallk") fn _lua_pcallk(
    l: *lua_State,
    nargs: int, nresults: int, errfunc: int,
    ctx: int, k: lua_CFunction,
) int;

export fn luaL_loadstring(l: *lua_State, code: str) (void | error) = {
    // XXX: This allocates every time.
    const cstr = types::c::fromstr(code);
    defer free(cstr);

    return wrapvoid(_luaL_loadstring(l, cstr));
};

export fn luaL_loadfile(l: *lua_State, file: str) (void | error) = {
    // XXX: This allocates every time.
    const cstr = types::c::fromstr(file);
    defer free(cstr);

    return wrapvoid(_luaL_loadfilex(l, cstr, null));
};

export fn lua_pushcfunction(l: *lua_State, _fn: lua_CFunction) void = {
    _lua_pushcclosure(l, _fn, 0);
};

export fn lua_setglobal(l: *lua_State, name: str) void = {
    const cstr = types::c::fromstr(name);
    defer free(cstr);

    _lua_setglobal(l, cstr);
};

export fn lua_pcall(l: *lua_State, nargs: i32, nresults: i32, errfunc: i32) (void | error) = {
    return wrapvoid(_lua_pcallk(l, nargs, nresults, errfunc, 0, null));
};

export fn lua_pop(l: *lua_State, n: int) void = {
    lua_settop(l, -n - 1);
};
