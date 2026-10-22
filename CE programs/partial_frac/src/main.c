/*
 *--------------------------------------
 * Program Name:
 * Author: Charles Price
 * License:
 * Description:
 *--------------------------------------
*/


//?

//#include <graphx.h> not now, graphx and OS screen don't play nice
#include <stdint.h>
#include <keypadc.h>//not used
#include <stdbool.h>
#include <stdlib.h>
#include <tice.h>
#include <ti/screen.h>
#include <ti/sprintf.h>
#include <ti/getcsc.h>

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

/*Declare
 *--------------------------------------
 * Declare Functions
 *--------------------------------------
*/
static int digit_of(sk_key_t k);
static bool input_int(const char *prompt, uint8_t row, int *out);



//Main
int main(void)
{
    int num;

    os_ClrHome();
    if (input_int("num? ", 0, &num)) {
        os_SetCursorPos(1, 0);

        char buf[20];
        boot_sprintf(buf, "Score: %d", num);
        os_PutStrFull(buf);

    }

    while (!os_GetCSC());
    return 0;
}


/*Define
 *--------------------------------------
 * Define Functions
 *--------------------------------------
*/



/* Which digit a key is, or -1 if it isn't a digit key.
   The key codes aren't in order, so each one is listed. */
static int digit_of(sk_key_t k)
{
    switch (k) {
        case sk_0: return 0;
        case sk_1: return 1;
        case sk_2: return 2;
        case sk_3: return 3;
        case sk_4: return 4;
        case sk_5: return 5;
        case sk_6: return 6;
        case sk_7: return 7;
        case sk_8: return 8;
        case sk_9: return 9;
        default:   return -1;
    }
}

/* Ask for an integer on home-screen row `row`.
   Digits type, (-) makes it negative, DEL backspaces,
   ENTER accepts, CLEAR cancels.
   Returns true and sets *out on ENTER, false on CLEAR. */
static bool input_int(const char *prompt, uint8_t row, int *out)
{
    char buf[8];          /* '-' + up to 6 digits + end marker */
    uint8_t len = 0;
    buf[0] = '\0';

    while (true) {
        /* Redraw the line: prompt, what's typed, a cursor,
           and a space to erase a character after DEL. */
        os_SetCursorPos(row, 0);
        os_PutStrFull(prompt);
        os_PutStrFull(buf);
        os_PutStrFull("_ ");

        sk_key_t k;
        while (!(k = os_GetCSC()));   /* wait for a key */

        bool negative = (len > 0 && buf[0] == '-');
        uint8_t digits = len - negative;
        int d = digit_of(k);

        if (d >= 0 && digits < 6) {
            buf[len++] = '0' + d;
            buf[len] = '\0';
        } else if (k == sk_Chs && len == 0) {   /* the (-) key */
            buf[len++] = '-';
            buf[len] = '\0';
        } else if (k == sk_Del && len > 0) {
            buf[--len] = '\0';
        } else if (k == sk_Enter && digits > 0) {
            *out = atoi(buf);
            return true;
        } else if (k == sk_Clear) {
            return false;
        }
    }
}