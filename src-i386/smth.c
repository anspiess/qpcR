void whittaker_C(double *w, double *y, double *z, double *lamb, int *mm,
             double *d, double *c)
/* Smoothing and interpolation with first differences.
   Input:  weights (w), data (y): vector from 1 to m.
   Input:  smoothing parameter (lambda), length (m).
   Input:  working arrays d and c (same length as y)
   Output: smoothed vector (z): vector from 1 to m. 
*/
{
  int i, i1, m;
  double lambda = *lamb;
  m = *mm - 1;
  d[0] = w[0] + lambda;
  c[0] = -lambda / d[0];
  z[0] = w[0] * y[0];
  for (i = 1; i < m; i++) {
    i1 = i - 1;
    d[i]= w[i] + 2 * lambda - c[i1] * c[i1] * d[i1];
    c[i] = -lambda / d[i];
    z[i] = w[i] * y[i] - c[i1] * z[i1];
  }
  d[m] = w[m] + lambda - c[m - 1] * c[m - 1] * d[m - 1];
  z[m] = (w[m] * y[m] - c[m - 1] * z[m - 1]) / d[m];
  for (i = m - 1; 0 <= i; i--) z[i] = z[i] / d[i] - c[i] * z[i + 1];
}

void EMA_C(double *y, double *z, double *alph, int *ny)
/* Exponential weighted moving average.
   Input:  data (y): vector from 1 to ny.
   Input:  data (z): empty vector from 1 to ny.   
   Input:  smoothing parameter (alpha).
   Input:  integer (ny): length of y.
   Output: smoothed vector (z): vector from 1 to m. 
*/
{
  int i, n;
  double alpha = *alph;
  n = *ny;
  
  z[0] = y[0];
  for (i = 1; i < n; i++) {
    z[i] = alpha * y[i] + (1 - alpha) * z[i - 1];
  }  
}
