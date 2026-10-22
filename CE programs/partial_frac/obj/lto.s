	.section	.text,"ax",@progbits
	.assume	ADL = 1
	.file	"llvm-link"
	.section	.text._main,"ax",@progbits
	.globl	_main                           ; -- Begin function main
	.type	_main,@function
_main:                                  ; @main
; %bb.0:
	ld	hl, -29
	call	__frameset
	lea	hl, ix - 20
	ld	(ix - 26), hl
	ld	iy, -3145600
	call	_os_ClrLCD
	call	_os_HomeUp
	call	_os_DrawStatusBar
	ld	(ix - 20), 0
	ld	hl, (ix - 26)
	inc	hl
	ld	(ix - 29), hl
	ld	h, 0
	.local	.LBB0_1
.LBB0_1:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_2 Depth 2
                                        ;       Child Loop BB0_3 Depth 3
	ld	(ix - 23), h
	.local	.LBB0_2
.LBB0_2:                                ;   Parent Loop BB0_1 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB0_3 Depth 3
	or	a, a
	sbc	hl, hl
	push	hl
	push	hl
	call	_os_SetCursorPos
	pop	hl
	pop	hl
	ld	hl, _.str
	push	hl
	call	_os_PutStrFull
	pop	hl
	ld	hl, (ix - 26)
	push	hl
	call	_os_PutStrFull
	pop	hl
	ld	hl, _.str.2
	push	hl
	call	_os_PutStrFull
	pop	hl
	.local	.LBB0_3
.LBB0_3:                                ;   Parent Loop BB0_1 Depth=1
                                        ;     Parent Loop BB0_2 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	call	_os_GetCSC
	ld	e, a
	or	a, a
	jr	z, .LBB0_3
; %bb.4:                                ;   in Loop: Header=BB0_2 Depth=2
	ld	a, (ix - 20)
	cp	a, 45
	ld	l, -1
	jr	z, .LBB0_6
; %bb.5:                                ;   in Loop: Header=BB0_2 Depth=2
	ld	l, 0
	.local	.LBB0_6
.LBB0_6:                                ;   in Loop: Header=BB0_2 Depth=2
	ld	h, (ix - 23)                    ; 1-byte Folded Reload
	ld	a, h
	or	a, a
	ld	a, -1
	jr	nz, .LBB0_8
; %bb.7:                                ;   in Loop: Header=BB0_2 Depth=2
	ld	a, 0
	.local	.LBB0_8
.LBB0_8:                                ;   in Loop: Header=BB0_2 Depth=2
	and	a, l
	ld	l, a
	ld	b, 7
	call	__bshl
	rlc	a
	sbc	a, a
	ld	l, a
	ld	a, h
	add	a, l
	ld	d, a
	ld	l, -18
	ld	a, e
	add	a, l
	ld	l, a
	cp	a, 19
	jr	nc, .LBB0_11
; %bb.9:                                ;   in Loop: Header=BB0_2 Depth=2
	ld	bc, 493319
	xor	a, a
	call	__lshru
	bit	0, c
	jr	z, .LBB0_17
; %bb.10:                               ;   in Loop: Header=BB0_2 Depth=2
	ld	a, d
	cp	a, 6
	jr	nc, .LBB0_17
	jr	.LBB0_19
	.local	.LBB0_11
.LBB0_11:                               ;   in Loop: Header=BB0_2 Depth=2
	ld	a, h
	or	a, a
	jr	nz, .LBB0_13
; %bb.12:                               ;   in Loop: Header=BB0_2 Depth=2
	ld	a, e
	cp	a, 17
	jr	z, .LBB0_18
	.local	.LBB0_13
.LBB0_13:                               ;   in Loop: Header=BB0_2 Depth=2
	ld	a, h
	or	a, a
	jr	z, .LBB0_15
; %bb.14:                               ;   in Loop: Header=BB0_2 Depth=2
	ld	a, e
	cp	a, 56
	jr	z, .LBB0_20
	.local	.LBB0_15
.LBB0_15:                               ;   in Loop: Header=BB0_2 Depth=2
	ld	a, e
	cp	a, 9
	jr	nz, .LBB0_17
; %bb.16:                               ;   in Loop: Header=BB0_2 Depth=2
	ld	a, d
	or	a, a
	jr	nz, .LBB0_23
	.local	.LBB0_17
.LBB0_17:                               ; %.thread4
                                        ;   in Loop: Header=BB0_2 Depth=2
	ld	a, e
	cp	a, 15
	jp	nz, .LBB0_2
	jp	.LBB0_24
	.local	.LBB0_18
