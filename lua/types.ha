def LUA_TNONE = -1;
def LUA_TNIL = 0;
def LUA_TBOOLEAN = 1;
def LUA_TLIGHTUSERDATA = 2;
def LUA_TNUMBER = 3;
def LUA_TSTRING = 4;
def LUA_TTABLE = 5;
def LUA_TFUNCTION = 6;
def LUA_TUSERDATA = 7;
def LUA_TTHREAD = 8;
def LUA_NUMTYPES = 9;

export fn strtype(codetype: int) str = switch (codetype) {
    case LUA_TNONE => return "none";
    case LUA_TNIL => return "nil";
    case LUA_TBOOLEAN => return "boolean";
    case LUA_TLIGHTUSERDATA => return "lightuserdata";
    case LUA_TNUMBER => return "number";
    case LUA_TSTRING => return "string";
    case LUA_TTABLE => return "table";
    case LUA_TFUNCTION => return "function";
    case LUA_TUSERDATA => return "userdata";
    case LUA_TTHREAD => return "thread";
    case LUA_NUMTYPES => return "numtype";
    case => return "unknown (?)";
};
