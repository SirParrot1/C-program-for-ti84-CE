	.section	.text,"ax",@progbits
	.assume	ADL = 1
	.file	"llvm-link"
	.section	.text._main,"ax",@progbits
	.globl	_main                           ; -- Begin function main
	.type	_main,@function
_main:                                  ; @main
; %bb.0:
	ld	hl, -24
	call	__frameset
	ld	hl, ___const.main.pad_plyr
	lea	de, ix - 6
	lea	iy, ix - 12
	ld	(ix - 15), de
	ld	bc, 6
	ldir
	ld	(ix - 18), iy
	lea	de, iy + 0
	ld	hl, ___const.main.pad_comp
	ld	bc, 6
	ldir
	ld	hl, 160
	ld	(_ball_x), hl
	ld	hl, 120
	ld	(_ball_y), hl
	ld	hl, 2
	ld	(_ball_dx), hl
	ld	hl, 4
	ld	(_ball_dy), hl
	call	_gfx_Begin
	ld	hl, 1
	push	hl
	call	_gfx_SetDraw
	pop	hl
	.local	.LBB0_1
.LBB0_1:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_6 Depth 2
	call	_clock
	ld	(ix - 21), hl
	ld	(ix - 22), e                    ; 1-byte Folded Spill
	ld	hl, (ix - 18)
	push	hl
	ld	hl, (ix - 15)
	push	hl
	call	_move_ball
	pop	hl
	pop	hl
	call	_kb_Scan
	ld	hl, -720868
	push	de
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	l, e
	ld	h, d
	pop	de
	ld	(ix - 24), l
	ld	(ix - 23), h
	ld	hl, -720866
	push	de
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	l, e
	ld	h, d
	pop	de
	ld.sis	bc, 1
	call	__sand
	bit	0, l
	jr	z, .LBB0_3
; %bb.2:                                ;   in Loop: Header=BB0_1 Depth=1
	ld	hl, 1
	push	hl
	ld	hl, (ix - 15)
	push	hl
	call	_move_paddle
	pop	hl
	pop	hl
	ld	hl, 1
	push	hl
	ld	hl, (ix - 18)
	push	hl
	call	_move_paddle
	pop	hl
	pop	hl
	.local	.LBB0_3
.LBB0_3:                                ;   in Loop: Header=BB0_1 Depth=1
	ld	hl, -720866
	push	de
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	l, e
	ld	h, d
	pop	de
	ld	a, l
	bit	3, a
	jr	z, .LBB0_5
; %bb.4:                                ;   in Loop: Header=BB0_1 Depth=1
	scf
	sbc	hl, hl
	push	hl
	ld	hl, (ix - 15)
	push	hl
	call	_move_paddle
	pop	hl
	pop	hl
	scf
	sbc	hl, hl
	push	hl
	ld	hl, (ix - 18)
	push	hl
	call	_move_paddle
	pop	hl
	pop	hl
	.local	.LBB0_5
.LBB0_5:                                ;   in Loop: Header=BB0_1 Depth=1
	ld	hl, -720878
	push	de
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	l, e
	ld	h, d
	pop	de
	ld	a, l
	bit	5, a
	ld	hl, (ix - 18)
	push	hl
	ld	hl, (ix - 15)
	push	hl
	call	nz, _reset_game
	pop	hl
	pop	hl
	ld	l, (ix - 24)
	ld	h, (ix - 23)
	ld	(ix - 24), l                    ; 1-byte Folded Spill
	or	a, a
	sbc	hl, hl
	push	hl
	call	_gfx_FillScreen
	pop	hl
	ld	hl, 255
	push	hl
	call	_gfx_SetColor
	pop	hl
	ld	hl, 240
	push	hl
	or	a, a
	sbc	hl, hl
	push	hl
	ld	hl, 159
	push	hl
	call	_gfx_VertLine
	pop	hl
	pop	hl
	pop	hl
	ld	hl, 255
	push	hl
	call	_gfx_SetTextFGColor
	pop	hl
	ld	hl, 2
	push	hl
	push	hl
	call	_gfx_SetTextScale
	pop	hl
	pop	hl
	ld	hl, 20
	push	hl
	ld	hl, 140
	push	hl
	call	_gfx_SetTextXY
	pop	hl
	pop	hl
	ld	hl, (_score1)
	ld	de, 3
	push	de
	push	hl
	call	_gfx_PrintInt
	pop	hl
	pop	hl
	ld	iy, (_ball_x)
	ld	hl, -4
	ex	de, hl
	add	iy, de
	ld	hl, (_ball_y)
	add	hl, de
	ld	de, 6
	push	de
	push	de
	push	hl
	push	iy
	call	_gfx_FillRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	iy, (ix - 6)
	ld	hl, -2
	ex	de, hl
	add	iy, de
	ld	hl, (ix - 3)
	ld	de, -15
	add	hl, de
	ld	de, 30
	push	de
	ld	de, 5
	push	de
	push	hl
	push	iy
	call	_gfx_FillRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	ld	iy, (ix - 12)
	ld	de, -2
	add	iy, de
	ld	hl, (ix - 9)
	ld	de, -15
	add	hl, de
	ld	de, 30
	push	de
	ld	de, 5
	push	de
	push	hl
	push	iy
	call	_gfx_FillRectangle
	pop	hl
	pop	hl
	pop	hl
	pop	hl
	call	_gfx_SwapDraw
	.local	.LBB0_6
