program info_openmp
use omp_lib
integer :: nthreads, tid
integer :: i


print*,'Max threads=',omp_get_max_threads()

!$OMP PARALLEL DO PRIVATE(tid,nthreads)
DO i = 1, 100
  tid = omp_get_thread_num()
  nthreads = omp_get_num_threads()
  print*,'I am thread ', tid, ', I do iteration ', i
END DO
!$OMP END PARALLEL DO

end program info_openmp
