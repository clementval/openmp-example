program info_openmp
use omp_lib
integer :: nthreads, tid
integer :: i


print*,'Max threads=',omp_get_max_threads()

!$OMP PARALLEL PRIVATE(tid,nthreads)
!$OMP DO SCHEDULE(DYNAMIC,10)
DO i = 1, 100
  tid = omp_get_thread_num()
  nthreads = omp_get_num_threads()
  print*, nthreads, tid
END DO
!$OMP END DO
!$OMP END PARALLEL

end program info_openmp
