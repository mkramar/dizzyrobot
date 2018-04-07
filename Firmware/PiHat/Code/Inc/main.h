#ifndef __MAIN_H
#define __MAIN_H

void _Error_Handler(char *, int);

#define Error_Handler() _Error_Handler(__FILE__, __LINE__)


#endif /* __MAIN_H */

