GAME: {
	Settings: {
		currentLevel: .byte $00
	}

	Start: {

		lda Settings.currentLevel
		bne !+
			lda #$00
			ldx #$09		//Force mc in every square
			jsr ClearScreen
			jsr HUD.Init
	!:
		jsr CONTROL.Init
		jsr LASERS.Init

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
			jsr LEVEL.Update
			jsr LASERS.Update
			jsr HUD.Update

			jsr KEYBOARD.Update
			//IT WAS MY BIRTHDAY RIGHT HERE!!!!!!!

			// lda #$00
			// sta ZP.DrawNoColor

		jmp !Loop-
	}

}