#ifndef	LibLZSS
#define	LibLZSS

//#ifdef __cplusplus
//extern "C" {
//#endif

#define LZSSEncodeVersionText	"4/6/1989"

extern int LZSSEncode(unsigned char *Src, int size, unsigned char MostCommon, unsigned char *Dest);

//#ifdef __cplusplus
//}
//#endif

#endif
