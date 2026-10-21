/*
 *--------------------------------------
 * Program Name:
 * Author: Charles Price
 * License:
 * Description:
 *--------------------------------------
*/


#include <stdint.h>
#include <stdbool.h>
#include <tice.h>
#include <graphx.h>
#include <keypadc.h>

/* ---- Config ---- */
#define BG_COLOR  255   /* white (default xlibc palette) */
#define FG_COLOR  0     /* black */

int main(void)
{
    /* Init */
    gfx_Begin();
    gfx_SetDrawBuffer();

    /* Main loop: runs until [clear] is pressed */
    do
    {
        kb_Scan();

        gfx_FillScreen(BG_COLOR);
        gfx_SetTextFGColor(FG_COLOR);
        gfx_PrintStringXY("Hello, CE!", 8, 8);

        gfx_SwapDraw();
    } while (!kb_IsDown(kb_KeyClear));

    /* Cleanup */
    gfx_End();
    return 0;
}
