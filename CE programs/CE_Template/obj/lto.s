	.section	.text,"ax",@progbits
	.assume	ADL = 1
	.file	"llvm-link"
	.section	.text._main,"ax",@progbits
	.globl	_main                           ; -- Begin function main
	.type	_main,@function
_main:                                  ; @main
; %bb.0:
	call	_gfx_Begin
	ld	hl, 1
	push	hl
	call	_gfx_SetDraw
	pop	hl
	.local	.LBB0_1
.LBB0_1:                                ; =>This Inner Loop Header: Depth=1
	call	_kb_Scan
	ld	hl, 255
	push	hl
	call	_gfx_FillScreen
	pop	hl
	or	a, a
	sbc	hl, hl
	push	hl
	call	_gfx_SetTextFGColor
	pop	hl
	ld	hl, 8
	push	hl
	push	hl
	ld	hl, _.str
	push	hl
	call	_gfx_PrintStringXY
	pop	hl
	pop	hl
	pop	hl
	call	_gfx_SwapDraw
	ld	hl, -720868
	push	de
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	l, e
	ld	h, d
	pop	de
	ld	a, l
	bit	6, a
	jr	z, .LBB0_1
; %bb.2:
	call	_gfx_End
	or	a, a
	sbc	hl, hl
	ret
	.local	.Lfunc_end0
.Lfunc_end0:
	.size	_main, .Lfunc_end0-_main
                                        ; -- End function
	.section	.rodata._.str,"a",@progbits
	.balign	1
	.local	_.str
_.str:
	.asciz	"Hello, CE!"

	.ident	"clang version 19.1.0 (https://github.com/CE-Programming/llvm-project ef28e9c54cd1333a6091ab2ffbd315b465fc5090)"
	.section	".note.GNU-stack","",@progbits
	.extern	__Unwind_SjLj_Unregister
	.extern	_gfx_FillScreen
	.extern	_llvm.stackrestore.p0
	.extern	_llvm.eh.sjlj.functioncontext
	.extern	_gfx_End
	.extern	_llvm.eh.sjlj.setup.dispatch
	.extern	_gfx_SetDraw
	.extern	_llvm.stacksave.p0
	.extern	_llvm.eh.sjlj.callsite
	.extern	_kb_Scan
	.extern	_gfx_SetTextFGColor
	.extern	_gfx_SwapDraw
	.extern	_llvm.eh.sjlj.lsda
	.extern	_gfx_PrintStringXY
	.extern	_gfx_Begin
	.extern	__Unwind_SjLj_Register
	.extern	_llvm.frameaddress.p0
