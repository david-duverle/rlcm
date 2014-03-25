
#include <stdarg.h>

#ifdef R_MODULE

#include <R.h>


void rsafe_fprintf (FILE *stream, const char *format, ...) {
   va_list args;
   va_start(args, format); 

   if (stream == stdout)
       Rvprintf(format, args); 
   else if (stream == stderr) 
       REvprintf(format, args); 
   else 
       vfprintf(stream, format, args); 

   va_end(args); 
} 

void rsafe_printf (const char*txt, ...) {
    va_list args;
    va_start(args, format);
    Rvprintf(format, args);    
    va_end(args);
}

void rsafe_putchar (char c) {
    Rprintf("%c", c);
}

#else

#include <stdio.h>
#include <stdlib.h>

void rsafe_fprintf (FILE *stream, const char *format, ...) {
    va_list argptr;
    va_start(argptr, format);
    vfprintf(stream, format, argptr);
    va_end(argptr);
}

void rsafe_printf (const char* format, ...) {
    va_list argptr;
    va_start(argptr, format);
    vfprintf(stderr, format, argptr);
    va_end(argptr);
}

void rsafe_putchar (char c) {
    putchar(c);
}

#endif