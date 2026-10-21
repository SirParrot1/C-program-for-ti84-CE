/*
 *--------------------------------------
 * Program Name: Pong
 * Author: Charles Price
 * License:
 * Description: pong game
 *--------------------------------------
*/

#include <graphx.h>
#include <keypadc.h>
#include <time.h>
#include <stdint.h>
#include <stdbool.h>

#define FPS 30
#define PADDLE_WIDTH 5
#define PADDLE_HEIGHT 30
#define BALL_SIZE 6
#define SCREEN_WIDTH 320
#define SCREEN_HEIGHT 240
#define PADDLE_SPEED 6
#define PADDLE_HEIGHT_2 (PADDLE_HEIGHT/2)
#define PADDLE_WIDTH_2 (PADDLE_WIDTH/2)
#define PADDLE_MAX_Y (SCREEN_HEIGHT - PADDLE_HEIGHT_2)
#define PADDLE_MIN_Y PADDLE_HEIGHT_2
#define DIST_FROM_WALL (SCREEN_WIDTH/10)
#define MID_HEIGHT (SCREEN_HEIGHT/2)
#define DRAW_PADDLE(ptr) gfx_FillRectangle(ptr->x-PADDLE_WIDTH_2, ptr->y-(PADDLE_HEIGHT_2), PADDLE_WIDTH, PADDLE_HEIGHT)
#define DRAW_BALL gfx_FillRectangle(ball_x-(BALL_SIZE/2)-1, ball_y-(BALL_SIZE/2)-1, BALL_SIZE, BALL_SIZE)

#define gfx_black 0x00
#define gfx_white 0xFF

#define MAX_BALL_DY 12
#define MAX_BALL_DX 12
#define BALL_DX_INC 1
#define BALL_OUT_X ((PADDLE_WIDTH + BALL_SIZE) / 2)
#define BALL_INC (ball_dx >= 0) ? BALL_DX_INC : -BALL_DX_INC


typedef struct {
    int x, y;
} Paddle;

int score1 = 0;
int score2 = 0;

int ball_x = 160, ball_y = 120;
int ball_dx = 2, ball_dy = 2;

bool score = false;

bool in_paddle(const Paddle *p);

bool hit_deck();

void move_paddle(Paddle *paddle, int direction);

void move_ball(Paddle *p1, Paddle *p2);
    
void check_ob();

void reset_game(Paddle *p1, Paddle *p2);


int main(void)
{
    Paddle pad_plyr = {DIST_FROM_WALL, MID_HEIGHT};
    Paddle pad_comp = {SCREEN_WIDTH - DIST_FROM_WALL, MID_HEIGHT};

    Paddle *ptr_pad_plyr = &pad_plyr;
    Paddle *ptr_pad_comp = &pad_comp;

    ball_x = 160, ball_y = 120;
    ball_dx = 2, ball_dy = 4;

    gfx_Begin();/*320x240 , (0,0)-(319,239)*/
    gfx_SetDrawBuffer();

    
    
    bool running = true;
    while (running) {
        clock_t start = clock();

        move_ball(ptr_pad_plyr, ptr_pad_comp);

        kb_Scan();
        if (kb_IsDown(kb_KeyClear)) running = false;
        if (kb_IsDown(kb_KeyDown)) {move_paddle(ptr_pad_plyr, 1); move_paddle(ptr_pad_comp, 1);}
        if (kb_IsDown(kb_KeyUp)) {move_paddle(ptr_pad_plyr, -1); move_paddle(ptr_pad_comp, -1);}
        if (kb_IsDown(kb_Key2nd)) reset_game(ptr_pad_plyr, ptr_pad_comp);
        

        gfx_FillScreen(gfx_black);
        gfx_SetColor(gfx_white);

        gfx_VertLine((SCREEN_WIDTH/2)-1, 0, SCREEN_HEIGHT);
        gfx_SetTextFGColor(gfx_white);
        gfx_SetTextScale(2, 2);
        gfx_SetTextXY(140, 20);
        gfx_PrintInt(score1, 3);
        DRAW_BALL;
        DRAW_PADDLE(ptr_pad_plyr);
        DRAW_PADDLE(ptr_pad_comp);

        gfx_SwapDraw();

        while (clock() - start < CLOCKS_PER_SEC / FPS);
        

        check_ob();

        if (score) reset_game(ptr_pad_plyr, ptr_pad_comp);


    }

    gfx_End();
    return 0;
}

/*Function definition*/

bool in_paddle(const Paddle *p) {
    int dx = ball_x - p->x;
    int dy = ball_y - p->y;
    if (dx < 0) dx *= -1;
    if (dy < 0) dy *= -1;

    return 
        dx <= (PADDLE_WIDTH + BALL_SIZE) / 2 &&
        dy <= (PADDLE_HEIGHT + BALL_SIZE) /2;
}  

bool hit_deck() {
    return
        (ball_y > SCREEN_HEIGHT - BALL_SIZE) ||
        (ball_y < BALL_SIZE);
}

void move_paddle(Paddle *paddle, int direction) {
    paddle->y += direction * (PADDLE_SPEED + (abs(ball_dx) + abs(ball_dy)) / 4);
    if (paddle->y < PADDLE_MIN_Y) paddle->y = PADDLE_MIN_Y;
    if (paddle->y > PADDLE_MAX_Y) paddle->y = PADDLE_MAX_Y;
}

void check_ob() {
    if (ball_x <= 0) {score = true; score1++;}
    if (ball_x >= SCREEN_WIDTH) {score = true; score2++;}
}

void reset_game(Paddle *p1, Paddle *p2) {
    ball_x = 160, ball_y = 120;
    ball_dx = 2, ball_dy = 2;
    
    p1->x = DIST_FROM_WALL; 
    p1->y = MID_HEIGHT;
    p2->x = SCREEN_WIDTH - DIST_FROM_WALL;
    p2->y = MID_HEIGHT;

    score = false;
    gfx_FillScreen(gfx_black);
}

void move_ball(Paddle *p1, Paddle *p2) {
    ball_x += ball_dx;
    ball_y += ball_dy;

    bool P1 = in_paddle(p1);
    bool P2 = in_paddle(p2);

    int dy1 = (ball_y - p1->y);
    int dy2 = (ball_y - p2->y);

    if (hit_deck()) ball_dy *= -1;
    if (P1 || P2) {
        ball_dx *= -1;
        
        if (P1) {ball_x = p1->x + BALL_OUT_X; ball_dy += dy1 / 2; ball_dx += BALL_INC / (1 - (dy1 / PADDLE_HEIGHT_2));}
        if (P2) {ball_x = p2->x - BALL_OUT_X; ball_dy += dy2 / 2; ball_dx += BALL_INC / (1 - (dy2 / PADDLE_HEIGHT_2));}
    }

    if (abs(ball_dy) > MAX_BALL_DY) ball_dy = (ball_dy > 0) ? MAX_BALL_DY : -MAX_BALL_DY;
    if (abs(ball_dx) > MAX_BALL_DX) ball_dx = (ball_dx > 0) ? MAX_BALL_DX : -MAX_BALL_DX;

}