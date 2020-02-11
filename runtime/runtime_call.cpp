#include <cassert>
#include <iostream>
#include "omp.h"

#define N 10

int main() {

  float a[N];

  for (int i = 0; i < N; ++i) {
    a[i] = 1.5;
  }

  int devices = omp_get_num_devices();
  std::cout << "NUMBER OF DEVICES: " << devices << std::endl;
  assert(devices >= 1);

  int default_device = omp_get_default_device();
  std::cout << "DEFAULT DEVICE: " << default_device << std::endl;

  int initial_device = omp_get_initial_device();
  std::cout << "INITIAL DEVICE: " << initial_device << std::endl;

  assert(omp_target_is_present(a, default_device) == 0);
  void *a_dptr = omp_target_alloc(sizeof(float) * N, default_device);
  omp_target_associate_ptr(a, a_dptr, sizeof(float) * N, 0, default_device);
  assert(omp_target_is_present(a, default_device) != 0);

  omp_target_memcpy(a_dptr, a, sizeof(float) * N, 0, 0, default_device,
                    initial_device);
  omp_target_memcpy(a, a_dptr, sizeof(float) * N, 0, 0, initial_device,
                    default_device);

  for (int i = 0; i < N; ++i) {
    assert(a[i] == 1.5);
  }

  omp_target_disassociate_ptr(a, default_device);
  omp_target_free(a_dptr, default_device);
  assert(omp_target_is_present(a, default_device) == 0);

  return 0;
}
