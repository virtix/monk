#include <unistd.h>
#include <stdlib.h>
#include "ctest.h"

// basic test without setup/teardown
CTEST(suite1, test1) {
    usleep(2000);
}