.LBB0_6:                                ;   Parent Loop BB0_1 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	call	_clock
	ld	bc, (ix - 21)
	ld	a, (ix - 22)                    ; 1-byte Folded Reload
	call	__lsub
	ld	bc, 1092
	xor	a, a
	call	__lcmpu
	jr	c, .LBB0_6
; %bb.7:                                ;   in Loop: Header=BB0_1 Depth=1
	call	_check_ob
	ld	a, (_score)
	bit	0, a
	ld	hl, (ix - 18)
	push	hl
	ld	hl, (ix - 15)
	push	hl
	call	nz, _reset_game
	pop	hl
	pop	hl
	bit	6, (ix - 24)                    ; 1-byte Folded Reload
	jp	z, .LBB0_1
; %bb.8:
	call	_gfx_End
	or	a, a
	sbc	hl, hl
	ld	sp, ix
	pop	ix
	ret
	.local	.Lfunc_end0
.Lfunc_end0:
	.size	_main, .Lfunc_end0-_main
                                        ; -- End function
	.section	.text._move_ball,"ax",@progbits
	.globl	_move_ball                      ; -- Begin function move_ball
	.type	_move_ball,@function
_move_ball:                             ; @move_ball
; %bb.0:
	ld	hl, -18
	call	__frameset
	ld	bc, (ix + 6)
	ld	de, (_ball_dx)
	ld	hl, (_ball_x)
	ld	(ix - 3), de
	add	hl, de
	ld	(_ball_x), hl
	ld	de, (_ball_dy)
	ld	hl, (_ball_y)
	ld	(ix - 9), de
	add	hl, de
	ld	(ix - 12), hl
	ld	(_ball_y), hl
	push	bc
	call	_in_paddle
	ld	(ix - 6), a                     ; 1-byte Folded Spill
	pop	hl
	ld	hl, (ix + 9)
	push	hl
	call	_in_paddle
	pop	hl
	ld	iy, (ix + 6)
	ld	de, (iy + 3)
	ld	bc, (ix - 12)
	push	bc
	pop	hl
	or	a, a
	sbc	hl, de
	ld	(ix - 18), hl
	ld	iy, (ix + 9)
	ld	de, (iy + 3)
	push	bc
	pop	iy
	lea	hl, iy + 0
	or	a, a
	sbc	hl, de
	ld	(ix - 15), hl
	ld	de, -235
	add	iy, de
	ld	de, -229
	lea	hl, iy + 0
	or	a, a
	sbc	hl, de
	jr	nc, .LBB1_2
; %bb.1:
	ld	hl, (ix - 9)
	call	__ineg
	push	hl
	pop	iy
	ld	(_ball_dy), iy
	jr	.LBB1_3
	.local	.LBB1_2
.LBB1_2:
	ld	iy, (ix - 9)
	.local	.LBB1_3
.LBB1_3:
	bit	0, (ix - 6)                     ; 1-byte Folded Reload
	ld	bc, (ix - 3)
	jr	nz, .LBB1_5
; %bb.4:
	bit	0, a
	jp	z, .LBB1_14
	.local	.LBB1_5
.LBB1_5:
	push	bc
	pop	hl
	call	__ineg
	ex	de, hl
	ld	(_ball_dx), de
	bit	0, (ix - 6)                     ; 1-byte Folded Reload
	jr	z, .LBB1_9
