; ---------------------------------------------------------------------------
; Fast IEEE-754 single-precision add, subtract, multiply, divide and compare
; for the eZ80 (TI-84 Plus CE), replacing the boot-ROM routines the C
; compiler calls (__fadd, __fsub, __fmul, __fdiv, __fcmp).
;
; Results are correctly rounded (round to nearest, ties to even) and match
; desktop IEEE arithmetic bit for bit for normal numbers and zeros.  Inputs are
; assumed to be normal or zero (the grapher never makes infinities, NaNs or
; denormals); a result too small to be normal becomes a signed zero and one too
; large becomes a signed infinity.
;
; Calling convention (from the compiler):
;   __fadd/__fsub/__fmul/__fdiv:  A:UBC = A:UBC op E:UHL.  Everything except
;                                 A, BC and F is preserved.
;   __fcmp:  compares E:UHL with A:UBC.  S set if E:UHL < A:UBC, Z set if equal.
;            Everything except F is preserved.
; ---------------------------------------------------------------------------

	.assume	ADL = 1

	.section .bss.ffloat,"aw",@nobits
; scratch block, addressed through IX
;  +0..3   operand a (little endian)        +4..7   operand b
;  +8..13  product bytes / add frame A       +12..15 add frame B
;  +16..19 add result                        +20..23 spare, +23 kept zero
ffs:	.skip	24
ffexp:	.skip	3		; result exponent, 24-bit signed
ffsign:	.skip	1		; result sign in bit 7
ffstk:	.skip	1		; sticky bits gathered while shifting
ffa:	.skip	1		; saved A for __fcmp
	.equ	FSIGN, 27		; ffsign - ffs, for IX addressing

	.ifdef	FF_COUNT
	.global	ffcount
ffcount: .skip	15		; call counters (emulator builds only)
	.endif

	.section .text.ffloat,"ax",@progbits

.macro	FCOUNT n
	.ifdef	FF_COUNT
	push	hl
	ld	hl, (ffcount + 3 * \n)
	inc	hl
	ld	(ffcount + 3 * \n), hl
	pop	hl
	.endif
.endm

; ---------------------------------------------------------------------------
; pack: build the result in A:UBC from
;   HL     = 24-bit mantissa with bit 23 set
;   ffexp  = biased exponent (24-bit signed, any value)
;   ffsign = sign in bit 7
; then restore IX, DE, HL and return to the caller of the float routine.
; ---------------------------------------------------------------------------
.Lpack:
	ld	(ix + 20), hl
	ld	a, (ix + 25)		; exponent above 255 or below 0?
	or	a, a
	jr	nz, .Lpack_big
	ld	a, (ix + 24)
	dec	a
	cp	a, 254
	jr	nc, .Lpack_edge		; exponent 0 or 255
	inc	a
	ld	c, (ix + 22)
	sla	c			; drop the hidden bit,
	srl	a			; put exponent bit 0 in its place
	rr	c
	ld	(ix + 22), c
	ld	bc, (ix + 20)
	or	a, (ix + FSIGN)
	jr	.Lret
.Lpack_big:
	jp	m, .Lzero		; negative exponent: underflow
	jr	.Linf
.Lpack_edge:
	inc	a
	jr	z, .Lzero		; exponent 0
.Linf:
	ld	bc, 0x800000
	ld	a, (ffsign)
	or	a, 0x7F
	jr	.Lret
.Lzero:
	ld	bc, 0
	ld	a, (ffsign)
.Lret:
	pop	ix
	pop	de
	pop	hl
	ret

; ---------------------------------------------------------------------------
; save registers, copy operands into the scratch block, IX -> scratch
; ---------------------------------------------------------------------------
.macro	FENTER
	push	hl
	push	de
	push	ix
	ld	ix, ffs
	ld	(ix + 0), bc
	ld	(ix + 3), a
	ld	(ix + 4), hl
	ld	(ix + 7), e
.endm

; exponent of the operand at (ix + off) into A (0 means zero); sets the hidden bit
.macro	FEXP off
	ld	a, (ix + \off + 2)
	rla
	ld	a, (ix + \off + 3)
	rla
	set	7, (ix + \off + 2)
.endm

; ===========================================================================
	.global	__fmul
	.type	__fmul, @function