.LBB0_18:                               ;   in Loop: Header=BB0_1 Depth=1
	ld	(ix - 20), 45
	ld	iy, (ix - 29)
	ld	h, 1
	jr	.LBB0_22
	.local	.LBB0_19
.LBB0_19:                               ;   in Loop: Header=BB0_1 Depth=1
	ld	bc, 0
	push	bc
	pop	iy
	lea	de, iy + 0
	ld	e, l
	ld	hl, _switch.table.main
	add	hl, de
	ld	a, (hl)
	lea	de, iy + 0
	ld	e, (ix - 23)                    ; 1-byte Folded Reload
	inc	(ix - 23)
	ld	bc, (ix - 26)
	push	bc
	pop	hl
	add	hl, de
	ld	(hl), a
	lea	de, iy + 0
	ld	h, (ix - 23)                    ; 1-byte Folded Reload
	ld	e, h
	push	bc
	pop	iy
	jr	.LBB0_21
	.local	.LBB0_20
.LBB0_20:                               ;   in Loop: Header=BB0_1 Depth=1
	dec	h
	ld	de, 0
	ld	e, h
	ld	iy, (ix - 26)
	.local	.LBB0_21
.LBB0_21:                               ;   in Loop: Header=BB0_1 Depth=1
	add	iy, de
	.local	.LBB0_22
.LBB0_22:                               ;   in Loop: Header=BB0_1 Depth=1
	ld	(iy), 0
	jp	.LBB0_1
	.local	.LBB0_23
.LBB0_23:
	ld	hl, (ix - 26)
	push	hl
	call	_atoi
	ld	(ix - 23), hl
	pop	hl
	or	a, a
	sbc	hl, hl
	push	hl
	inc	hl
	push	hl
	call	_os_SetCursorPos
	pop	hl
	pop	hl
	ld	hl, (ix - 23)
	push	hl
	ld	hl, _.str.1
	push	hl
	ld	hl, (ix - 26)
	push	hl
	call	_boot_sprintf
	pop	hl
	pop	hl
	pop	hl
	ld	hl, (ix - 26)
	push	hl
	call	_os_PutStrFull
	pop	hl
	.local	.LBB0_24
.LBB0_24:                               ; =>This Inner Loop Header: Depth=1
	call	_os_GetCSC
	or	a, a
	jr	z, .LBB0_24
; %bb.25:
	or	a, a
	sbc	hl, hl
	ld	sp, ix
	pop	ix
	ret
	.local	.Lfunc_end0
.Lfunc_end0:
	.size	_main, .Lfunc_end0-_main
                                        ; -- End function
	.section	.rodata._.str,"a",@progbits
	.balign	1
	.local	_.str
_.str:
	.asciz	"num? "

	.section	.rodata._.str.1,"a",@progbits
	.balign	1
	.local	_.str.1
_.str.1:
	.asciz	"Score: %d"

	.section	.rodata._.str.2,"a",@progbits
	.balign	1
	.local	_.str.2
_.str.2:
	.asciz	"_ "

	.section	.rodata._switch.table.main,"a",@progbits
	.balign	1
	.local	_switch.table.main
_switch.table.main:
	.ascii	"3690000025800000147"

	.ident	"clang version 19.1.0 (https://github.com/CE-Programming/llvm-project ef28e9c54cd1333a6091ab2ffbd315b465fc5090)"
	.section	".note.GNU-stack","",@progbits
	.extern	_atoi
	.extern	_os_HomeUp
	.extern	_os_ClrLCD
	.extern	_llvm.eh.sjlj.functioncontext
	.extern	_os_GetCSC
	.extern	_llvm.eh.sjlj.callsite
	.extern	_llvm.eh.sjlj.setup.dispatch
	.extern	_llvm.stacksave.p0
	.extern	_llvm.lifetime.end.p0
	.extern	_os_SetCursorPos
	.extern	_llvm.lifetime.start.p0
	.extern	_llvm.eh.sjlj.lsda
	.extern	__Unwind_SjLj_Register
	.extern	_llvm.frameaddress.p0
	.extern	_os_DrawStatusBar
	.extern	__Unwind_SjLj_Unregister
	.extern	__lshru
	.extern	_os_PutStrFull
	.extern	__bshl
	.extern	_llvm.stackrestore.p0
	.extern	__frameset
	.extern	_boot_sprintf