; %bb.6:
	ld	de, 5
	ld	hl, (ix + 6)
	ld	hl, (hl)
	add	hl, de
	ld	(_ball_x), hl
	ld	bc, (ix - 18)
	push	bc
	pop	hl
	add	hl, hl
	sbc	hl, hl
	add	hl, hl
	ccf
	sbc	hl, hl
	inc	hl
	ex	de, hl
	push	bc
	pop	hl
	add	hl, de
	call	__ishrs_1
	ex	de, hl
	add	iy, de
	ld	(_ball_dy), iy
	ld	de, 1
	ld	hl, (ix - 3)
	or	a, a
	sbc	hl, de
	call	pe, __setflag
	ld	hl, 1
	ld	(ix - 6), hl
	jp	m, .LBB1_8
; %bb.7:
	push	bc
	pop	hl
	ld	bc, -15
	call	__idivs
	push	hl
	pop	bc
	inc	bc
	scf
	sbc	hl, hl
	call	__idivs
	.local	.LBB1_8
.LBB1_8:
	ld	de, (ix - 3)
	or	a, a
	sbc	hl, de
	ex	de, hl
	ld	(_ball_dx), de
	jr	.LBB1_10
	.local	.LBB1_9
.LBB1_9:
	ld	hl, 1
	ld	(ix - 6), hl
	.local	.LBB1_10
.LBB1_10:
	bit	0, a
	jr	z, .LBB1_15
; %bb.11:
	ld	bc, -5
	ld	hl, (ix + 9)
	ld	hl, (hl)
	add	hl, bc
	ld	(_ball_x), hl
	ld	(ix - 3), iy
	ld	iy, (ix - 15)
	lea	hl, iy + 0
	add	hl, hl
	sbc	hl, hl
	add	hl, hl
	ccf
	sbc	hl, hl
	inc	hl
	push	hl
	pop	bc
	lea	hl, iy + 0
	ld	iy, (ix - 3)
	add	hl, bc
	call	__ishrs_1
	push	hl
	pop	bc
	add	iy, bc
	ld	(_ball_dy), iy
	ld	bc, 0
	push	de
	pop	hl
	or	a, a
	sbc	hl, bc
	call	pe, __setflag
	jp	p, .LBB1_13
; %bb.12:
	ld	hl, (ix - 15)
	ld	bc, -15
	call	__idivs
	push	hl
	pop	bc
	inc	bc
	scf
	sbc	hl, hl
	call	__idivs
	ld	(ix - 6), hl
	.local	.LBB1_13
.LBB1_13:
	ld	hl, (ix - 6)
	add	hl, de
	push	hl
	pop	de
	ld	(_ball_dx), hl
	jr	.LBB1_15
	.local	.LBB1_14
.LBB1_14:
	push	bc
	pop	de
	.local	.LBB1_15
.LBB1_15:
	ld	hl, 12
	ld	(ix - 3), hl
	lea	hl, iy + 0
	add	hl, hl
	sbc	hl, hl
	push	hl
	pop	bc
	lea	hl, iy + 0
	add	hl, bc
	call	__ixor
	ld	bc, 13
	or	a, a
	sbc	hl, bc
	jr	c, .LBB1_19
; %bb.16:
	ld	bc, 1
	lea	hl, iy + 0
	or	a, a
	sbc	hl, bc
	call	pe, __setflag
	ld	hl, 12
	jp	p, .LBB1_18
; %bb.17:
	ld	hl, -12
	.local	.LBB1_18
.LBB1_18:
	ld	(_ball_dy), hl
	.local	.LBB1_19
.LBB1_19:
	push	de
	pop	hl
	add	hl, hl
	sbc	hl, hl
	push	hl
	pop	bc
	push	de
	pop	hl
	add	hl, bc
	call	__ixor
	ld	bc, 13
	or	a, a
	sbc	hl, bc
	jr	c, .LBB1_23
; %bb.20:
	ld	bc, 1
	ex	de, hl
	or	a, a
	sbc	hl, bc
	call	pe, __setflag
	jp	p, .LBB1_22
; %bb.21:
	ld	hl, -12
	ld	(ix - 3), hl
	.local	.LBB1_22
.LBB1_22:
	ld	hl, (ix - 3)
	ld	(_ball_dx), hl
	.local	.LBB1_23
.LBB1_23:
	ld	sp, ix
	pop	ix
	ret
	.local	.Lfunc_end1
.Lfunc_end1:
	.size	_move_ball, .Lfunc_end1-_move_ball
                                        ; -- End function
	.section	.text._move_paddle,"ax",@progbits
	.globl	_move_paddle                    ; -- Begin function move_paddle
	.type	_move_paddle,@function
