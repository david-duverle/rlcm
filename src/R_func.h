#include <R.h>

#define R_MODULE

void rsafe_fprintf (FILE *stream, const char *format, ...);
void rsafe_printf (const char*txt, ...);
void rsafe_putchar (char c);

#ifdef R_MODULE
    #include <R.h>
    #include <Rinternals.h>
#endif

