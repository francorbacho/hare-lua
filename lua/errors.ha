export def LUA_OK:        int = 0;
export def LUA_YIELD:     int = 1;
export def LUA_ERRRUN:    int = 2;
export def LUA_ERRSYNTAX: int = 3;
export def LUA_ERRMEM:    int = 4;
export def LUA_ERRGCMM:   int = 5;
export def LUA_ERRERR:    int = 6;

export type errrun = !void;
export type errsyntax = !void;
export type errmemory = !void;
export type errgcmm = !void;
export type errerr = !void;
export type errunknown = !void;

export type error = !(
    errrun | errsyntax | errmemory | errgcmm | errerr | errunknown
);

export fn wrapvoid(res: int) (void | error) = {
    switch (res) {
    case LUA_OK => return;
    case LUA_YIELD => return;
    case LUA_ERRRUN => return errrun;
    case LUA_ERRSYNTAX => return errsyntax;
    case LUA_ERRMEM => return errmemory;
    case LUA_ERRGCMM => return errgcmm;
    case LUA_ERRERR => return errerr;
    case => return errunknown;
    };
};