_move_paddle:                           ; @move_paddle
; %bb.0:
	call	__frameset0
	ld	iy, (_ball_dx)
	lea	hl, iy + 0
	add	hl, hl
	sbc	hl, hl
	push	hl
	pop	bc
	add	iy, bc
	lea	hl, iy + 0
	call	__ixor
	ex	de, hl
	ld	iy, (_ball_dy)
	lea	hl, iy + 0
	add	hl, hl
	sbc	hl, hl
	push	hl
	pop	bc
	add	iy, bc
	lea	hl, iy + 0
	call	__ixor
	add	hl, de
	ld	c, 2
	call	__ishru
	ld	de, 6
	add	hl, de
	ld	bc, (ix + 9)
	call	__imulu
	ld	iy, (ix + 6)
	ld	de, (iy + 3)
	add	hl, de
	ld	de, 16
	push	hl
	pop	bc
	or	a, a
	sbc	hl, de
	call	pe, __setflag
	jp	p, .LBB2_2
; %bb.1:
	ld	bc, 15
	.local	.LBB2_2
.LBB2_2:
	ld	de, 225
	push	bc
	pop	hl
	or	a, a
	sbc	hl, de
	jr	c, .LBB2_4
; %bb.3:
	ld	bc, 225
	.local	.LBB2_4
.LBB2_4:
	ld	(iy + 3), bc
	pop	ix
	ret
	.local	.Lfunc_end2
.Lfunc_end2:
	.size	_move_paddle, .Lfunc_end2-_move_paddle
                                        ; -- End function
	.section	.text._reset_game,"ax",@progbits
	.globl	_reset_game                     ; -- Begin function reset_game
	.type	_reset_game,@function
_reset_game:                            ; @reset_game
; %bb.0:
	call	__frameset0
	ld	iy, (ix + 6)
	ld	hl, (ix + 9)
	ld	de, 120
	xor	a, a
	ld	bc, 160
	ld	(_ball_x), bc
	ld	(_ball_y), de
	ld	bc, 2
	ld	(_ball_dx), bc
	ld	(_ball_dy), bc
	ld	bc, 32
	ld	(iy), bc
	ld	(iy + 3), de
	push	hl
	pop	iy
	ld	hl, 288
	ld	(iy), hl
	ld	(iy + 3), de
	ld	(_score), a
	ld	(ix + 6), a
	pop	ix
	jp	_gfx_FillScreen
	.local	.Lfunc_end3
.Lfunc_end3:
	.size	_reset_game, .Lfunc_end3-_reset_game
                                        ; -- End function
	.section	.text._check_ob,"ax",@progbits
	.globl	_check_ob                       ; -- Begin function check_ob
	.type	_check_ob,@function
_check_ob:                              ; @check_ob
; %bb.0:
	ld	de, (_ball_x)
	ld	bc, 1
	push	de
	pop	hl
	or	a, a
	sbc	hl, bc
	call	pe, __setflag
	jp	p, .LBB4_2
; %bb.1:
	ld	hl, _score1
	jr	.LBB4_4
	.local	.LBB4_2
.LBB4_2:
	ld	bc, 320
	ex	de, hl
	or	a, a
	sbc	hl, bc
	jr	c, .LBB4_5
; %bb.3:
	ld	hl, _score2
	.local	.LBB4_4
.LBB4_4:
	ld	a, 1
	ld	(_score), a
	ld	de, (hl)
	inc	de
	ld	(hl), de
	.local	.LBB4_5
.LBB4_5:
	ret
	.local	.Lfunc_end4
.Lfunc_end4:
	.size	_check_ob, .Lfunc_end4-_check_ob
                                        ; -- End function
	.section	.text._in_paddle,"ax",@progbits
	.globl	_in_paddle                      ; -- Begin function in_paddle
	.type	_in_paddle,@function
_in_paddle:                             ; @in_paddle
; %bb.0:
	call	__frameset0
	ld	iy, (ix + 6)
	ld	hl, (_ball_x)
	ld	de, (iy)
	or	a, a
	sbc	hl, de
	push	hl
	pop	bc
	ld	hl, (_ball_y)
	ld	de, (iy + 3)
	or	a, a
	sbc	hl, de
	ex	de, hl
	push	bc
	pop	iy
	lea	hl, iy + 0
	add	hl, hl
	sbc	hl, hl
	push	hl
	pop	bc
	add	iy, bc
	lea	hl, iy + 0
	call	__ixor
	push	hl
	pop	iy
	push	de
	pop	hl
	add	hl, hl
	sbc	hl, hl
	push	hl
	pop	bc
	ex	de, hl
	add	hl, bc
	call	__ixor
	ld	bc, 19
	or	a, a
	sbc	hl, bc
                                        ; kill: def $a killed $a
	sbc	a, a
	ld	e, a
	ld	bc, 6
	lea	hl, iy + 0
	or	a, a
	sbc	hl, bc
                                        ; kill: def $a killed $a
	sbc	a, a
	and	a, e
	ld	l, a
	pop	ix
	ret
	.local	.Lfunc_end5