__fmul:
	FCOUNT	0
	FENTER
	ld	a, (ix + 3)
	xor	a, (ix + 7)
	and	a, 0x80
	ld	(ffsign), a
	ld	hl, 0
	FEXP	0
	or	a, a
	jp	z, .Lzero
	ld	l, a
	FEXP	4
	or	a, a
	jp	z, .Lzero
	ld	de, 0
	ld	e, a
	add	hl, de
	ld	de, -126
	add	hl, de
	ld	(ix + 24), hl		; exponent (ffexp)

	; 24 x 24 -> 48-bit product, one byte column at a time
	ld	bc, 0
	ld	(ix + 23), b		; zero byte above the shift window
	ld	b, (ix + 0)
	ld	c, (ix + 4)
	mlt	bc
	ld	(ix + 8), c
	ld	hl, 0
	ld	l, b
	ld	b, (ix + 1)		; column 1
	ld	c, (ix + 4)
	mlt	bc
	add	hl, bc
	ld	b, (ix + 0)
	ld	c, (ix + 5)
	mlt	bc
	add	hl, bc
	ld	(ix + 9), l
	ld	(ix + 20), hl
	ld	hl, (ix + 21)
	ld	b, (ix + 2)		; column 2
	ld	c, (ix + 4)
	mlt	bc
	add	hl, bc
	ld	b, (ix + 1)
	ld	c, (ix + 5)
	mlt	bc
	add	hl, bc
	ld	b, (ix + 0)
	ld	c, (ix + 6)
	mlt	bc
	add	hl, bc
	ld	(ix + 10), l
	ld	(ix + 20), hl
	ld	hl, (ix + 21)
	ld	b, (ix + 2)		; column 3
	ld	c, (ix + 5)
	mlt	bc
	add	hl, bc
	ld	b, (ix + 1)
	ld	c, (ix + 6)
	mlt	bc
	add	hl, bc
	ld	(ix + 11), l
	ld	(ix + 20), hl
	ld	hl, (ix + 21)
	ld	b, (ix + 2)		; column 4
	ld	c, (ix + 6)
	mlt	bc
	add	hl, bc
	ld	(ix + 12), hl		; bytes 12, 13 (14 gets the zero upper byte)
	ld	hl, (ix + 11)		; top 24 bits of the product
	bit	7, (ix + 13)
	jr	nz, .Lmul_norm
	sla	(ix + 10)		; product < 2^47: shift left one
	adc	hl, hl
	ld	de, (ix + 24)
	dec	de
	ld	(ix + 24), de
.Lmul_norm:
	ld	a, (ix + 10)		; round bit and the bits below it
	add	a, a
	jp	nc, .Lpack
	or	a, (ix + 9)
	or	a, (ix + 8)
	jr	nz, .Lround_up
	bit	0, l			; exact tie: round to even
	jp	z, .Lpack
.Lround_up:
	ld	de, 1
	add	hl, de
	jp	nc, .Lpack
	ld	hl, 0x800000		; mantissa overflowed
	ld	de, (ix + 24)
	inc	de
	ld	(ix + 24), de
	jp	.Lpack

; ===========================================================================
	.global	__fdiv
	.type	__fdiv, @function
__fdiv:
	FCOUNT	1
	FENTER
	ld	a, (ix + 3)
	xor	a, (ix + 7)
	and	a, 0x80
	ld	(ffsign), a
	ld	hl, 0
	FEXP	4
	or	a, a
	jp	z, .Linf		; divide by zero
	ld	e, a			; E = exponent of b
	FEXP	0
	or	a, a
	jp	z, .Lzero
	ld	l, a
	ld	a, e
	ld	de, 0
	ld	e, a
	or	a, a
	sbc	hl, de
	ld	de, 127
	add	hl, de
	ld	(ffexp), hl		; ea - eb + 127

	ld	hl, (ix + 0)		; R = mantissa a
	ld	de, (ix + 4)		; mantissa b
	or	a, a
	sbc	hl, de
	jr	nc, .Ldiv_first		; a >= b: first quotient bit is 1, R = a - b
	add	hl, de			; a < b: R = 2a - b
	add	hl, hl
	or	a, a
	sbc	hl, de
	push	hl
	ld	hl, (ffexp)
	dec	hl
	ld	(ffexp), hl
	pop	hl
.Ldiv_first:
	push	iy
	ld	iy, 1			; quotient so far
	ld	b, 23
.Ldiv_loop:
	add	hl, hl
	jr	c, .Ldiv_sub
	or	a, a
	sbc	hl, de
	jr	nc, .Ldiv_one
	add	hl, de
	add	iy, iy
	djnz	.Ldiv_loop
	jr	.Ldiv_round
.Ldiv_sub:
	or	a, a
	sbc	hl, de
.Ldiv_one:
	add	iy, iy
	inc	iy
	djnz	.Ldiv_loop
