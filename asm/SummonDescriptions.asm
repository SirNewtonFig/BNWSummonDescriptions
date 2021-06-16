hirom

!freeC3_A = $C33BDE   ; 18 bytes, we'll use 17 :)
; !freeC3_B = $C3F46B   ; 21 bytes, just what we need :O
!freeC3_B = $C38777   ; 29 bytes, we'll use 24 >.>

!freeXL = $C48270     ; big ol' chunk of freespace :D
!freeXLbank = $C4    ; if freeXL changes, change this accordingly

table c3.tbl,rtl

org $C35BA6
  JSR LoadDescription

org !freeC3_A
LoadDescription:
  LDA $4B             ; On esper name?
  BEQ .esper          ; Branch if so
  CMP #$06            ; On bonus?
  BEQ .bonus          ; Branch if so
  JMP $5BE3           ; Load magic description
.esper
  JMP SummonDescription
.bonus
  JMP $5BF6           ; Load EL description

org !freeC3_B
SummonDescription:    ; Load Esper summon description
  LDX #EsperDescPointers
  STX $E7             ; Set ptr loc LBs
  LDX $00
  STX $EB             ; Set text loc LBs
  LDA #!freeXLbank    ; Pointer/text bank
  STA $E9             ; Set ptr loc HB
  STA $ED             ; Set text loc HB
  LDA #$10
  TRB $45             ; Description: On
  LDX #$3940          ; Batshit compatibility shim for esper restrictions handler
  RTS

org $C358B9
  JSL InitEsperDataSlice

org !freeXL

InitEsperDataSlice:
  LDA #$10            ; Reset/Stop desc
  TSB $45             ; Set menu flag
  LDA $49             ; Top BG1 write row
  STA $5F             ; Save for return
  RTL

EsperDescPointers:
  dw Ramuh
  dw Ifrit
  dw Shiva
  dw Siren
  dw Terrato
  dw Shoat
  dw Maduin
  dw Bismark
  dw Stray
  dw Palidor
  dw Tritoch
  dw Odin
  dw Loki
  dw Bahamut
  dw Crusader
  dw Ragnarok
  dw Alexandr
  dw Kirin
  dw Zoneseek
  dw Carbunkl
  dw Phantom
  dw Seraph
  dw Golem
  dw Unicorn
  dw Fenrir
  dw Starlet
  dw Phoenix

Ramuh: db "Bolt damage - all foes",$00
Ifrit: db "Fire damage - all foes",$00
Shiva: db "Ice damage - all foes",$00
Siren: db "Sets `Bserk^ - all foes",$00
Terrato: db "Earth damage - all foes",$00
Shoat: db "Sets `Petrify^ - all foes",$00
Maduin: db "Wind damage - all foes|Ignores def.",$00
Bismark: db "Water damage - all foes",$00
Stray: db "Stamina-based cure - party|Sets `Regen^",$00
Palidor: db "Party attacks with `Jump^",$00
Tritoch: db "Fire",$C0,"Ice",$C0,"Bolt damage - all foes",$00
Odin: db "Non-elemental dmg - all foes|Stamina-based; ignores def.",$00
Loki: db $00
Bahamut: db "Non-elemental dmg - all foes|Ignores def.",$00
Crusader: db "Dark damage - all foes",$00
Ragnarok: db "Non-elemental dmg - one foe|(Damage = 9;999)",$00
Alexandr: db "Holy damage - all foes",$00
Kirin: db "Cures HP - party|Revives fallen allies",$00
Zoneseek: db "Sets `Shell^ - party",$00
Carbunkl: db "Sets `Rflect^ - party",$00
Phantom: db "Sets `Vanish^ - party",$00
Seraph: db "Sets `Rerise^ - party",$00
Golem: db "Blocks physical attacks|(Durability = caster*s max HP)",$00
Unicorn: db "Stamina-based cure - party|Lifts most bad statuses",$00
Fenrir: db "Sets `Image^ - party",$00
Starlet: db "Cures HP to max - party|Lifts all bad statuses",$00
Phoenix: db "Revives fallen allies - party|(HP = max)",$00

warnpc $C487BF
