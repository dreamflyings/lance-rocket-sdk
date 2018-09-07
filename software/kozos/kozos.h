#ifndef _KOZOS_H_INCLUDED_
#define _KOZOS_H_INCLUDED_

#include "defines.h"
#include "syscall.h"

/*****************************************
 * システム・コール関連
 *****************************************/
/**
 * @brief スレッド起動
 *
 * @param func スレッドで実行する関数
 * @param name スレッド名
 * @param priority 優先度。値が低い方が優先される。
 * @param stacksize スレッドのスタックのサイズ(単位はバイト)
 * @param argc funcへの引数の数(main関数と同様)
 * @param argv funcへの引数(main関数と同様)
 */
kz_thread_id_t kz_run(kz_func_t func, char *name, int priority, int stacksize, int argc, char *argv[]);

/**
 * @brief スレッド終了
 */
void kz_exit(void);

/**
 * @brief スレッドの実行権を他に渡す。POSIXのsched_yield()みたいなもの。
 */
int kz_wait();

/**
 * @brief スレッドを待機状態に遷移する。kz_wakeup()で呼ばれるまで実行可能状態にはならない。
 */
int kz_sleep();

/**
 * @brief 指定したスレッドを実行可能状態に遷移させる。
 */
int kz_wakeup(kz_thread_id_t id);

/**
 * @brief 自スレッドのIDを取得する。
 */
kz_thread_id_t kz_getid();

/**
 * @brief 自スレッドの優先度を変更する。
 */
int kz_chpri(int priority);

/*****************************************
 * ライブラリ関数
 *****************************************/
/**
 * @brief 初期スレッドを起動して、OSの動作を開始する
 */
void kz_start(kz_func_t func, char *name, int priority, int statcksize, int argc, char *argv[]);

/**
 * @brief 致命的エラー発生時に呼び出す。
 */
void kz_sysdown(void);

/**
 * @brief システム・コールを実行する
 */
void kz_syscall(kz_syscall_type_t type, kz_syscall_param_t *param);

/**
 * @brief ユーザ・スレッド
 */
int test09_1_main(int argc, char *argv[]);
int test09_2_main(int argc, char *argv[]);
int test09_3_main(int argc, char *argv[]);

extern kz_thread_id_t test09_1_id;
extern kz_thread_id_t test09_2_id;
extern kz_thread_id_t test09_3_id;

#endif
