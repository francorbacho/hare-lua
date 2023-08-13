use types::c;

export type luaL_Reg = struct {
    name: nullable *const types::c::char,
    func: lua_CFunction,
};

export @symbol("lua_createtable") fn lua_createtable(l: *lua_State, narr: int, nrec: int) void;
export fn lua_newtable(l: *lua_State) void = lua_createtable(l, 0, 0);

@symbol("luaL_setfuncs") fn _luaL_setfuncs(l: *lua_State, reg: *luaL_Reg, nup: int) void;

export fn reg(name: str, func: *harefunc) luaL_Reg = {
    // XXX: We leak memory here. Too bad...
    const cstr = types::c::fromstr(name);

    return luaL_Reg {
        name = cstr,
        func = func,
    };
};

export fn reg_null() luaL_Reg = {
    return luaL_Reg {
        name = null,
        func = null,
    };
};

export fn luaL_setfuncs(l: *lua_State, reg: []luaL_Reg, nup: int) void = {
    _luaL_setfuncs(l, &reg[0], nup);
};