.Ldiv_round:
	; one more step gives the round bit; what is left decides the sticky bit
	add	hl, hl
	jr	c, .Ldiv_r1
	or	a, a
	sbc	hl, de
	jr	nc, .Ldiv_r1b
	lea	hl, iy + 0		; round bit 0: truncate
	pop	iy
	jp	.Lpack
.Ldiv_r1:
	or	a, a
	sbc	hl, de
.Ldiv_r1b:
	ld	de, 0			; round bit 1: sticky = remainder != 0
	or	a, a
	sbc	hl, de
	lea	hl, iy + 0
	pop	iy
	jp	nz, .Lround_up
	bit	0, l
	jp	z, .Lpack
	jp	.Lround_up

; ===========================================================================
	.global	__fsub
	.type	__fsub, @function
__fsub:
	FCOUNT	2
	push	hl
	push	de
	push	ix
	ld	d, a
	ld	a, e			; flip the sign of b and add
	xor	a, 0x80
	ld	e, a
	ld	a, d
	jr	.Ladd

	.global	__fadd
	.type	__fadd, @function
__fadd:
	FCOUNT	3
	push	hl
	push	de
	push	ix
.Ladd:
	ld	ix, ffs
	; store the operands so that |a| >= |b|: compare the magnitudes first,
	; giving b's top byte a's sign bit so the sign bits cancel
	ld	d, a
	xor	a, e
	and	a, 0x80
	xor	a, e
	push	hl
	sbc	hl, bc			; carry is clear after the xor
	sbc	a, d			; carry set if |b| < |a|
	pop	hl
	jr	c, .Ladd_ab
	ld	(ix + 0), hl		; |b| >= |a|: swap them
	ld	(ix + 3), e
	ld	(ix + 4), bc
	ld	(ix + 7), d
	jr	.Ladd_ordered
.Ladd_ab:
	ld	(ix + 0), bc
	ld	(ix + 3), d
	ld	(ix + 4), hl
	ld	(ix + 7), e
.Ladd_ordered:
	ld	a, (ix + 3)
	and	a, 0x80
	ld	(ix + FSIGN), a
	ld	a, (ix + 6)		; exponent of b
	rla
	ld	a, (ix + 7)
	rla
	or	a, a
	jr	nz, .Ladd_bnz
	; b is zero: the answer is a, except +0 + -0 = +0
	ld	a, (ix + 3)
	and	a, 0x7F
	or	a, (ix + 2)
	or	a, (ix + 1)
	or	a, (ix + 0)
	jr	nz, .Ladd_reta
	ld	a, (ix + 7)
	and	a, (ix + 3)
	and	a, 0x80
	ld	bc, 0
	jp	.Lret
.Ladd_bnz:
	ld	c, a			; C = eb
	ld	a, (ix + 2)		; exponent of a (not zero, since |a| >= |b| > 0)
	rla
	ld	a, (ix + 3)
	rla
	ld	(ix + 8), a		; keep ea
	sub	a, c			; d = ea - eb
	cp	a, 26
	jr	c, .Ladd_near
.Ladd_reta:
	ld	bc, (ix + 0)		; b is zero or too small to matter: return a
	ld	a, (ix + 3)
	jp	.Lret
.Ladd_near:
	; b's mantissa in D:H:L with an extra byte C below it; bits shifted out
	; of C are gathered in E as a sticky bit
	ld	b, a
	set	7, (ix + 2)		; hidden bit of a
	ld	a, (ix + 6)
	or	a, 0x80			; hidden bit of b
	ld	d, a
	ld	hl, (ix + 4)
	ld	c, 0
	ld	e, c
	ld	a, b
	cp	a, 8
	jr	c, .Ladd_bits
.Ladd_bytes:				; shift right by whole bytes
	ld	b, a
	ld	a, e
	or	a, c
	ld	e, a
	ld	c, l
	ld	l, h
	ld	h, d
	ld	d, 0
	ld	a, b
	sub	a, 8
	cp	a, 8
	jr	nc, .Ladd_bytes
.Ladd_bits:
	ld	b, a
	xor	a, a
	or	a, b
	jr	z, .Ladd_shifted
	xor	a, a
.Ladd_bitloop:
	srl	d
	rr	h
	rr	l
	rr	c
	adc	a, 0			; count bits that fall off the end
	djnz	.Ladd_bitloop
.Ladd_shifted:
	or	a, e
	jr	z, .Ladd_nostk
	set	0, c			; sticky bit
