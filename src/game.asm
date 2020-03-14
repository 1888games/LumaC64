GAME: {
	Settings: {
		currentLevel: .byte $00
	}

	Start: {
		jsr CONTROL.Init

		lda Settings.currentLevel
		jsr LEVEL.LoadLevel
		jsr LEVEL.DrawLevel

				//Level testing debug code
				// lda #$10
				// bit $dc00
				// bne *-3
				// bit $dc00
				// beq *-3

				// inc Settings.currentLevel
				// jmp Start

	!Loop:
		lda IRQ.FrameFlag
		beq !Loop-
		lda #$00
		sta IRQ.FrameFlag

			jsr CONTROL.Update

		jmp !Loop-
	}

}