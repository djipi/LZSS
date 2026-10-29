#ifndef	LibLZSS
#define	LibLZSS

#define LZSSEncodeVersionText	"4/6/1989"

//#ifdef __cplusplus
//extern "C" {
//#endif

extern int LZSSEncode(unsigned char *Src, int size, unsigned char MostCommon, unsigned char *Dest);

//#ifdef __cplusplus
//}
//#endif

#endif
