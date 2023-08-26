use types::c;
use types::c::{ char };

export type lua_State = opaque;
export type lua_CFunction = nullable *fn(l: *lua_State) void;
export type harefunc = fn(l: *lua_State) void;

export @symbol("luaL_newstate") fn luaL_newstate() *lua_State;
export @symbol("lua_close") fn lua_close(l: *lua_State) void;
export @symbol("lua_settop") fn lua_settop(l: *lua_State, idx: int) void;
export @symbol("lua_gettop") fn lua_gettop(l: *lua_State) int;

export @symbol("luaL_openlibs") fn luaL_openlibs(l: *lua_State) void;

@symbol("luaL_loadstring") fn _luaL_loadstring(l: *lua_State, code: *char) int;
@symbol("luaL_loadfilex") fn _luaL_loadfilex(l: *lua_State, filename: *char, mode: nullable *char) int;

export @symbol("luaL_checkinteger") fn luaL_checkinteger(l: *lua_State, arg: int) int;
export @symbol("luaL_checknumber") fn luaL_checknumber(l: *lua_State, arg: int) f64;

@symbol("lua_isnumber") fn _lua_isnumber(l: *lua_State, arg: int) int;
export fn lua_isnumber(l: *lua_State, arg: int) bool = _lua_isnumber(l, arg) != 0;

export @symbol("lua_type") fn lua_type(l: *lua_State, arg: int) int;
export fn lua_isboolean(l: *lua_State, arg: int) bool = lua_type(l, arg) == LUA_TBOOLEAN;

@symbol("lua_toboolean") fn _lua_toboolean(l: *lua_State, arg: int) int;
export fn lua_toboolean(l: *lua_State, arg: int) bool = _lua_toboolean(l, arg) != 0;

@symbol("lua_tolstring") fn _lua_tolstring(l: *lua_State, arg: int, length: nullable *size) *const char;
export fn lua_tostring(l: *lua_State, arg: int) str = types::c::tostr(_lua_tolstring(l, arg, null))!;

@symbol("lua_pushcclosure") fn _lua_pushcclosure(l: *lua_State, _fn: lua_CFunction, n: int) void;

@symbol("lua_setglobal") fn _lua_setglobal(l: *lua_State, name: *const char) void;

@symbol("lua_pcallk") fn _lua_pcallk(
    l: *lua_State,
    nargs: int, nresults: int, errfunc: int,
    ctx: int, k: lua_CFunction,
) int;

@symbol("luaL_typeerror") fn _luaL_typeerror(l: *lua_State, arg: int, tname: *char) void;

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
    // XXX: This allocates every time.
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

export fn luaL_typeerror(l: *lua_State, arg: int, tname: str) void = {
    // XXX: This allocates every time.
    const cstr = types::c::fromstr(tname);
    defer free(cstr);

    _luaL_typeerror(l, arg, cstr);
};

@symbol("lua_getglobal") fn _lua_getglobal(l: *lua_State, gname: *const char) int;

export fn lua_getglobal(l: *lua_State, gname: str) (void | error) = {
    // XXX: This allocates every time.
    const cstr = types::c::fromstr(gname);
    defer free(cstr);

    return wrapvoid(_lua_getglobal(l, cstr));
};

export @symbol("lua_pushinteger") fn lua_pushinteger(l: *lua_State, arg: int) void;
