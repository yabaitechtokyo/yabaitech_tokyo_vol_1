#include "acryl.h"

ACRYL_BEGIN
    f = PROC(L_10, 1, 3);
    PUSH(make_int(2));
    PUSH(f);
    TAILCALL(2);
    
L_10:
    PUSH(make_int(1));
    PUSH(ARG(0, 1));
    PUSH(add);
    CALL(3);
    REG(2) = val0;
    PUSH(make_int(3));
    PUSH(ARG(0, 1));
    PUSH(add);
    CALL(3);
    REG(1) = val0;
    PUSH(make_int(2));
    PUSH(REG(1));
    PUSH(add);
    CALL(3);
    REG(0) = val0;
    PUSH(REG(2));
    PUSH(REG(0));
    PUSH(add);
    TAILCALL(3);
    
ACRYL_END
