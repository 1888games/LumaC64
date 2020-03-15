HUD: {
	Init: {

			lda #<[SCREEN_RAM + 30]
			sta HudMod + 1
			lda #>[SCREEN_RAM + 30]
			sta HudMod + 2
			lda #<[COLOR_RAM + 30]
			sta ColMod + 1
			lda #>[COLOR_RAM + 30]
			sta ColMod + 2

			ldx #$00
			ldy #$00
		!loop:	
			lda HUD_MAP, x
		HudMod:
			sta $BEEF, y
			stx ZP.HudCharTemp
			tax
			lda CHAR_COLORS, x
			ldx ZP.HudCharTemp
		ColMod:
			sta $BEEF, y

			iny
			cpy #$0a
			bne !+

			ldy #$00
			lda HudMod + 1
			clc
			adc #$28
			sta HudMod + 1
			sta ColMod + 1
			lda HudMod + 2
			adc #$00
			sta HudMod + 2
			clc
			adc #>[COLOR_RAM - SCREEN_RAM]
			sta ColMod + 2
		!:
			inx
			cpx #$f0
			bne !loop-

			rts
	}

	Update: {


			lda LEVEL.MovesRemaining
		//Hundreds
			ldx #$00
		!:
			cmp #$64
			bcc !+
			inx
			sec
			sbc #$64
			jmp !-
		!:
			pha
			txa
			clc
			adc #$e0
			sta SCREEN_RAM + $0e * $28 + $22
			clc
			adc #$10
			sta SCREEN_RAM + $0f * $28 + $22
			pla


			ldx #$00
		!:
			cmp #$0a
			bcc !+
			inx
			sec
			sbc #$0a
			jmp !-
		!:
			pha
			txa
			clc
			adc #$e0
			sta SCREEN_RAM + $0e * $28 + $23
			clc
			adc #$10
			sta SCREEN_RAM + $0f * $28 + $23
			pla

			clc
			adc #$e0
			sta SCREEN_RAM + $0e * $28 + $24
			clc
			adc #$10
			sta SCREEN_RAM + $0f * $28 + $24

			rts
	}
}