// See LICENSE.SiFive for license details
// See LICENSE.HORIE_Tetsuya for license details

#define REGBYTES	4
	

.macro TRAP_ENTRY
	# 呼び出し側に保存責任があるレジスタを保存
	addi sp, sp, -17*REGBYTES

	sw x1,  0*REGBYTES(sp)
	sw x5,  1*REGBYTES(sp)
	sw x6,  2*REGBYTES(sp)
	sw x7,  3*REGBYTES(sp)
	sw x10, 4*REGBYTES(sp)
	sw x11, 5*REGBYTES(sp)
	sw x12, 6*REGBYTES(sp)
	sw x13, 7*REGBYTES(sp)
	sw x14, 8*REGBYTES(sp)
	sw x15, 9*REGBYTES(sp)
	sw x16, 10*REGBYTES(sp)
	sw x17, 11*REGBYTES(sp)
	sw x28, 12*REGBYTES(sp)
	sw x29, 13*REGBYTES(sp)
	sw x30, 14*REGBYTES(sp)
	sw x31, 15*REGBYTES(sp)
	
	# 割り込まれたPCをスタックに積む
	csrr t0, mepc
	sw t0, 16*REGBYTES(sp)

	# spをハンドラの第一引数に設定
	mv a0, sp
	
	# スタックを切り替え、旧のspをスタックに積む
	mv t0, sp
	la sp, intrstack
	addi sp, sp, -1*REGBYTES
	sw t0,  0*REGBYTES(sp)
.endm

.macro TRAP_EXIT
	# 元のスタックに切り戻す
	lw t0,  0*REGBYTES(sp)
	mv sp, t0
	
	# 割り込まれたPCを復元
	lw t0, 16*REGBYTES(sp)
	csrw mepc, t0

	# 呼び出し側に保存責任があるレジスタを復元	
	lw x1,  0*REGBYTES(sp)
	lw x5,  1*REGBYTES(sp)
	lw x6,  2*REGBYTES(sp)
	lw x7,  3*REGBYTES(sp)
	lw x10, 4*REGBYTES(sp)
	lw x11, 5*REGBYTES(sp)
	lw x12, 6*REGBYTES(sp)
	lw x13, 7*REGBYTES(sp)
	lw x14, 8*REGBYTES(sp)
	lw x15, 9*REGBYTES(sp)
	lw x16, 10*REGBYTES(sp)
	lw x17, 11*REGBYTES(sp)
	lw x28, 12*REGBYTES(sp)
	lw x29, 13*REGBYTES(sp)
	lw x30, 14*REGBYTES(sp)
	lw x31, 15*REGBYTES(sp)
	
	addi sp, sp, 17*REGBYTES
	
	mret
.endm	
	
	.section      	.text.entry	
	.align	 	8
	.global 	vtrap_entry
vtrap_entry: # ハンドラの実体にジャンプする
	j sync_trap
	.align 2
	j reserved
	.align 2
	j reserved
	.align 2
	j vmsi_Handler
	.align 2
	j reserved
	.align 2
	j reserved
	.align 2
	j reserved
	.align 2
	j vmti_Handler
	.align 2
	j reserved
	.align 2
	j reserved
	.align 2
	j reserved
	.align 2
	j vmei_Handler
	.align 2
	j reserved
	.align 2
	j reserved
	.align 2
	j reserved
	 .align 2
	j reserved
	.align 2
	j vlip_Handler0
	.align 2
	j vlip_Handler1
	.align 2
	j vlip_Handler2
	.align 2
	j vlip_Handler3
	.align 2
	j vlip_Handler4
	.align 2
	j vlip_Handler5
	.align 2
	j vlip_Handler6
	.align 2
	j vlip_Handler7
	.align 2
	j vlip_Handler8
	.align 2
	j vlip_Handler9
	.align 2
	j vlip_Handler10
	.align 2
	j vlip_Handler11
	.align 2
	j vlip_Handler12
	.align 2
	j vlip_Handler13
	.align 2
	j vlip_Handler14
	.align 2
	j vlip_Handler15

