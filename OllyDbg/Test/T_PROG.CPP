#define STRICT

#include <windows.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <math.h>

#include "test.h"

// Procedures that illustrate analysis features.

int _export Nestedloops(void) {
  int i,j,k,l,m,n;
  n=0;
  for (i=0; i<10; i++) {
    for (j=0; j<10; j++) {
      for (k=0; k<10; k++) {
        for (l=0; l<10; l++) {
          for (m=0; m<10; m++) {
            n++;
          };
        };
      };
    };
  };
  return n;
};

int _export Sum(int x,int y) {
  return x+y;
};

int _export Nestedcalls(void) {
  int n;
  n=Sum(Sum(Sum(1,2),Sum(3,4)),Sum(Sum(5,6),Sum(7,8)));
  n+=MulDiv(MulDiv(1,1,1),MulDiv(1,1,1),MulDiv(1,1,1));
  return n;
};

static float       pi         = M_PI;
static double      e          = M_E;
static long double oneseventh = 1.0L/7.0L;

double _export Floatingargs(float x,double y,long double z) {
  if (x<0.0) return 0.0;
  if (x<=1.0) return 1.0;
  if (x!=2.0) return 2.0;
  if (x>3.0) return 3.0;
  if (x>=4.0) return 4.0;
  if (x==5.0) return 5.0;
  return x+y+z;
};

double _export Floatingcall(void) {
  return Floatingargs(pi+1,e+1,oneseventh+1);
};
