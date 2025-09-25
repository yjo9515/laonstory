
#include <jni.h>

#ifndef _Included_com_laonstory_linenseoul_ModuleAPI
#define _Included_com_laonstory_linenseoul_ModuleAPI
#ifdef __cplusplus
extern "C" {
#endif

  JNIEXPORT jint JNICALL Java_com_laonstory_linenseoul_ModuleAPI_SerailOpen(JNIEnv* env, jobject thiz, jstring uart,jint baudrate, jint databits,jint stopbits, jint check) ;
  JNIEXPORT jint JNICALL Java_com_laonstory_linenseoul_ModuleAPI_SerailClose(JNIEnv *env, jobject thiz,int uart_fd) ;
  JNIEXPORT jint JNICALL Java_com_laonstory_linenseoul_ModuleAPI_SerailSendData(JNIEnv *env, jobject thiz, int uart_fd,jbyteArray send_data,jint Len) ;
  JNIEXPORT jint JNICALL Java_com_laonstory_linenseoul_ModuleAPI_SerailReceive(JNIEnv *env, jobject thiz, jint uart_fd,jbyteArray receive_data,jint Len);
  JNIEXPORT jint JNICALL Java_com_laonstory_linenseoul_ModuleAPI_CalcCRC(JNIEnv *env, jobject thiz, jbyteArray data, jint data_len,jbyteArray out_crc) ;

#ifdef __cplusplus
}
#endif
#endif

