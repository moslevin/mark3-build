/*===========================================================================
     _____        _____        _____        _____
 ___|    _|__  __|_    |__  __|__   |__  __| __  |__  ______
|    \  /  | ||    \      ||     |     ||  |/ /     ||___   |
|     \/   | ||     \     ||     \     ||     \     ||___   |
|__/\__/|__|_||__|\__\  __||__|\__\  __||__|\__\  __||______|
    |_____|      |_____|      |_____|      |_____|

--[Mark3 Realtime Platform]--------------------------------------------------

Copyright (c) 2018 m0slevin, all rights reserved.
See license.txt for more information
===========================================================================*/
/**
    @file   ut_support.cpp
    @brief  Unit test support for terminal output abstraction
 */

#include "mark3.h"
#include "driver.h"
#include "memutil.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

extern "C" {
void DebugPrint(const char* szString_)
{
    ::printf("%s", szString_);
}
}

//---------------------------------------------------------------------------
using namespace Mark3;
namespace Mark3
{
// Simple device driver for outputting data via the ARM semihosting interface
class StdioMonitor : public Driver
{
public:
    virtual int Init() { return 0; }

    virtual int Open() { return 0; }

    virtual int Close() { return 0; }

    virtual size_t Read(void* pvData_, size_t uBytes_)
    {
        return read(0, pvData_, uBytes_);
    }

    virtual size_t Write(const void* pvData_, size_t uBytes_)
    {
        return write(1, pvData_, uBytes_);
    }

    virtual int Control(uint16_t u16Event_, void* pvIn_, size_t uSizeIn_, const void* pvOut_, size_t uSizeOut_)
    {
        return 0;
    }
};

static StdioMonitor clMonitor;

namespace UnitTestSupport
{
    void OnInit(void)
    {
        clMonitor.SetName("/dev/tty"); //!< Add the serial driver
        clMonitor.Init();

        DriverList::Add(&clMonitor);
    }

    void OnStart(void) { clMonitor.Open(); }

    void OnIdle(void)
    {
        // stub
    }

    void OnExit(int rc) { exit(rc); }
} // namespace UnitTest
} // namespace Mark3
