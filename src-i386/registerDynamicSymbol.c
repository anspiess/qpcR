#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

/* FIXME:
  Check these declarations against the C/Fortran source code.
*/
  
  /* .Call calls */
extern SEXP whittaker_C(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP EMA_C(SEXP, SEXP, SEXP, SEXP);

static const R_CallMethodDef CallEntries[] = {
  {"whittaker_C", (DL_FUNC) &whittaker_C, 7},
  {"EMA_C", (DL_FUNC) &EMA_C, 4},
  {NULL, NULL, 0}
};

void R_init_qpcR(DllInfo *dll)
{
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}