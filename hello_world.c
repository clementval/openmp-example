#include <stdio.h>
#include <omp.h>

int main(){

  #pragma omp parallel num_threads(8)
  {
    int id = omp_get_thread_num();
    
    printf("hello(%d)\n", id);
    printf("world(%d)\n", id);
  }
}
