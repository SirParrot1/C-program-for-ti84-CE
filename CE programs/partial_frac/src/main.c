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

/*
*--------------------------------------
The plan
user inputs the amount of components, and the numerator function
    -Or, it inputs the factors with multiplicity, i.e. 1 (root) ,2 (multiplicity) -> (x-1)^2
user inputs the corresponding function, related to the component (if the factors are not entered or whatever)

then it gotta make a matrix or somthing with the test points (any test point should be vaild, but 1,2,3,... probably is easy)
then do rref on the matrix

then visualize it or whatever, maybe write out the fraction decomposition

*--------------------------------------
*/

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