# スタック退避/復元ラッパー
#同期例外
sync_trap:
	TRAP_ENTRY
	jal handle_sync_trap
	TRAP_EXIT
	
#マシン・ソフトウェア割込み
vmsi_Handler:
	TRAP_ENTRY
	jal handle_m_software_interrupt
	TRAP_EXIT

#マシン・タイマー割込み
vmti_Handler:
	TRAP_ENTRY
	jal handle_m_time_interrupt
	TRAP_EXIT

#マシン外部割込み
vmei_Handler:
	TRAP_ENTRY
	jal handle_m_external_interrupt
	TRAP_EXIT

# ローカル割込みは使用しない	
#LIP0
vlip_Handler0:
	TRAP_ENTRY
	jal handle_local_interrupt0
	TRAP_EXIT

#LIP1
vlip_Handler1:
	TRAP_ENTRY
	jal handle_local_interrupt1
	TRAP_EXIT

#LIP2
vlip_Handler2:
	TRAP_ENTRY
	jal handle_local_interrupt2
	TRAP_EXIT

#LIP3
vlip_Handler3:
	TRAP_ENTRY
	jal handle_local_interrupt3
	TRAP_EXIT

#LIP4
vlip_Handler4:
	TRAP_ENTRY
	jal handle_local_interrupt4
	TRAP_EXIT

#LIP5
vlip_Handler5:
	TRAP_ENTRY
	jal handle_local_interrupt5
	TRAP_EXIT

#LIP6
vlip_Handler6:
	TRAP_ENTRY
	jal handle_local_interrupt6
	TRAP_EXIT

#LIP7
vlip_Handler7:
	TRAP_ENTRY
	jal handle_local_interrupt7
	TRAP_EXIT

#LIP8
vlip_Handler8:
	TRAP_ENTRY
	jal handle_local_interrupt8
	TRAP_EXIT

#LIP9
vlip_Handler9:
	TRAP_ENTRY
	jal handle_local_interrupt9
	TRAP_EXIT

#LIP10
vlip_Handler10:
	TRAP_ENTRY
	jal handle_local_interrupt10
	TRAP_EXIT

#LIP11
vlip_Handler11:
	TRAP_ENTRY
	jal handle_local_interrupt11
	TRAP_EXIT

#LIP12
vlip_Handler12:
	TRAP_ENTRY
	jal handle_local_interrupt12
	TRAP_EXIT

#LIP13
vlip_Handler13:
	TRAP_ENTRY
	jal handle_local_interrupt13
	TRAP_EXIT

#LIP14
vlip_Handler14:
	TRAP_ENTRY
	jal handle_local_interrupt14
	TRAP_EXIT

#LIP15
vlip_Handler15:
	TRAP_ENTRY
	jal handle_local_interrupt15
	TRAP_EXIT

#unimplemented ISRs trap here
.weak reserved
reserved:
.weak handle_sync_trap
handle_sync_trap:	
.weak handle_m_software_interrupt
handle_m_software_interrupt:
.weak handle_m_time_interrupt
handle_m_time_interrupt:
.weak handle_m_external_interrupt
handle_m_external_interrupt:
.weak handle_local_interrupt0
handle_local_interrupt0:
.weak handle_local_interrupt1
handle_local_interrupt1:
.weak handle_local_interrupt2
handle_local_interrupt2:
.weak handle_local_interrupt3
handle_local_interrupt3:
.weak handle_local_interrupt4
handle_local_interrupt4:
.weak handle_local_interrupt5
handle_local_interrupt5:
.weak handle_local_interrupt6
handle_local_interrupt6:
.weak handle_local_interrupt7
handle_local_interrupt7:
.weak handle_local_interrupt8
handle_local_interrupt8:
.weak handle_local_interrupt9
handle_local_interrupt9:
.weak handle_local_interrupt10
handle_local_interrupt10:
.weak handle_local_interrupt11
handle_local_interrupt11:
.weak handle_local_interrupt12
handle_local_interrupt12:
.weak handle_local_interrupt13
handle_local_interrupt13:
.weak handle_local_interrupt14
handle_local_interrupt14:
.weak handle_local_interrupt15
handle_local_interrupt15:
1:
	j 1b	