.Ladd_nostk:
	ld	e, 0			; E = exponent change from here on
	ld	a, (ix + 3)
	xor	a, (ix + 7)
	jp	m, .Ladd_sub
	; same signs: add the mantissas
	ld	a, (ix + 0)
	add	a, l
	ld	l, a
	ld	a, (ix + 1)
	adc	a, h
	ld	h, a
	ld	a, (ix + 2)
	adc	a, d
	ld	d, a
	jr	nc, .Ladd_round
	rr	d			; carry out: shift right one, keep sticky
	rr	h
	rr	l
	rr	c
	jr	nc, .Ladd_inc
	set	0, c
.Ladd_inc:
	inc	e
	jr	.Ladd_round
.Ladd_sub:
	xor	a, a
	sub	a, c
	ld	c, a
	ld	a, (ix + 0)
	sbc	a, l
	ld	l, a
	ld	a, (ix + 1)
	sbc	a, h
	ld	h, a
	ld	a, (ix + 2)
	sbc	a, d
	ld	d, a
	or	a, h
	or	a, l
	or	a, c
	jr	nz, .Ladd_norm
	ld	bc, 0			; exact cancellation gives +0
	xor	a, a
	jp	.Lret
.Ladd_norm:				; shift left until bit 7 of D is set
	ld	a, d
	or	a, a
	jr	nz, .Ladd_nbit
	ld	d, h
	ld	h, l
	ld	l, c
	ld	c, 0
	ld	a, e
	sub	a, 8
	ld	e, a
	jr	.Ladd_norm
.Ladd_nbit:
	bit	7, d
	jr	nz, .Ladd_round
	sla	c
	rl	l
	rl	h
	rl	d
	dec	e
	jr	.Ladd_nbit
.Ladd_round:
	ld	a, c			; round bit and the bits below it
	add	a, a
	jr	nc, .Ladd_pack
	jr	nz, .Ladd_up
	bit	0, l			; exact tie: round to even
	jr	z, .Ladd_pack
.Ladd_up:
	inc	l
	jr	nz, .Ladd_pack
	inc	h
	jr	nz, .Ladd_pack
	inc	d
	jr	nz, .Ladd_pack
	ld	d, 0x80			; mantissa overflowed
	inc	e
.Ladd_pack:				; mantissa D:H:L, exponent ea + E
	ld	a, (ix + 8)
	bit	7, e
	jr	nz, .Ladd_eneg
	add	a, e
	jp	c, .Linf
	cp	a, 255
	jp	z, .Linf
	jr	.Ladd_eok
.Ladd_eneg:
	add	a, e
	jp	nc, .Lzero
	jp	z, .Lzero
.Ladd_eok:
	sla	d			; drop the hidden bit,
	srl	a			; put exponent bit 0 in its place
	rr	d
	ld	(ix + 20), hl
	ld	(ix + 22), d
	ld	bc, (ix + 20)
	or	a, (ix + FSIGN)
	jp	.Lret

; ===========================================================================
	.global	__fcmp
	.type	__fcmp, @function
__fcmp:
	FCOUNT	4
	push	hl
	push	de
	ld	d, a			; D = top byte of y (A comes back from it)
	ld	a, e
	xor	a, d
	jp	m, .Lcmp_signs
	or	a, a
	sbc	hl, bc			; magnitudes, x - y over 32 bits (equal sign bits cancel)
	ld	a, e
	jr	nz, .Lcmp_ne
	sbc	a, d
	jr	z, .Lcmp_eq
	jr	.Lcmp_ord
.Lcmp_ne:
	sbc	a, d			; carry set if |x| < |y|
.Lcmp_ord:
	bit	7, e
	jr	nz, .Lcmp_neg
	jr	c, .Lcmp_lt
	jr	.Lcmp_gt
.Lcmp_neg:
	jr	c, .Lcmp_gt
	jr	.Lcmp_lt
.Lcmp_signs:				; signs differ: equal only for +0 and -0
	ld	a, e
	and	a, 0x7F
	jr	nz, .Lcmp_nz
	ld	a, d
	and	a, 0x7F
	jr	nz, .Lcmp_nz
	or	a, a
	adc	hl, bc			; both low parts zero?
	jr	c, .Lcmp_nz
	jr	z, .Lcmp_eq
.Lcmp_nz:
	bit	7, e			; the negative one is smaller
	jr	z, .Lcmp_gt
.Lcmp_lt:
	ld	a, 0x80
	or	a, a			; S = 1, Z = 0
	jr	.Lcmp_out
.Lcmp_gt:
	ld	a, 1
	or	a, a			; S = 0, Z = 0
	jr	.Lcmp_out
.Lcmp_eq:
	xor	a, a			; S = 0, Z = 1
.Lcmp_out:
	ld	a, d
	pop	de
	pop	hl
	ret