.Lfunc_end5:
	.size	_in_paddle, .Lfunc_end5-_in_paddle
                                        ; -- End function
	.section	.text._hit_deck,"ax",@progbits
	.globl	_hit_deck                       ; -- Begin function hit_deck
	.type	_hit_deck,@function
_hit_deck:                              ; @hit_deck
; %bb.0:
	ld	de, -235
	ld	hl, (_ball_y)
	add	hl, de
	ld	de, -229
	or	a, a
	sbc	hl, de
                                        ; kill: def $a killed $a
	sbc	a, a
	ret
	.local	.Lfunc_end6
.Lfunc_end6:
	.size	_hit_deck, .Lfunc_end6-_hit_deck
                                        ; -- End function
	.section	.bss._score1,"aw",@nobits
	.balign	1
	.globl	_score1
_score1:
	.zero	3

	.section	.bss._score2,"aw",@nobits
	.balign	1
	.globl	_score2
_score2:
	.zero	3

	.section	.data._ball_x,"aw",@progbits
	.balign	1
	.globl	_ball_x
_ball_x:
	d24	160                             ; 0xa0

	.section	.data._ball_y,"aw",@progbits
	.balign	1
	.globl	_ball_y
_ball_y:
	d24	120                             ; 0x78

	.section	.data._ball_dx,"aw",@progbits
	.balign	1
	.globl	_ball_dx
_ball_dx:
	d24	2                               ; 0x2

	.section	.data._ball_dy,"aw",@progbits
	.balign	1
	.globl	_ball_dy
_ball_dy:
	d24	2                               ; 0x2

	.section	.bss._score,"aw",@nobits
	.balign	1
	.globl	_score
_score:
	.zero	1

	.section	.rodata.___const.main.pad_plyr,"a",@progbits
	.balign	1
	.local	___const.main.pad_plyr
___const.main.pad_plyr:
	d24	32                              ; 0x20
	d24	120                             ; 0x78

	.section	.rodata.___const.main.pad_comp,"a",@progbits
	.balign	1
	.local	___const.main.pad_comp
___const.main.pad_comp:
	d24	288                             ; 0x120
	d24	120                             ; 0x78

	.ident	"clang version 19.1.0 (https://github.com/CE-Programming/llvm-project ef28e9c54cd1333a6091ab2ffbd315b465fc5090)"
	.section	".note.GNU-stack","",@progbits
	.extern	_llvm.umin.i24
	.extern	_llvm.memcpy.p0.p0.i24
	.extern	_gfx_SetColor
	.extern	_llvm.eh.sjlj.functioncontext
	.extern	_clock
	.extern	_gfx_End
	.extern	__lsub
	.extern	_llvm.smax.i24
	.extern	_llvm.eh.sjlj.setup.dispatch
	.extern	_llvm.eh.sjlj.callsite
	.extern	_gfx_FillRectangle
	.extern	_llvm.stacksave.p0
	.extern	_llvm.lifetime.end.p0
	.extern	_llvm.lifetime.start.p0
	.extern	_gfx_SwapDraw
	.extern	__ishru
	.extern	__frameset0
	.extern	__Unwind_SjLj_Register
	.extern	_gfx_PrintInt
	.extern	_llvm.frameaddress.p0
	.extern	_gfx_VertLine
	.extern	__Unwind_SjLj_Unregister
	.extern	_gfx_FillScreen
	.extern	_llvm.eh.sjlj.lsda
	.extern	_llvm.abs.i24
	.extern	__sand
	.extern	__idivs
	.extern	_gfx_SetTextXY
	.extern	_llvm.stackrestore.p0
	.extern	_gfx_SetDraw
	.extern	__frameset
	.extern	_kb_Scan
	.extern	__lcmpu
	.extern	__ixor
	.extern	_gfx_SetTextFGColor
	.extern	__ishrs_1
	.extern	_gfx_SetTextScale
	.extern	__imulu
	.extern	__setflag
	.extern	__ineg
	.extern	_gfx_Begin
